import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:codebook/db/db.dart';
import 'package:codebook/db/ingredient.dart';
import 'package:codebook/db/settings.dart';
import 'package:codebook/db/sync/cloud/cloud.dart';
import 'package:codebook/db/sync/log.dart';
import 'package:codebook/utils.dart';
import 'package:codebook/widgets/github_login_prompt.dart';
import 'package:flutter/material.dart';
import 'package:nekolib_utils/log.dart';
import 'package:rxdart/rxdart.dart';
import 'package:url_launcher/url_launcher.dart';

class Sync {
  static const clientID = "dcafc0aee351c7aa97d7";
  static const clientSecret = "acbb2d67e9360f1f80ad3aa5ecfcc962793ec4c3";
  static const codeKeyWord = "?code=";

  static String get authUrl => "https://github.com/login/oauth/authorize?client_id=$clientID&scope=gist";

  static final _log = ActionLog();

  static String generateAuthUrl() => "$authUrl&state=${generateRndmString(8)}";

  static const tokenKey = "token";
  static const authorizedKey = "authorized";
  static const gistIDKey = "gist";
  static const usernameKey = "username";
  static const lockedKey = "locked";
  static const lockedDurationKey = "lockedDuration";
  static const lockedTimestampKey = "lockedTimestamp";

  static bool _authorized = false;
  static bool get authorized => _authorized;

  static bool _isLocked = false;
  static bool get isLocked => _isLocked;

  static bool _isSyncing = false;
  static bool get isSyncing => _isSyncing;

  static String get username => Cloud.username;

  static const Duration _baseLockCooldown = Duration(milliseconds: 7500);
  static const int _lockCooldownFactor = 2;

  static Duration _currentLockCooldown = Duration.zero;
  static Duration get currentLockCooldown => _currentLockCooldown;
  static int _totalSyncFails = 0;

  static DateTime _lockedTimestap = DateTime.now();
  static DateTime get lockedTimestamp => _lockedTimestap;

  static Duration get _nextLockCooldown => _baseLockCooldown * _lockCooldownFactor * _totalSyncFails;
  static final StreamController<bool> _syncing = BehaviorSubject<bool>();
  static final StreamController<bool> _locked = BehaviorSubject<bool>();
  static Stream<bool> get syncing => _syncing.stream;
  static Stream<bool> get locked => _locked.stream;

  static Function()? onSync;

  static Future load() async {
    log("Loading sync settings", LogTypes.tracking);

    _locked.sink.add(false);
    _syncing.sink.add(false);

    var f = await DB.syncFile;
    if (!await f.exists()) return Settings.sync = false;

    var content = await f.readAsString();

    var config = jsonDecode(content);
    Cloud.token = config[tokenKey] ?? "";
    _authorized = config[authorizedKey] ?? false;
    Cloud.gistID = config[gistIDKey] ?? "";
    Cloud.username = config[usernameKey] ?? "";
    _isLocked = config[lockedKey] ?? false;
    config[gistIDKey] = "************************";
    config[tokenKey] = "************************";

    _authorized = await checkCredentials();
    config["authorized"] = _authorized;

    log("Loaded sync config: $config");

    if (_isLocked) {
      Duration lockedDuration = Duration(milliseconds: config[lockedDurationKey] ?? 0);
      int lockedTimestampSinceEpoch = config[lockedTimestampKey] ?? 0;

      if (lockedTimestampSinceEpoch != 0) {
        var lockedTimestamp = DateTime.fromMillisecondsSinceEpoch(lockedTimestampSinceEpoch);

        lockedDuration = lockedTimestamp.add(lockedDuration).difference(DateTime.now());

        lockSync(lockedDuration);
      }
    }
  }

  static Future<bool> checkCredentials() async {
    if (!await connectivity.checkConnection()) return false;
    log("validating credentials...");
    var response = await client.get(
      Uri.parse("https://api.github.com/gists/starred"),
      headers: Cloud.headers,
    );
    return response.statusCode != 401;
  }

  static reportChange(Ingredient ingredient, Function() change) {
    if (!Settings.sync) {
      change();
      DB.save();
      return;
    }

    _log.write(ingredient, DEL);
    change();
    _log.write(ingredient, ADD);

    sync();
  }

  static writeLog(Ingredient ingredient, ActionType type) {
    if (!Settings.sync) return;

    _log.write(ingredient, type);
  }

  static Future sync() async {
    log("----------------- SYNCING -----------------", LogTypes.tracking);
    if (!Settings.sync || !await connectivity.checkConnection() || !Cloud.isReady || _isSyncing || !_authorized || _isLocked) {
      log("Snyc not possible - is authorized: $_authorized, isLocked: $_isLocked, isSyncing: $_isSyncing, isReady: ${Cloud.isReady}, hasConnection: ${await connectivity.checkConnection()}, syncEnabled: ${Settings.sync}", LogTypes.debug);
      log("----------------- SYNCING CANCELLED -----------------", LogTypes.tracking);
      return;
    }

    try {
      _isSyncing = true;
      _syncing.sink.add(true);

      // ---- Sync ingredients ----

      var data = await Cloud.pullIngredients();

      var cloudMap = <String, Ingredient>{};

      // Add all ingredients from cloud to map for faster lookup
      for (var i in data) {
        cloudMap[i.hash] = i;
      }
      var mergedData = <Ingredient>[];

      // Add ingredients that were changed locally
      for (var ingredient in DB.ingredients) {
        var hash = ingredient.hash;

        if (cloudMap.containsKey(hash)) continue;
        if (_log.actionLog[hash] != ADD) continue;

        log("added ${ingredient.desc}@$hash from disk", LogTypes.success);

        mergedData.add(ingredient);
      }

      // Add ingredients that were changed remotely
      for (var ingredient in data) {
        var hash = ingredient.hash;

        if (_log.actionLog[hash] == DEL) continue;

        log("added ${ingredient.desc}@$hash from cloud", LogTypes.success);
        mergedData.add(ingredient);
      }

      // Update database
      DB.clear();
      DB.import(mergedData);

      // ---- Sync settings ----

      var settings = await Cloud.pullSettings();

      // Update settings
      if (!Settings.dirty) {
        Settings.loadFromCloud(settings);
        log("loaded settings from cloud", LogTypes.debug);
      } else {
        Settings.markClean();
        log("loaded settings from disk", LogTypes.debug);
      }

      await Cloud.pushAll();

      _log.clear();
      _syncing.sink.add(false);
      _isSyncing = false;

      log("calling callback...", LogTypes.tracking);

      onSync?.call();
      log("----------------- SYNCING DONE -----------------", LogTypes.tracking);
    } catch (e, stack) {
      log("error: $e", LogTypes.error);
      log("stack: $stack", LogTypes.error);

      _totalSyncFails++;

      log("total sync fails: $_totalSyncFails", LogTypes.debug);

      _syncing.sink.add(false);
      _isSyncing = false;

      await lockSync(_nextLockCooldown);

      log("----------------- SYNCING CANCELLED -----------------", LogTypes.tracking);
    }
  }

  static Future lockSync(Duration duration) async {
    _isLocked = true;
    _locked.sink.add(true);
    _currentLockCooldown = duration;
    _lockedTimestap = DateTime.now();
    await save();
    log("temporarily locked sync for ${duration.inSeconds} seconds", LogTypes.debug);

    Future.delayed(duration).then((_) {
      _isLocked = false;
      _locked.sink.add(false);
      log("unlocked sync", LogTypes.debug);
      save();
    });
  }

  static Future save() async {
    var f = await DB.syncFile;
    await f.writeAsString(
      jsonEncode(
        {
          gistIDKey: Cloud.gistID,
          tokenKey: Cloud.token,
          authorizedKey: authorized,
          usernameKey: Cloud.username,
          lockedKey: _isLocked,
          lockedDurationKey: currentLockCooldown.inMilliseconds,
          lockedTimestampKey: _lockedTimestap.millisecondsSinceEpoch,
        },
      ),
    );
  }

  static Future login(BuildContext context) async {
    var folder = await DB.appDir;
    var f = File('${folder.path}/auth.json');

    var config = File("${folder.path}/sync-auth-config.json");
    await config.writeAsString(jsonEncode({"path": f.path, "keyword": codeKeyWord, "pid": "$pid"}));
    await launch(generateAuthUrl());

    bool successFull = false;

    var code = await Navigator.of(context).push<String>(
      MaterialPageRoute(
        builder: (context) => GitHubLoginPrompt(
          onSuccess: (value) async {
            if (f.existsSync()) await f.delete();

            Navigator.of(context).pop<String>(value);
          },
          onCancel: () async {
            if (f.existsSync()) await f.delete();
            Navigator.of(context).pop();
          },
          sucesssFile: f,
        ),
      ),
    );

    if (code != null) {
      var response = await client.post(
        Uri.parse("https://github.com/login/oauth/access_token$codeKeyWord$code&client_id=$clientID&client_secret=$clientSecret"),
        headers: {"Accept": "application/json"},
      );

      if (response.statusCode == 200) {
        try {
          var token = jsonDecode(response.body)["access_token"];

          Cloud.token = token;
          // get username from github api
          var userResponse = await client.get(
            Uri.parse("https://api.github.com/user"),
            headers: Cloud.headers,
          );

          var user = jsonDecode(userResponse.body);
          Cloud.username = user["name"] ?? user["login"];

          await Cloud.findGist();

          _authorized = true;
          successFull = true;

          await save();
          await sync();
        } catch (e) {
          successFull = false;
        }
      }
    }

    showThemedSnackbar(
        context,
        _authorized
            ? successFull
                ? "GitHub login successfull!"
                : "GitHub login failed or cancelled by user! Falling back to previous account."
            : "GitHub login failed or cancelled by user!");
  }
}

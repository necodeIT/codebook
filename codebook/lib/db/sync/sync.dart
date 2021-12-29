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

  static bool _authorized = false;
  static bool get authorized => _authorized;

  static String get username => Cloud.username;

  static Future load() async {
    var f = await DB.syncFile;
    if (!f.existsSync()) return Settings.sync = false;

    var content = await f.readAsString();

    var config = jsonDecode(content);
    Cloud.token = config[tokenKey] ?? "";
    _authorized = config[authorizedKey] ?? false;
    Cloud.gistID = config[gistIDKey] ?? "";
    Cloud.username = config[usernameKey] ?? "";
  }

  static reportChange(Ingredient ingredient, Function() change) {
    if (!Settings.sync) return change();

    _log.write(ingredient, DEL);
    change();
    _log.write(ingredient, ADD);

    sync();
  }

  static log(Ingredient ingredient, ActionType type) {
    if (!Settings.sync) return;

    _log.write(ingredient, type);
  }

  static Future sync() async {
    if (!Settings.sync || !await connectivity.checkConnection()) return;

    var data = await Cloud.pullIngredients();
    var settings = await Cloud.pullSettings();

    var cloudMap = <String, Ingredient>{};

    for (var i in data) {
      cloudMap[i.hash] = i;
    }
    var mergedData = [];

    for (var ingredient in DB.ingredients) {
      var hash = ingredient.hash;

      if (cloudMap.containsKey(hash)) continue;
      if (_log.actionLog[hash] != ADD) continue;

      mergedData.add(ingredient);
    }

    for (var ingredient in data) {
      var hash = ingredient.hash;

      if (_log.actionLog[hash] == DEL) continue;
      mergedData.add(ingredient);
    }

    Cloud.pushIngredients(data);

    if (Settings.dirty) {
      Cloud.pushSettings(Settings.toCloud());
      Settings.markClean();
    } else {
      Settings.loadFromCloud(settings);
    }

    _log.clear();
  }

  static Future save() async {
    if (!Settings.sync) return;

    var f = await DB.syncFile;
    await f.writeAsString(
      jsonEncode(
        {
          gistIDKey: Cloud.gistID,
          tokenKey: Cloud.token,
          authorizedKey: authorized,
          usernameKey: Cloud.username,
        },
      ),
    );
  }

  static Future push() async {}

  static Future pull() async {}

  static Future login(BuildContext context) async {
    // await Cloud.findGist();
    // return;
    var folder = await DB.appDir;
    var f = File('${folder.path}/auth.json');

    var config = File("${folder.path}/sync-auth-config.json");
    await config.writeAsString(jsonEncode({"path": f.path, "keyword": codeKeyWord, "pid": "$pid"}));
    await launch(generateAuthUrl());

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
          Cloud.username = user["name"];

          await Cloud.findGist();

          _authorized = true;
          await save();
        } catch (e) {
          _authorized = false;
        }
      }
    }

    showThemedSnackbar(context, _authorized ? "GitHub login successfull!" : "GitHub login failed or cancelled by user");
  }
}

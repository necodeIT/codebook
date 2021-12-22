import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:codebook/db/db.dart';
import 'package:codebook/db/ingredient.dart';
import 'package:codebook/db/settings.dart';
import 'package:codebook/db/sync/log.dart';
import 'package:codebook/widgets/github_login_prompt.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:nekolib.ui/ui.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:cross_connectivity/cross_connectivity.dart';

class Sync {
  static const clientID = "Iv1.61be57a9cf8293c1";
  static const clientSecret = "c10ec68b18af37516948ad6cccdff1a82e73a23a";
  static const redirectUrl = "https://github.com/necodeIT/code-book";
  static const codeKeyWord = "?code=";

  static String get authUrl => "https://github.com/login/oauth/authorize?client_id=$clientID";
  static final Client client = Client();
  static final Connectivity connectivity = Connectivity();

  static final _log = ActionLog();

  static const _chars = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
  static final Random _rnd = Random();
  static String generateState(int length) => String.fromCharCodes(Iterable.generate(length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));

  static String generateAuthUrl() => "$authUrl&state=${generateState(8)}";

  static Map get headers => {"Authorization": "token $token", "Accept": "application/json"};

  static const tokenKey = "token";
  static const authorizedKey = "authorized";
  static const gistIDKey = "gist";

  static var _token = "";
  static String get token => _token;

  static bool _authorized = false;
  static bool get authorized => _authorized;

  static var _gistID = "";
  static String get gistID => _gistID;

  static Future load() async {
    // TODO: connectivity.isConnected.asBroadcastStream()
    // if (!Settings.sync) return;

    var f = await DB.syncFile;
    if (!f.existsSync()) return Settings.sync = false;

    var content = await f.readAsString();

    var config = jsonDecode(content);
    _token = config[tokenKey] ?? "";
    _authorized = config[authorizedKey] ?? false;
    _gistID = config[gistIDKey] ?? "";
  }

  static reportChange(Ingredient ingredient, Function() change) {
    if (!Settings.sync) return change();

    _log.write(ingredient, DEL);
    change();
    _log.write(ingredient, ADD);

    // TODO: sync
  }

  static log(Ingredient ingredient, ActionType type) {
    if (!Settings.sync) return;

    _log.write(ingredient, type);
  }

  static Future save() async {
    // if (!Settings.sync) return;

    var f = await DB.syncFile;
    await f.writeAsString(jsonEncode({gistIDKey: gistID, tokenKey: token, authorizedKey: authorized}));
  }

  static Future<String> getGistId() async {
    if (!authorized) throw Exception("Sync not authorized!");
    return "";
  }

  static Future push() async {}

  static Future pull() async {}

  static Future login(BuildContext context) async {
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
          _token = jsonDecode(response.body)["access_token"];
          _authorized = true;
          _gistID = await getGistId();
          await save();
        } catch (e) {
          _authorized = false;
        }
      }
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: NcBodyText(_authorized ? "GitHub login successfull!" : "GitHub login failed or cancelled by user"),
        backgroundColor: NcThemes.current.tertiaryColor,
      ),
    );
  }

  static logout() {
    _authorized = false;
  }
}

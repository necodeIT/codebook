import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:codebook/db/db.dart';
import 'package:codebook/widgets/github_login_prompt.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:nekolib.ui/ui.dart';
import 'package:url_launcher/url_launcher.dart';

class Sync {
  static const clientID = "Iv1.61be57a9cf8293c1";
  static const clientSecret = "c10ec68b18af37516948ad6cccdff1a82e73a23a";
  static String get authUrl => "https://github.com/login/oauth/authorize?client_id=$clientID";
  static const redirectUrl = "https://github.com/necodeIT/code-book";
  static const codeKeyWord = "?code=";
  static final Client client = Client();

  static const _chars = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
  static final Random _rnd = Random();
  static String generateState(int length) => String.fromCharCodes(Iterable.generate(length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));

  static String generateAuthUrl() {
    return "$authUrl&state=${generateState(8)}";
  }

  static const tokenKey = "token";
  static const authorizedKey = "authorized";

  static var _token = "";
  static String get token => _token;

  static bool _authorized = false;
  static bool get authorized => _authorized;

  static Future load() async {}

  static Future login(BuildContext context) async {
    var folder = await DB.appDir;
    var f = File('${folder.path}/auth.json');

    var config = File("${folder.path}/sync-auth-config.json");
    await config.writeAsString(jsonEncode({"path": f.path, "keyword": codeKeyWord}));
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
}

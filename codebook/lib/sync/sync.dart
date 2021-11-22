import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:codebook/db/db.dart';
import 'package:codebook/sync/login_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nekolib.ui/ui.dart';
import 'package:url_launcher/url_launcher.dart';

class Sync {
  static final clientID = "Iv1.61be57a9cf8293c1";
  static String get authUrl => "https://github.com/login/oauth/authorize?client_id=${Sync.clientID}";
  static const redirectUrl = "https://github.com/necodeIT/code-book";
  static const codeKeyWord = "?code=";

  static const _chars = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
  static final Random _rnd = Random();
  static String generateState(int length) => String.fromCharCodes(Iterable.generate(length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));

  static String generateAuthUrl() {
    return "$authUrl&state=${generateState(8)}";
  }

  // static const

  static Future load() async {}

  static bool _loggedIn = false;

  static bool get loggedIn => _loggedIn;

  static Future login(BuildContext context) async {
    var folder = await DB.appDir;
    var f = File('${folder.path}/auth.json');

    var config = File("${folder.path}/sync-auth-config.json");
    await config.writeAsString(jsonEncode({"path": f.path, "keyword": codeKeyWord}));
    await launch(generateAuthUrl());

    var result = await Navigator.of(context).push<String>(
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

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: NcBodyText(result == null ? "GitHub login cancelled by user" : "GitHub login successfull!"),
        backgroundColor: NcThemes.current.tertiaryColor,
      ),
    );

    if (result == null) return;

    var code = result;
    // TODO: request token
    _loggedIn = true;
  }
}

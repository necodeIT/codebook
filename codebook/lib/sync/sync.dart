import 'package:codebook/sync/login_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nekolib.ui/ui.dart';

class Sync {
  static const clientID = "Iv1.61be57a9cf8293c1";
  static const authUrl = "https://github.com/login/oauth/authorize?client_id=${Sync.clientID}";
  static const redirectUrl = "https://github.com/necodeIT/code-book";
  static const codeKeyWord = "?code=";
  // static const

  // static Future load(){

  // }

  // static bool _loggedIn = false;

  // static bool get loggedIn => _loggedIn;

  static login(BuildContext context) async {
    var result = await Navigator.of(context).push<String>(
      MaterialPageRoute(
        builder: (context) => GitHubLoginPrompt(
          onSuccess: (value) {
            Navigator.of(context).pop<String>(value);
          },
          sucessKeyWord: codeKeyWord,
        ),
      ),
    );

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: NcBodyText("GitHub login successfull!"),
        backgroundColor: NcThemes.current.tertiaryColor,
      ),
    );

    if (result == null) return;

    var code = result.split(codeKeyWord).last;
    print(code);
  }
}
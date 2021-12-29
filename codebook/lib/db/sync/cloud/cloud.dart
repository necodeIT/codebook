import 'dart:convert';

import 'package:codebook/db/db.dart';
import 'package:codebook/db/ingredient.dart';
import 'package:codebook/db/settings.dart';
import 'package:codebook/utils.dart';

class Cloud {
  static String _gistID = "";
  static String _gistURL = "";
  static String token = "";
  static String _username = "";

  static String get gistID => _gistID;
  static String get username => _username;
  static String get gistURL => _gistURL;

  static set gistID(String id) {
    _gistID = id;
    _updateGistUrl();
  }

  static set username(String username) {
    _username = username;
    _updateGistUrl();
  }

  static _updateGistUrl() {
    _gistURL = "https://gist.github.com/$_username/$_gistID";
  }

  static const String gistURLBase = "https://gist.github.com/";
  static const settingsFileName = "settings.json";
  static const ingredientsFileName = "book.json";
  static const gistDescription = "CodeBook Sync";
  static const gistName = "!codebook-sync.codebook_indexer";

  static Map<String, String> get headers => {"Authorization": "token $token", "Accept": "application/json"};

  static bool _loaded = false;

  static Future _load() async {
    if (_loaded) return;

    _loaded = true;
  }

  static Future _createGist() async {
    await _load();

    var response = await client.post(
      Uri.parse("https://api.github.com/gists"),
      headers: headers,
      body: json.encode(
        {
          "description": gistDescription,
          "public": true,
          "files": {
            gistName: {
              "name": gistName,
              "content": gistDescription,
            },
            settingsFileName: {
              "name": settingsFileName,
              "content": "${jsonEncode(Settings.toCloud())}",
            },
            ingredientsFileName: {
              "name": ingredientsFileName,
              "content": "${jsonEncode(DB.ingredients)}",
            },
          },
        },
      ),
    );

    if (response.statusCode == 201) {
      var jsonResponse = json.decode(response.body);
      gistID = jsonResponse["id"];
      print(gistID);
      print(gistURL);
    } else {
      print(response.body);
      print(response.statusCode);
    }
  }

  static Future findGist({String? newToken, String? newUsername}) async {
    token = newToken ?? token;
    username = newUsername ?? username;

    // get all gists for user with token and username with file !codebook-sync.codebook_indexer
    var gistsResponse = await client.get(Uri.parse("https://api.github.com/users/$username/gists"), headers: headers);
    var gists = jsonDecode(gistsResponse.body);
    for (var gist in gists) {
      if (gist["description"] == gistDescription && gist["files"].containsKey(gistName)) {
        _gistID = gist["id"];
        _gistURL = gist["html_url"];

        print(gistID);
        print(gistURL);
        return;
      }
    }

    // create new gist if none found
    _createGist();
  }

  static Future<Map<String, dynamic>> pullSettings() async {
    // get settings file from gist

    var response = await client.get(Uri.parse("https://api.github.com/gists/$gistID/files/$settingsFileName"), headers: headers);

    return {};
  }

  static Future<List<Ingredient>> pullIngredients() async {
    return [];
  }

  static Future pushSettings(Map<String, dynamic> settings) async {}

  static Future pushIngredients(List<Ingredient> ingredients) async {}
}

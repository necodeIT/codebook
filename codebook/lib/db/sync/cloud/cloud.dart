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

  static bool get isReady => _gistID.isNotEmpty && _gistURL.isNotEmpty && _username.isNotEmpty && token.isNotEmpty;

  static set gistID(String id) {
    _gistID = id;
    _updateGistUrl();
  }

  static set username(String username) {
    _username = username;
    _updateGistUrl();
  }

  static _updateGistUrl() {
    _gistURL = "https://api.github.com/gists/$_gistID";
  }

  static const settingsFileName = "settings.json";
  static const ingredientsFileName = "book.json";
  static const gistDescription = "CodeBook Sync";
  static const gistName = "!codebook-sync.codebook_indexer";

  static Map<String, String> get headers => {"Authorization": "token $token", "Accept": "application/json"};

  static Future _createGist() async {
    if (!isReady) return;
    var response = await client.post(
      Uri.parse("https://api.github.com/gists"),
      headers: headers,
      body: json.encode(
        {
          "description": gistDescription,
          "public": false,
          "files": {
            gistName: {
              "name": gistName,
              "content": gistDescription,
            },
            settingsFileName: {
              "name": settingsFileName,
              // ignore: unnecessary_string_interpolations
              "content": "${jsonEncode(Settings.toCloud())}", // throws exception if not interpolated idk why
            },
            ingredientsFileName: {
              "name": ingredientsFileName,
              // ignore: unnecessary_string_interpolations
              "content": "${jsonEncode(DB.ingredients)}", // throws exception if not interpolated idk why
            },
          },
        },
      ),
    );

    if (response.statusCode == 201) {
      var jsonResponse = json.decode(response.body);
      gistID = jsonResponse["id"];
    }
  }

  static Future findGist({String? newToken, String? newUsername}) async {
    if (!isReady) return;
    token = newToken ?? token;
    username = newUsername ?? username;

    // get all gists for user with token and username with file !codebook-sync.codebook_indexer
    var gistsResponse = await client.get(Uri.parse("https://api.github.com/gists"), headers: headers);
    var gists = jsonDecode(gistsResponse.body);
    for (var gist in gists) {
      if (gist["description"] == gistDescription && gist["files"].containsKey(gistName)) {
        _gistID = gist["id"];
        _gistURL = gist["html_url"];

        return;
      }
    }

    // create new gist if none found
    _createGist();
  }

  static Future<Map<String, dynamic>> pullSettings() async {
    if (!isReady) return {};
    var response = await client.get(Uri.parse(gistURL), headers: headers);
    var content = jsonDecode(response.body)["files"][settingsFileName]["content"];
    return jsonDecode(content); // double encode because it is encoded twice in the string interpolation
  }

  static Future<List<Ingredient>> pullIngredients() async {
    if (!isReady) return [];
    var response = await client.get(Uri.parse(gistURL), headers: headers);
    var content = jsonDecode(response.body)["files"][ingredientsFileName]["content"];
    var ingredients = jsonDecode(content);
    return List<Ingredient>.from(ingredients.map((model) => Ingredient.fromJson(model)));
  }

  static Future pushAll() async {
    if (!isReady) return;
    await client.patch(
      Uri.parse(gistURL),
      headers: headers,
      body: json.encode(
        {
          "description": gistDescription,
          "public": false,
          "files": {
            gistName: {
              "name": gistName,
              "content": gistDescription,
            },
            settingsFileName: {
              "name": settingsFileName,
              // ignore: unnecessary_string_interpolations
              "content": "${jsonEncode(Settings.toCloud())}", // throws exception if not interpolated idk why
            },
            ingredientsFileName: {
              "name": ingredientsFileName,
              // ignore: unnecessary_string_interpolations
              "content": "${jsonEncode(DB.ingredients)}", // throws exception if not interpolated idk why
            },
          },
        },
      ),
    );
  }
}

import 'dart:convert';

import 'package:codebook/db/db.dart';
import 'package:codebook/db/ingredient.dart';
import 'package:codebook/db/settings.dart';
import 'package:codebook/utils.dart';
import 'package:nekolib_utils/log.dart';

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
    if (token.isEmpty || username.isEmpty) return;

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
    token = newToken ?? token;
    username = newUsername ?? username;

    if (token.isEmpty || username.isEmpty) return;

    // get all gists for user with token and username with file !codebook-sync.codebook_indexer
    var gistsResponse = await client.get(Uri.parse("https://api.github.com/gists"), headers: headers);
    var gists = jsonDecode(gistsResponse.body);
    for (var gist in gists) {
      if (gist["description"] == gistDescription && gist["files"].containsKey(gistName)) {
        gistID = gist["id"];

        return;
      }
    }

    // create new gist if none found
    _createGist();
  }

  static Future<Map<String, dynamic>> pullSettings() async {
    log("----------------- PULLING SETTINGS -----------------", LogTypes.tracking);
    if (!isReady) {
      log("Missing credentials - cloud not ready", LogTypes.warning);
      log("----------------- PULL CANCELLED  -----------------", LogTypes.tracking);
      return {};
    }
    try {
      var response = await client.get(Uri.parse(_gistURL), headers: headers);

      log("Status code: ${response.statusCode}");
      if (response.statusCode != 200) {
        log("Error message from server: ${response.body}", LogTypes.error);
        throw Exception(response.body);
      }

      var content = jsonDecode(response.body)["files"][settingsFileName]["content"];
      log("----------------- PULL SUCCESS  -----------------", LogTypes.tracking);
      return jsonDecode(content); // double encode because it is encoded twice in the string interpolation
    } catch (e, stack) {
      log("Error pulling ingredients: $e", LogTypes.error);
      log("Stack: $stack", LogTypes.error);
      log("----------------- PULL FAILED  -----------------", LogTypes.tracking);

      return {};
    }
  }

  static Future<List<Ingredient>> pullIngredients() async {
    log("----------------- PULLING INGREDIENTS -----------------", LogTypes.tracking);
    if (!isReady) {
      log("Missing credentials - cloud not ready", LogTypes.warning);
      log("----------------- PULL CANCELLED  -----------------", LogTypes.tracking);
      return [];
    }

    try {
      var response = await client.get(Uri.parse(gistURL), headers: headers);

      log("Status code: ${response.statusCode}");
      if (response.statusCode != 200) {
        log("Error message from server: ${response.body}", LogTypes.error);
        throw Exception(response.body);
      }

      var content = jsonDecode(response.body)["files"][ingredientsFileName]["content"];
      var ingredients = jsonDecode(content);
      var data = List<Ingredient>.from(ingredients.map((model) => Ingredient.fromJson(model)));

      log("----------------- PULL SUCCESS  -----------------", LogTypes.tracking);
      return data;
    } catch (e, stack) {
      log("Error pulling ingredients: $e", LogTypes.error);
      log("Stack: $stack", LogTypes.error);
      log("----------------- PULL FAILED  -----------------", LogTypes.tracking);

      return [];
    }
  }

  static Future pushAll() async {
    log("----------------- UPLOADING DATA -----------------", LogTypes.tracking);
    if (!isReady) {
      log("Missing credentials - cloud not ready", LogTypes.warning);
      log("----------------- UPLOADING CANCELLED  -----------------", LogTypes.tracking);
      return;
    }

    var r = await client.patch(
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

    log("Status code: ${r.statusCode}", LogTypes.debug);
    if (r.statusCode != 200) {
      log("Error message from server: ${r.body}", LogTypes.error);
      log("----------------- UPLOADING FAILED  -----------------", LogTypes.tracking);
    } else {
      log("----------------- UPLOADING SUCCESS  -----------------", LogTypes.tracking);
    }
  }
}

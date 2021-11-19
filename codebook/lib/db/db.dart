import 'dart:convert';
import 'dart:io';

import 'package:codebook/db/ingredient.dart';
import 'package:path_provider/path_provider.dart';

class DB {
  static Future<Directory> get appDir async {
    var dir = await getApplicationDocumentsDirectory();
    var path = '${dir.path}/$appFolderName';
    var appDir = Directory(path);
    await appDir.create();
    return appDir;
  }

  static Future<File> get bookFile async {
    var dir = await appDir;
    return File('${dir.path}/$bookFileName');
  }

  static Future<File> get settingsFile async {
    var dir = await appDir;
    return File('${dir.path}/$settingsFileName');
  }

  static const appFolderName = "CodeBook";
  static const settingsFileName = "settings.$saveExtension";
  static const saveExtension = "json";
  static const bookFileName = "book.$saveExtension";

  static final List<Ingredient> _ingredients = [];
  static final List<String> _tags = [];
  static final List<String> _languages = [];

  static List<Ingredient> get ingredients => List.unmodifiable(_ingredients);
  static List<String> get tags => List.unmodifiable(_tags);
  static List<String> get lanugages => List.unmodifiable(_languages);

  /// Updates the tags and languages metadata.
  static void updateMetaData() {
    _tags.clear();
    _languages.clear();

    for (var ingredient in ingredients) {
      for (var tag in ingredient.tags) {
        if (_tags.contains(tag)) continue;

        _tags.add(tag);
      }
      if (!_languages.contains(ingredient.language)) _languages.add(ingredient.language);
    }
  }

  /// Updates the metadata and saves the db to the file system.
  static void update() {
    updateMetaData();
    save();
  }

  /// Adds an ingredient to the database.
  static void addIngredient(Ingredient value) {
    _ingredients.add(value);
    update();
  }

  /// Removes an ingredient from the database.
  static void rmIngredient(Ingredient value) {
    _ingredients.remove(value);
    update();
  }

  /// Loads the db from the local file system.
  static Future load() async {
    return Future(() async {
      var book = await bookFile;

      var ingredients = await extractIngredientsFromPath(book.path);
      import(ingredients);
    });
  }

  /// Saves the db to the local file system.
  static Future save() async {
    return Future(() async {
      var file = await bookFile;
      export(file.path, ingredients);
    });
  }

  /// Extracts ingredients from the given file path.
  static Future<List<Ingredient>> extractIngredientsFromPath(String path) async {
    var file = File(path);

    if (file.existsSync()) {
      var content = await file.readAsString();
      Iterable l = jsonDecode(content);
      List<Ingredient> ingredients = List<Ingredient>.from(l.map((model) => Ingredient.fromJson(model)));
      return ingredients;
    }

    return [];
  }

  /// Adds the given [ingredients] to the database.
  static void import(List<Ingredient> ingredients) {
    _ingredients.addAll(ingredients);
    update();
  }

  /// Exports the given [ingredients] to the given [path].
  static void export(String path, List<Ingredient> ingredients) {
    var file = File(path);

    var json = jsonEncode(_ingredients);

    file.writeAsString(json);
  }
}

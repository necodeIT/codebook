import 'dart:convert';
import 'dart:io';
import 'package:codebook/db/ingredient.dart';
import 'package:codebook/db/sync/action_type.dart';
import 'package:codebook/db/sync/sync.dart';
import 'package:nekolib_utils/log.dart';
import 'package:path_provider/path_provider.dart';

const _kNewIngredientHash = "0b7beefeddc41a459b0bfbdce95bd0ee607ad7323d771b2b6bade1e3fb1280c5";

class DB {
  static Future<Directory> get appDir async {
    var dir = await getApplicationDocumentsDirectory();
    var path = '${dir.path}/$appFolderName';
    var appDir = Directory(path);
    await appDir.create();
    return appDir;
  }

  static Future<File> get syncFile async {
    var dir = await appDir;
    return File('${dir.path}/$syncFileName');
  }

  static Future<File> get bookFile async {
    var dir = await appDir;
    return File('${dir.path}/$bookFileName');
  }

  static Future<File> get settingsFile async {
    var dir = await appDir;
    return File('${dir.path}/$settingsFileName');
  }

  static Future<File> get logFile async {
    var dir = await appDir;
    return File('${dir.path}/$logFileName');
  }

  static const appFolderName = "CodeBook";
  static const settingsFileName = "settings.$saveExtension";
  static const saveExtension = "json";
  static const bookFileName = "book.$saveExtension";
  static const syncFileName = "sync.$saveExtension";
  static const logFileName = "sync_log.$saveExtension";

  static final List<Ingredient> _ingredients = [];
  static final List<String> _tags = [];
  static final List<String> _languages = [];
  static final Map<String, int> _tagCount = {};

  static List<Ingredient> get ingredients => List.unmodifiable(_ingredients);
  static List<String> get tags => List.unmodifiable(_tags);
  static Map<String, int> get tagCount => Map.unmodifiable(_tagCount);
  static List<String> get lanugages => List.unmodifiable(_languages);

  /// Updates the tags and languages metadata.
  static void updateMetaData() {
    _tags.clear();
    _languages.clear();
    _tagCount.clear();

    for (var ingredient in ingredients) {
      for (var tag in ingredient.tags) {
        if (tagCount.containsKey(tag)) {
          _tagCount[tag] = tagCount[tag]! + 1;
        } else {
          _tagCount[tag] = 1;
        }

        if (_tags.contains(tag)) continue;

        _tags.add(tag);
      }
      if (!_languages.contains(ingredient.language)) _languages.add(ingredient.language);
    }
  }

  static void clear() {
    _ingredients.clear();
    _tags.clear();
    _languages.clear();
    _tagCount.clear();
  }

  /// Updates the metadata and saves the db to the file system.
  static void update({bool silent = true}) {
    updateMetaData();

    if (!silent) save();
    if (!silent) Sync.sync();
  }

  /// Adds an ingredient to the database.
  static void addIngredient(Ingredient value) {
    _ingredients.add(value);

    var newIngredient = value.hash == _kNewIngredientHash;
    log("$value: added to database ${newIngredient ? "(skipped sync)" : ""}", LogTypes.debug);

    Sync.writeLog(value, ADD);

    update(silent: newIngredient);
  }

  /// Removes an ingredient from the database.
  static void rmIngredient(Ingredient value) {
    _ingredients.remove(value);

    var newIngredient = value.hash == _kNewIngredientHash;
    log("$value: removed from database ${newIngredient ? "(skipped sync)" : ""}", LogTypes.debug);

    Sync.writeLog(value, DEL);

    update(silent: newIngredient);
  }

  /// Loads the db from the local file system.
  static Future load() async {
    var book = await bookFile;

    var ingredients = await extractIngredientsFromPath(book.path);
    import(ingredients, silent: true);
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
      log("Loaded ${ingredients.length} ingredients from $path", LogTypes.debug);
      return ingredients;
    }

    return [];
  }

  /// Adds the given [ingredients] to the database.
  static void import(List<Ingredient> ingredients, {bool silent = false}) {
    for (var ingredient in ingredients) {
      _ingredients.add(ingredient);
      if (!silent) Sync.writeLog(ingredient, ADD);
    }

    log("Imported ${ingredients.length} ingredients.", LogTypes.debug);
    update(silent: silent);
  }

  /// Exports the given [ingredients] to the given [path].
  static void export(String path, List<Ingredient> ingredients) {
    var file = File(path.endsWith(".json") ? path : path + ".json");

    var json = jsonEncode(ingredients);

    file.writeAsStringSync(json);
    log("exported ${ingredients.length} ingredients to $path", LogTypes.debug);
  }
}

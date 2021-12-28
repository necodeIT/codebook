class Cloud {
  static String gistID = "";
  static String gistURL = "";

  static const String gistURLBase = "https://gist.github.com/";
  static const settingsFileName = "settings.json";
  static const dataFileName = "data.json";
  static const gistDescription = "CodeBook Sync";

  static bool _loaded = false;

  static Future _load() async {
    if (_loaded) return;

    _loaded = true;
  }

  static Future createGist() async {}

  static Future<Map<String, dynamic>> pullSettings() async {
    await _load();
    return {};
  }

  static Future<Map<String, dynamic>> pullData() async {
    await _load();

    return {};
  }

  static Future pushSettings() async {
    await _load();
  }

  static Future pushData() async {
    await _load();
  }
}

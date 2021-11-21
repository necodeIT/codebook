import 'dart:convert';

import 'package:codebook/db/db.dart';
import 'package:codebook/themes.dart';
import 'package:nekolib.ui/ui/themes/themes.dart';

class Settings {
  static const String defaultCodeTheme = "Github";
  static const String codeThemeKey = "codeTheme";
  static const String themeKey = "theme";
  static const String syncKey = "sync";
  static final defaultTheme = CustomThemes.lightPurple;

  static String _theme = "";
  static String _codeTheme = "Ocean";
  static bool _sync = false;

  static void Function()? onUpdate;

  static String get theme => _theme;
  static bool get sync => _sync;
  static String get codeTheme => _codeTheme;

  static set codeTheme(String value) {
    _codeTheme = value;
    update();
  }

  static set sync(bool value) {
    _sync = value;
    update();
  }

  static void update() {
    save();
    onUpdate?.call();
  }

  static void ncThemesCallback() {
    _theme = NcThemes.current.name;
    update();
  }

  static Future load() {
    NcThemes.onCurrentThemeChange = ncThemesCallback;

    return Future(() async {
      var file = await DB.settingsFile;

      if (!file.existsSync()) {
        codeTheme = defaultCodeTheme;
        NcThemes.current = defaultTheme;
        return;
      }

      var content = file.readAsStringSync();

      var catgirl = jsonDecode(content);
      _codeTheme = catgirl[codeThemeKey];
      _sync = catgirl[syncKey];
      var theme = catgirl[themeKey];

      NcThemes.current = NcThemes.all[theme] ?? defaultTheme;
    });
  }

  static Future save() {
    return Future(() async {
      var file = await DB.settingsFile;

      var json = {
        themeKey: theme,
        codeThemeKey: codeTheme,
        syncKey: _sync,
      };

      file.writeAsString(jsonEncode(json));
    });
  }
}

import 'dart:convert';

import 'package:codebook/db/db.dart';
import 'package:codebook/themes.dart';
import 'package:nekolib.ui/ui/themes/themes.dart';

class Settings {
  static const String defaultCodeTheme = "Github";
  static const String codeThemeKey = "codeTheme";
  static const String themeKey = "theme";
  static const String syncKey = "sync";
  static const String modifiedKey = "modified";
  static final defaultTheme = CustomThemes.lightPurple;

  static String _theme = "";
  static String _codeTheme = "Ocean";
  static bool _sync = false;
  static bool _modified = false;

  static void Function()? onUpdate;

  static bool get modified => _modified;
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
    _modified = true;
    onUpdate?.call();
  }

  static void ncThemesCallback() {
    _theme = NcThemes.current.name;
    update();
  }

  static Future load() async {
    NcThemes.onCurrentThemeChange = ncThemesCallback;

    var file = await DB.settingsFile;

    if (!file.existsSync()) {
      codeTheme = defaultCodeTheme;
      NcThemes.current = defaultTheme;
      return;
    }

    var content = file.readAsStringSync();

    var catgirl = jsonDecode(content);
    _codeTheme = catgirl[codeThemeKey] ?? _codeTheme;
    _sync = catgirl[syncKey] ?? _sync;
    _modified = catgirl[modifiedKey] ?? _modified;
    var theme = catgirl[themeKey];

    NcThemes.current = NcThemes.all[theme] ?? defaultTheme;
  }

  static Future save() async {
    var file = await DB.settingsFile;

    var json = {
      themeKey: theme,
      codeThemeKey: codeTheme,
      syncKey: _sync,
      modifiedKey: _modified,
    };

    await file.writeAsString(jsonEncode(json));
  }
}

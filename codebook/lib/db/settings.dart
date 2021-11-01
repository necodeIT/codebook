import 'dart:convert';

import 'package:codebook/db/db.dart';
import 'package:codebook/themes.dart';
import 'package:nekolib.ui/ui/themes/themes.dart';

class Settings {
  static const String defaultCodeTheme = "Github";
  static const String codeThemeKey = "codeTheme";
  static const String themeKey = "theme";
  static final defaultTheme = CustomThemes.lightPurple;

  static String _theme = "";
  static String _codeTheme = "Ocean";

  static void Function()? onUpdate;

  static String get theme => _theme;

  static String get codeTheme => _codeTheme;

  static set codeTheme(String value) {
    _codeTheme = value;
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
      codeTheme = catgirl[codeThemeKey];
      var theme = catgirl[themeKey];

      NcThemes.current = NcThemes.all[theme] ?? CustomThemes.all[theme] ?? defaultTheme;
    });
  }

  static Future save() {
    return Future(() async {
      var file = await DB.settingsFile;

      var json = {
        themeKey: theme,
        codeThemeKey: codeTheme,
      };

      file.writeAsString(jsonEncode(json));
    });
  }
}

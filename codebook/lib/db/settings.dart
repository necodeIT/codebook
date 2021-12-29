import 'dart:convert';

import 'package:codebook/db/db.dart';
import 'package:codebook/themes.dart';
import 'package:nekolib.ui/ui/themes/themes.dart';

import 'sync/sync.dart';

class Settings {
  static const String defaultCodeTheme = "Github";
  static const String codeThemeKey = "codeTheme";
  static const String themeKey = "theme";
  static const String syncKey = "sync";
  static const String modifiedKey = "dirty";
  static final defaultTheme = CustomThemes.lightPurple;

  static String _theme = "";
  static String _codeTheme = "Ocean";
  static bool _sync = false;
  static bool _dirty = false;

  static void Function()? onUpdate;

  static bool get dirty => _dirty;
  static String get theme => _theme;
  static bool get sync => _sync;
  static String get codeTheme => _codeTheme;

  static void markDirty() {
    if (!_sync) return;
    _dirty = true;
  }

  static void markClean() {
    if (!_sync) return;
    _dirty = false;
  }

  static set codeTheme(String value) {
    if (value == _codeTheme) return;
    markDirty();
    _codeTheme = value;
    _update();
  }

  static set sync(bool value) {
    if (value == _sync) return;
    markDirty();
    _sync = value;
    _update();
  }

  static void _update() {
    onUpdate?.call();

    if (dirty) Sync.sync();

    save();
  }

  static void ncThemesCallback() {
    _theme = NcThemes.current.name;
    markDirty();
    _update();
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
    _dirty = catgirl[modifiedKey] ?? _dirty;
    var theme = catgirl[themeKey];

    NcThemes.current = NcThemes.all[theme] ?? defaultTheme;
  }

  static Future save() async {
    var file = await DB.settingsFile;

    var json = {
      themeKey: theme,
      codeThemeKey: codeTheme,
      syncKey: _sync,
      modifiedKey: _dirty,
    };

    await file.writeAsString(jsonEncode(json));
  }

  static Map<String, dynamic> toCloud() {
    return {
      themeKey: theme,
      codeThemeKey: codeTheme,
      syncKey: _sync,
    };
  }

  static loadFromCloud(Map<String, dynamic> json) {
    _codeTheme = json[codeThemeKey] ?? _codeTheme;
    _sync = json[syncKey] ?? _sync;
    var theme = json[themeKey];
    NcThemes.current = NcThemes.all[theme] ?? defaultTheme;
    markClean();
    _update();
  }
}

import 'dart:convert';

import 'package:codebook/db/db.dart';
import 'package:codebook/db/logger.dart';
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
    save();
  }

  static set codeTheme(String value) {
    if (value == _codeTheme) return;
    markDirty();
    _codeTheme = value;
    _update();
  }

  static set sync(bool value) {
    if (value == _sync) return;

    _sync = value;

    if (sync) Sync.sync();

    _update();
  }

  static void _update() {
    onUpdate?.call();

    if (dirty) Sync.sync();

    save();
  }

  static void ncThemesCallback() {
    if (_theme == NcThemes.current.name) return;
    markDirty();
    _theme = NcThemes.current.name;
    _update();
  }

  static Future load() async {
    log("loading settings");
    NcThemes.onCurrentThemeChange = ncThemesCallback;
    var file = await DB.settingsFile;

    if (!file.existsSync()) {
      _codeTheme = defaultCodeTheme;
      NcThemes.current = defaultTheme;
      return;
    }

    var content = file.readAsStringSync();

    var catgirl = jsonDecode(content);
    _codeTheme = catgirl[codeThemeKey] ?? _codeTheme;
    _sync = catgirl[syncKey] ?? _sync;
    _dirty = catgirl[modifiedKey] ?? _dirty;

    _theme = catgirl[themeKey];

    log("code theme: ${_codeTheme}");
    log("theme: ${_theme}");
    log("sync: ${_sync}");
    log("dirty: ${_dirty}");

    NcThemes.current = NcThemes.all[theme] ?? defaultTheme;
    log("loaded settings");
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

import 'dart:convert';

import 'package:codebook/db/db.dart';
import 'package:codebook/themes.dart';
import 'package:nekolib_ui/core.dart';
import 'package:nekolib_utils/log.dart';

import 'sync/sync.dart';

class Settings {
  static const String defaultCodeTheme = "Github";
  static const String codeThemeKey = "codeTheme";
  static const String themeKey = "theme";
  static const String syncKey = "sync";
  static const String modifiedKey = "dirty";
  static final defaultTheme = CustomThemes.lightPurple;

  static String _theme = "";
  static String _codeTheme = "Atelier Cave Dark";
  static bool _sync = false;
  static bool _dirty = false;

  static bool get dirty => _dirty;
  static String get theme => _theme;
  static bool get sync => _sync;
  static String get codeTheme => _codeTheme;

  static void markDirty() {
    if (!_sync) return;

    log("maked settings dirty", LogTypes.debug);

    _dirty = true;
  }

  static void markClean() {
    if (!_sync) return;

    log("maked settings clean", LogTypes.debug);

    _dirty = false;
    save();
  }

  static set codeTheme(String value) {
    if (value == _codeTheme) return;

    log("changed code theme from $_codeTheme to $value", LogTypes.debug);

    markDirty();
    _codeTheme = value;
    _update();
  }

  static set sync(bool value) {
    if (value == _sync) return;

    _sync = value;

    log("sync set to $value", LogTypes.debug);

    if (sync) Sync.sync();

    _update();
  }

  static void _update() async {
    if (dirty) Sync.sync();

    await save();
  }

  static void ncThemesCallback(NcTheme theme) {
    if (_theme == theme.name) return;
    log("changed theme from $_theme to ${theme.name}", LogTypes.debug);
    markDirty();
    _theme = theme.name;
    _update();
  }

  static Future load() async {
    NcThemes.onCurrentThemeChanged.listen(ncThemesCallback);
    var file = await DB.settingsFile;

    if (!file.existsSync()) {
      _codeTheme = defaultCodeTheme;
      NcThemes.setTheme(defaultTheme);
      return;
    }

    var content = file.readAsStringSync();

    var catgirl = {};

    if (content.isEmpty) {
      log("Settings file is empty", LogTypes.warning);
    } else {
      try {
        catgirl = jsonDecode(content);
      } catch (e) {
        log("Settings file is corrupted", LogTypes.warning);
        log("Error in settings file: $e", LogTypes.error);
      }
    }

    _codeTheme = catgirl[codeThemeKey] ?? _codeTheme;
    _sync = catgirl[syncKey] ?? _sync;
    _dirty = catgirl[modifiedKey] ?? _dirty;

    _theme = catgirl[themeKey] ?? defaultTheme.name;

    log("code theme: $_codeTheme", LogTypes.info);
    log("theme: $_theme", LogTypes.info);
    log("sync: $_sync", LogTypes.info);
    log("dirty: $_dirty", LogTypes.info);

    NcThemes.setTheme(NcThemes.all[theme] ?? defaultTheme);
    log("loaded settings", LogTypes.tracking);
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

    log("saved settings", LogTypes.tracking);
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
    NcThemes.setTheme(NcThemes.all[theme] ?? defaultTheme);
    markClean();
    _update();
  }
}

import 'package:codebook/db/sync/sync.dart';
import 'package:codebook/updater/updater.dart';
import 'package:codebook/widgets/home/home.dart';
import 'package:codebook/db/db.dart';
import 'package:codebook/db/settings.dart';
import 'package:codebook/themes.dart';
import 'package:codebook/widgets/themed_loading_indicator.dart';
import 'package:codebook/widgets/update_prompt/update_prompt.dart';
import 'package:flutter/material.dart';
import 'package:nekolib_ui/core.dart';
import 'package:nekolib_utils/log.dart';

/// Default duration for hover animations.
const kHoverDuration = Duration(milliseconds: 50);

/// Default scale for hover animations.
const kHoverScale = 1.025;

void main() async {
  CustomThemes.init();
  Logger.init(autoSave: true, appStoragePath: (await DB.appDir).path);

  NcThemes.initPredefinedThemes();
  await Settings.load();

  runThemedApp(
    appBuilder: (context) => App(),
    onLoad: loadAll(),
    loadingWidgetBuilder: (context) => ThemedLoadingIndicator(),
  );
}

/// Loads all the data required for the app to work.
Future loadAll() async {
  await Updater.init();

  if (Updater.updateAvailable) return;

  await DB.load();
  await Sync.load();
  if (Settings.sync) await Sync.sync();
}

/// The main app widget.
class App extends StatefulWidget {
  /// The main app widget.
  const App({Key? key}) : super(key: key);

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    return NcApp(
      builder: (context) => MaterialApp(
        title: Updater.appName,
        // ignore: prefer_const_constructors
        home: !Updater.updateAvailable ? Home() : UpdatePrompt(),
      ),
    );
  }
}

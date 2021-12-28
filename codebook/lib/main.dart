import 'package:codebook/db/sync/sync.dart';
import 'package:codebook/updater/updater.dart';
import 'package:codebook/widgets/home/home.dart';
import 'package:codebook/db/db.dart';
import 'package:codebook/db/settings.dart';
import 'package:codebook/themes.dart';
import 'package:codebook/widgets/themed_loading_indicator.dart';
import 'package:codebook/widgets/update_prompt/update_prompt.dart';
import 'package:flutter/material.dart';

void main() async {
  CustomThemes.registerAll();

  await Settings.load();

  runApp(
    FutureBuilder(future: loadAll(), builder: (context, task) => task.connectionState == ConnectionState.done ? const App() : const ThemedLoadingIndicator()),
  );
}

Future loadAll() async {
  await DB.load();
  await Updater.init();
  await Sync.load();
}

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  void initState() {
    super.initState();
    Settings.onUpdate = () => setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: Updater.appName,
      // ignore: prefer_const_constructors
      home: !Updater.updateAvailable ? Home() : UpdatePrompt(),
    );
  }
}

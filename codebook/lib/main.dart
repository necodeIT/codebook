import 'package:codebook/updater/updater.dart';
import 'package:codebook/widgets/home/home.dart';
import 'package:codebook/db/db.dart';
import 'package:codebook/db/settings.dart';
import 'package:codebook/themes.dart';
import 'package:codebook/widgets/update_prompt/update_prompt.dart';
import 'package:flutter/material.dart';
import 'package:nekolib.ui/ui.dart';

void main() async {
  CustomThemes.registerAll();

  await Settings.load();

  runApp(
    FutureBuilder(future: loadAll(), builder: (context, task) => task.connectionState == ConnectionState.done ? const App() : loadingIndicator()),
  );
}

Widget loadingIndicator() => Container(
      color: NcThemes.current.primaryColor,
      width: double.infinity,
      height: double.infinity,
      child: Center(
        child: CircularProgressIndicator(
          color: NcThemes.current.accentColor,
          backgroundColor: Colors.transparent,
        ),
      ),
    );

Future loadAll() {
  return Future(() async {
    await DB.load();
    await Updater.init();
  });
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
      home: !Updater.updateAvailable
          ? Home(
              refresh: () => setState(() {}),
            )
          : const UpdatePrompt(),
    );
  }
}

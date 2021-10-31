import 'package:codebook/widgets/codebook/codebook.dart';
import 'package:codebook/db/db.dart';
import 'package:codebook/db/settings.dart';
import 'package:codebook/themes.dart';
import 'package:codebook/widgets/text_input/input.dart';
import 'package:flutter/material.dart';
import 'package:nekolib.ui/ui.dart';

import 'db/ingredient.dart';

void main() {
  CustomThemes.registerAll();
  NcThemes.current = NcThemes.ocean;

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
  // DB.import([
  //   Ingredient(language: "cs", code: "public static void Main() {}", tags: ["Main", "Catgirl", "Bunnygirl"], desc: "Catgirl dies das"),
  //   Ingredient(language: "cs", code: "public static void Main() {}", tags: ["Main", "Catgirl", "Bunnygirl"], desc: "Catgirl dies das"),
  //   Ingredient(language: "cs", code: "public static void Main() {}", tags: ["Main", "Catgirl", "Bunnygirl"], desc: "Catgirl dies das"),
  //   Ingredient(language: "cs", code: "public static void Main() {}", tags: ["Main", "Catgirl", "Bunnygirl"], desc: "Catgirl dies das"),
  //   Ingredient(language: "cs", code: "public static void Main() {}", tags: ["Main", "Catgirl", "Bunnygirl"], desc: "Catgirl dies das"),
  //   Ingredient(language: "cs", code: "public static void Main() {}", tags: ["Main", "Catgirl", "Bunnygirl"], desc: "Catgirl dies das"),
  // ]);
  return Future(() async {
    await DB.load();
    Settings.load();
  });
}

Future saveAll() {
  return Future(() async {
    await DB.save();
    Settings.save();
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
    NcThemes.onCurrentThemeChange = setState;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // scrollBehavior: NcScrollBehavior(),
      title: "CodeBook",
      home: Scaffold(
        body: const CodeBook(),
        backgroundColor: NcThemes.current.secondaryColor,
      ),
    );
  }
}

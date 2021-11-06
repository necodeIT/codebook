import 'package:codebook/widgets/home/home.dart';
import 'package:codebook/db/db.dart';
import 'package:codebook/db/settings.dart';
import 'package:codebook/themes.dart';
import 'package:flutter/material.dart';
import 'package:nekolib.ui/ui.dart';

void main() {
  CustomThemes.registerAll();

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
    await Settings.load();
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
      title: "CodeBook",
      home: Home(
        refresh: () => setState(() {}),
      ),
    );
  }
}

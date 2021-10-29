import 'package:codebook/codebook.dart';
import 'package:codebook/themes.dart';
import 'package:codebook/widgets/language_tag/language_input.dart';
import 'package:flutter/material.dart';
import 'package:nekolib.ui/ui.dart';

void main() {
  CustomThemes.registerAll();
  NcThemes.current = CustomThemes.lightPurple;
  runApp(const App());
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
      title: 'CodeBook',
      home: Scaffold(
        body: const CodeBook(),
        backgroundColor: NcThemes.current.secondaryColor,
      ),
    );
  }
}

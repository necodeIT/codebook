import 'package:codebook/codebook.dart';
import 'package:flutter/material.dart';
import 'package:nekolib.ui/ui.dart';

void main() {
  NcThemes.current = NcThemes.dark;
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
      title: 'Flutter Demo',
      home: Scaffold(
        body: const CodeBook(),
        backgroundColor: NcThemes.current.secondaryColor,
      ),
    );
  }
}

// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:nekolib.ui/ui.dart';
import 'package:web/widgets/adaptive_layout_builder.dart';
import 'package:web/widgets/home/desktop.dart';
import 'package:web/widgets/home/mobile.dart';
import 'package:web/widgets/home/tablet.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  static const repo = "https://github.com/necodeIT/code-book";

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    super.initState();
    NcThemes.onCurrentThemeChange = () => setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: NcThemes.current.secondaryColor,
      body: AdaptiveLayoutBuilder(
        tabletBreakpoint: 1550.0,
        mobileBreakpoint: 600.0,
        desktop: HomeDesktopLayout(),
        mobile: HomeMobileLayout(),
        tablet: HomeTabletLayout(),
      ),
    );
  }
}

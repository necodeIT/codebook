// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:nekolib.ui/ui.dart';
import 'package:web/themes.dart.dart';
import 'package:web/widgets/adaptive_layout_builder.dart';
import 'package:web/widgets/adaptive_layout_property.dart';
import 'package:web/widgets/home/desktop.dart';
import 'package:web/widgets/home/mobile.dart';
import 'package:web/widgets/home/tablet.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  static const repo = "https://github.com/necodeIT/code-book";
  static const double tabletBreakpoint = 1550;
  static const double mobileBreakpoint = 600;

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var autoSetTheme = false;

  var isMobile = AdaptiveLayoutProperty(breakPoints: {
    double.infinity: false,
    Home.mobileBreakpoint: true,
  });

  @override
  void initState() {
    super.initState();
    NcThemes.onCurrentThemeChange = () => setState(() {});
    autoSetTheme = true;
  }

  setTheme(BuildContext context) {
    if (!autoSetTheme) return;

    var brightness = MediaQuery.of(context).platformBrightness;
    bool isDarkMode = brightness == Brightness.dark;
    if (isDarkMode) NcThemes.current = CustomThemes.darkPurple;

    autoSetTheme = false;
  }

  @override
  Widget build(BuildContext context) {
    setTheme(context);

    var mobile = isMobile.value(context);

    return Scaffold(
      backgroundColor: NcThemes.current.secondaryColor,
      body: AdaptiveLayoutBuilder(
        tabletBreakpoint: Home.tabletBreakpoint,
        mobileBreakpoint: Home.mobileBreakpoint,
        desktop: HomeDesktopLayout(),
        mobile: HomeMobileLayout(),
        tablet: HomeTabletLayout(),
      ),
      appBar: mobile
          ? AppBar(
              leading: Icon(
                Icons.menu,
                color: NcThemes.current.buttonTextColor,
              ),
              title: NcTitleText(
                "CodeBook",
                textAlign: TextAlign.center,
              ),
              backgroundColor: NcThemes.current.primaryColor,
            )
          : null,
      drawer: mobile
          ? Drawer(
              backgroundColor: NcThemes.current.primaryColor,
              child: ListView(
                children: [
                  DrawerHeader(child: NcTitleText("CodeBook")),
                  Divider(
                    color: NcThemes.current.tertiaryColor,
                    thickness: 3,
                  ),
                ],
              ),
            )
          : null,
    );
  }
}

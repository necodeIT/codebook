// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:nekolib.ui/ui.dart';
import 'package:url_strategy/url_strategy.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:web/widgets/home/home.dart';
import 'package:web/widgets/auth/auth.dart';
import 'package:responsive_framework/responsive_framework.dart';

void main() {
  NcThemes.current = NcThemes.ocean;
  setPathUrlStrategy();
  runApp(const App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'CodeBook',
      // builder: (context, widget) => ResponsiveWrapper.builder(
      //   widget,
      //   maxWidth: 1920,
      //   minWidth: 480,
      //   defaultScale: true,
      //   breakpoints: [
      //     ResponsiveBreakpoint.resize(480, name: MOBILE),
      //     ResponsiveBreakpoint.resize(1920, name: TABLET),
      //     ResponsiveBreakpoint.resize(1920 * 4, name: DESKTOP),
      //   ],
      //   background: Container(
      //     color: NcThemes.current.tertiaryColor,
      //   ),
      // ),
      routeInformationParser: VxInformationParser(),
      routerDelegate: VxNavigator(routes: {
        '/': (_, __) => MaterialPage(child: Home()),
        '/auth': (_, __) => MaterialPage(child: Auth()),
      }),
    );
  }
}

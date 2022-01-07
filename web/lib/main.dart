// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:url_strategy/url_strategy.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:web/themes.dart.dart';
import 'package:web/widgets/404.dart';
import 'package:web/widgets/auth/auth.dart';
import 'package:web/widgets/home/home.dart';

void main() {
  CustomThemes.registerAll();
  setPathUrlStrategy();
  runApp(const App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'CodeBook',
      routeInformationParser: VxInformationParser(),
      routerDelegate: VxNavigator(
        routes: {
          Home.route: (_, __) => MaterialPage(child: Home()),
          Auth.route: (_, __) => MaterialPage(child: Auth()),
        },
        notFoundPage: (uri, params) => MaterialPage(child: NotFoundPage()),
      ),
    );
  }
}

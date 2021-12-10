import 'package:flutter/material.dart';
import 'package:nekolib.ui/ui.dart';

class Auth extends StatefulWidget {
  Auth({Key? key}) : super(key: key);

  @override
  _AuthState createState() => _AuthState();
}

class _AuthState extends State<Auth> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: NcThemes.current.secondaryColor,
      body: Center(
        child: CircularProgressIndicator(
          color: NcThemes.current.accentColor,
        ),
      ),
    );
  }
}

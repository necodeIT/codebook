import 'package:flutter/material.dart';
import 'package:nekolib.ui/ui.dart';


class NotFoundPage extends StatelessWidget {
  const NotFoundPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: NcThemes.current.primaryColor,
      body: Center(
        child: NcBodyText('404'),
      ),
    );
  }
}

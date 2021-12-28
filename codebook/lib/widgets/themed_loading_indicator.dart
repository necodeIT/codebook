import 'package:flutter/material.dart';
import 'package:nekolib.ui/ui.dart';

class ThemedLoadingIndicator extends StatelessWidget {
  const ThemedLoadingIndicator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
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
  }
}

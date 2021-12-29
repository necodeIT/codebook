// ignore_for_file: prefer_const_constructors_in_immutables

import 'package:flutter/material.dart';
import 'package:nekolib.ui/ui.dart';

class ThemedLoadingIndicator extends StatelessWidget {
  ThemedLoadingIndicator({Key? key, this.containerColor, this.thickness = 4}) : super(key: key);

  final Color? containerColor;
  final double thickness;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: containerColor ?? NcThemes.current.primaryColor,
      width: double.infinity,
      height: double.infinity,
      child: Center(
        child: CircularProgressIndicator(
          strokeWidth: thickness,
          color: NcThemes.current.accentColor,
          backgroundColor: Colors.transparent,
        ),
      ),
    );
  }
}

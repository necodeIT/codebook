// ignore_for_file: prefer_const_constructors_in_immutables

import 'package:flutter/material.dart';
import 'package:nekolib.ui/ui.dart';

class ThemedDivider extends StatelessWidget {
  ThemedDivider({Key? key, this.thickness = defaultHeight}) : super(key: key);

  final double thickness;

  static const defaultHeight = 2.0;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: NcSpacing.smallSpacing),
      height: thickness,
      width: double.infinity,
      color: NcThemes.current.tertiaryColor,
    );
  }
}

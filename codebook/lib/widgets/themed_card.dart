// ignore_for_file: prefer_const_constructors_in_immutables

import 'package:flutter/material.dart';
import 'package:nekolib_ui/core.dart';

class ThemedCard extends StatelessWidget {
  ThemedCard({Key? key, required this.child, this.width, this.height, this.outlined = false, this.color}) : super(key: key);

  final Widget child;
  final double? width;
  final double? height;
  final bool outlined;
  final Color? color;

  static const double elevation = 3;
  static const double borderRadius = 5;
  static const double padding = 10;
  static const double outlinedBackgroundOpacity = .11;

  @override
  Widget build(BuildContext context) {
    var color = this.color ?? (outlined ? NcThemes.current.accentColor : NcThemes.current.primaryColor);

    return Material(
      borderRadius: BorderRadius.circular(borderRadius),
      color: NcThemes.current.primaryColor,
      elevation: !outlined ? elevation : 0,
      child: Container(
        padding: const EdgeInsets.all(padding),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(borderRadius),
          color: outlined ? color.withOpacity(outlinedBackgroundOpacity) : color,
          border: outlined ? Border.all(color: color) : null,
        ),
        width: width,
        height: height,
        child: child,
      ),
    );
  }
}

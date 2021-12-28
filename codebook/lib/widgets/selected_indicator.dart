import 'package:flutter/material.dart';
import 'package:nekolib.ui/ui.dart';

class SelectedIndicator extends StatelessWidget {
  // no const because the color wont update otherwise
  // ignore: prefer_const_constructors_in_immutables
  SelectedIndicator({Key? key, this.color}) : super(key: key);

  final Color? color;

  static const double padding = 2;
  static const double radius = 100;
  static const double iconSize = 15;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(padding),
      child: Icon(
        Icons.check,
        color: NcThemes.current.buttonTextColor,
        size: iconSize,
      ),
      decoration: BoxDecoration(color: color ?? NcThemes.current.accentColor, borderRadius: BorderRadius.circular(radius)),
    );
  }
}

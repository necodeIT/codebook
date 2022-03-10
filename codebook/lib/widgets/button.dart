// ignore_for_file: prefer_const_constructors_in_immutables

import 'package:flutter/material.dart';
import 'package:nekolib_ui/core.dart';

class ThemedElevatedButton extends StatelessWidget {
  ThemedElevatedButton({Key? key, required this.onPressed, required this.text, this.fontSize}) : super(key: key) {
    icon = null;
  }

  ThemedElevatedButton.icon({Key? key, required this.onPressed, required this.text, this.fontSize, required this.icon}) : super(key: key);

  final Function() onPressed;
  final String text;
  final double? fontSize;
  late final IconData? icon;

  @override
  Widget build(BuildContext context) {
    var fontSize = this.fontSize ?? 15;
    var style = ButtonStyle(backgroundColor: MaterialStateProperty.all(NcThemes.current.accentColor));
    var label = NcCaptionText(
      text,
      fontSize: fontSize,
      buttonText: true,
    );
    return icon != null
        ? ElevatedButton.icon(
            label: label,
            icon: Icon(
              icon,
              color: NcThemes.current.buttonTextColor,
              size: fontSize,
            ),
            onPressed: onPressed,
            style: style,
          )
        : ElevatedButton(
            onPressed: onPressed,
            child: label,
            style: style,
          );
  }
}

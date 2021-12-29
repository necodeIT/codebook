// ignore_for_file: prefer_const_constructors_in_immutables

import 'package:flutter/material.dart';
import 'package:nekolib.ui/ui.dart';

class ThemedToolTip extends StatelessWidget {
  ThemedToolTip({key, required this.message, this.child, this.delay = 1000}) : super(key: key);

  final String message;
  final Widget? child;
  final int delay;

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      waitDuration: Duration(milliseconds: delay),
      textStyle: NcBaseText.style(fontSize: 15, buttonText: true),
      decoration: BoxDecoration(
        color: NcThemes.current.tertiaryColor,
        borderRadius: BorderRadius.circular(5),
      ),
      message: message,
      child: child,
    );
  }
}

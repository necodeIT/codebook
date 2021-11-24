import 'package:flutter/material.dart';
import 'package:nekolib.ui/ui.dart';

class ThemedElevatedButton extends StatelessWidget {
  const ThemedElevatedButton({Key? key, required this.onPressed, required this.text, this.fontSize}) : super(key: key);

  final Function() onPressed;
  final String text;
  final double? fontSize;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      child: NcCaptionText(
        text,
        fontSize: fontSize ?? 15,
        buttonText: true,
      ),
      style: ButtonStyle(backgroundColor: MaterialStateProperty.all(NcThemes.current.accentColor)),
    );
  }
}

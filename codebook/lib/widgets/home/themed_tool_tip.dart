import 'package:flutter/material.dart';
import 'package:nekolib.ui/ui.dart';

class ThemedToolTip extends StatelessWidget {
  const ThemedToolTip({key, required this.message, this.child}) : super(key: key);

  final String message;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      waitDuration: const Duration(seconds: 1),
      textStyle: NcBaseText.style(fontSize: 15),
      decoration: BoxDecoration(
        color: NcThemes.current.tertiaryColor,
        borderRadius: BorderRadius.circular(5),
      ),
      message: message,
      child: child,
    );
  }
}

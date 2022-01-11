// ignore_for_file: prefer_const_constructors_in_immutables

import 'package:flutter/material.dart';
import 'package:nekolib.ui/ui.dart';

class FilterHeader extends StatelessWidget {
  FilterHeader({Key? key, required this.title, required this.active}) : super(key: key);

  final bool active;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            NcCaptionText(title),
            Checkbox(
              value: active,
              onChanged: (_) {},
              fillColor: MaterialStateProperty.all<Color>(NcThemes.current.accentColor),
              // overlayColor: MaterialStateProperty.all<Color>(NcThemes.current.buttonTextColor),
              // overlayColor: MaterialStateProperty.all<Color>(Colors.red),
              checkColor: NcThemes.current.buttonTextColor,
            ),
          ],
        ),
        Divider(color: NcThemes.current.tertiaryColor),
      ],
    );
  }
}

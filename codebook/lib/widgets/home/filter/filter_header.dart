import 'package:flutter/material.dart';
import 'package:nekolib_ui/core.dart';

class FilterHeader extends StatelessWidget {
  const FilterHeader({Key? key, required this.title, required this.active, this.onToggle}) : super(key: key);

  final Function(bool?)? onToggle;
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
              onChanged: onToggle,
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

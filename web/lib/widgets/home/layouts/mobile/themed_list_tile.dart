// ignore_for_file: prefer_const_constructors_in_immutables

import 'package:flutter/material.dart';
import 'package:nekolib.ui/ui.dart';

class ThemedListTile extends StatelessWidget {
  ThemedListTile({Key? key, required this.leading, required this.title, this.subtitle, this.onTap}) : super(key: key);

  final IconData leading;
  final String title;
  final String? subtitle;
  final Function()? onTap;

  static const double titleSize = 15;
  static const double subtitleSize = 13;
  static const double iconSize = titleSize + subtitleSize;
  static const double singleTitleSize = 18;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(
        leading,
        color: NcThemes.current.textColor,
        size: iconSize,
      ),
      iconColor: NcThemes.current.textColor,
      title: NcCaptionText(
        title,
        selectable: false,
        fontSize: subtitle != null ? titleSize : singleTitleSize,
      ),
      subtitle: subtitle == null
          ? null
          : NcBodyText(
              subtitle!,
              selectable: false,
              fontSize: subtitleSize,
            ),
      onTap: onTap,
      // dense: true,
    );
  }
}

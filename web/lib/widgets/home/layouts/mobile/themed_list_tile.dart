// ignore_for_file: prefer_const_constructors_in_immutables

import 'package:flutter/material.dart';
import 'package:nekolib.ui/ui.dart';

class ThemedListTile extends StatelessWidget {
  ThemedListTile({Key? key, required this.leading, required this.title, this.subtitle, this.onTap, this.color}) : super(key: key);

  final IconData leading;
  final String title;
  final String? subtitle;
  final Color? color;
  final Function()? onTap;

  static const double titleSize = 15;
  static const double subtitleSize = 13;
  static const double iconSize = titleSize + subtitleSize;
  static const double singleTitleSize = 18;

  @override
  Widget build(BuildContext context) {
    var color = this.color ?? NcThemes.current.textColor;
    return ListTile(
      leading: Icon(
        leading,
        color: color,
        size: iconSize,
      ),
      iconColor: color,
      title: NcCaptionText(
        title,
        selectable: false,
        fontSize: subtitle != null ? titleSize : singleTitleSize,
        color: color,
      ),
      subtitle: subtitle == null
          ? null
          : NcBodyText(
              subtitle!,
              selectable: false,
              fontSize: subtitleSize,
              color: color,
            ),
      onTap: onTap,
      // dense: true,
    );
  }
}

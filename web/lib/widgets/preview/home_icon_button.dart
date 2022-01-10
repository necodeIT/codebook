// ignore_for_file: prefer_const_constructors_in_immutables

import 'package:flutter/material.dart';
import 'package:nekolib.ui/ui.dart';

import 'home/home.dart';

class HomeIconButton extends StatelessWidget {
  HomeIconButton({Key? key, required this.icon, this.color}) : super(key: key);

  final IconData icon;
  final Color? color;

  static const double iconSize = HomePreview.titleSize * .8;

  @override
  Widget build(BuildContext context) {
    return Icon(
      icon,
      color: color ?? NcThemes.current.tertiaryColor,
      size: iconSize,
    );
  }
}

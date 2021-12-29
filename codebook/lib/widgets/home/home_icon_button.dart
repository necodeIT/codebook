// ignore_for_file: prefer_const_constructors_in_immutables

import 'package:codebook/widgets/conditional_wrap/condtional_wrapper.dart';
import 'package:codebook/widgets/home/themed_tool_tip.dart';
import 'package:flutter/material.dart';
import 'package:nekolib.ui/ui.dart';

import 'home.dart';

class HomeIconButton extends StatelessWidget {
  HomeIconButton({Key? key, required this.tooltip, this.onPressed, required this.icon, this.color}) : super(key: key);

  final String tooltip;
  final Function()? onPressed;
  final IconData icon;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return ThemedToolTip(
      message: tooltip,
      child: ConditionalWrapper(
        condition: onPressed != null,
        builder: (context, child) {
          return IconButton(
            onPressed: onPressed,
            icon: child,
            splashColor: Colors.transparent,
            splashRadius: 1,
          );
        },
        child: Icon(
          icon,
          color: color ?? NcThemes.current.tertiaryColor,
          size: Home.iconSize,
        ),
      ),
    );
  }
}

// ignore_for_file: prefer_const_constructors_in_immutables

import 'package:codebook/main.dart';
import 'package:codebook/widgets/home/themed_tool_tip.dart';
import 'package:flutter/material.dart';
import 'package:nekolib_ui/core.dart';
import 'package:nekolib_ui/utils.dart';

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
        wrapper: (context, child) {
          return ScaleOnHover(
            scale: 1.1,
            duration: kHoverDuration,
            child: HoverBuilder(
              builder: (context, hovering) => GestureDetector(
                onTap: onPressed,
                child: _Icon(icon: icon, color: hovering ? accentColor : color, onPressed: onPressed),
              ),
            ),
          );
        },
        child: _Icon(icon: icon, color: color, onPressed: onPressed),
      ),
    );
  }
}

class _Icon extends StatelessWidget {
  const _Icon({Key? key, this.color, required this.icon, this.onPressed}) : super(key: key);

  final Color? color;
  final IconData icon;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        icon,
        color: color ?? NcThemes.current.tertiaryColor,
        size: Home.iconSize,
      ),
      splashColor: Colors.transparent,
      splashRadius: 0.1,
      onPressed: onPressed,
    );
  }
}

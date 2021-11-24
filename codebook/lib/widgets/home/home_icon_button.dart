import 'package:codebook/widgets/home/themed_tool_tip.dart';
import 'package:flutter/material.dart';
import 'package:nekolib.ui/ui.dart';

import 'home.dart';

class HomeIconButton extends StatelessWidget {
  const HomeIconButton({Key? key, required this.toolTip, required this.onPressed, required this.icon, this.color}) : super(key: key);

  final String toolTip;
  final Function() onPressed;
  final IconData icon;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return ThemedToolTip(
      message: toolTip,
      child: IconButton(
        onPressed: onPressed,
        icon: Icon(
          icon,
          color: color ?? NcThemes.current.tertiaryColor,
          size: Home.iconSize,
        ),
        splashColor: Colors.transparent,
        splashRadius: 1,
      ),
    );
  }
}

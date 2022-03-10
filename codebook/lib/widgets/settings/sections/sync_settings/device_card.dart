// ignore_for_file: prefer_const_constructors_in_immutables

import 'package:codebook/widgets/conditional_wrap/condtional_wrapper.dart';
import 'package:codebook/widgets/home/themed_tool_tip.dart';
import 'package:codebook/widgets/themed_card.dart';
import 'package:flutter/material.dart';
import 'package:nekolib_ui/core.dart';

class DeviceCard extends StatelessWidget {
  DeviceCard({Key? key, required this.icon, required this.label, this.onTap, this.outlined = false, this.tooltip, this.color}) : super(key: key);

  final IconData icon;
  final String label;
  final Function()? onTap;
  final String? tooltip;
  final bool outlined;
  final Color? color;

  static const double height = 180;
  static const double width = 180;
  static const double fontSize = 17;
  static const double iconSize = 50;

  @override
  Widget build(BuildContext context) {
    return ConditionalWrapper(
      condition: onTap == null && tooltip != null,
      builder: (context, child) => ThemedToolTip(message: tooltip!, child: child),
      child: ThemedCard(
        width: width,
        height: height,
        outlined: outlined,
        color: color,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: iconSize,
              color: color ?? (outlined ? NcThemes.current.accentColor : NcThemes.current.tertiaryColor),
            ),
            NcSpacing.large(),
            onTap != null
                ? ConditionalWrapper(
                    condition: tooltip != null,
                    builder: (context, child) => ThemedToolTip(
                      message: tooltip!,
                      child: child,
                    ),
                    child: TextButton(
                      onPressed: onTap,
                      child: Text(
                        label,
                        style: NcBaseText.style(fontSize: fontSize, color: color ?? NcThemes.current.accentColor, fontWeight: FontWeight.w600),
                      ),
                    ),
                  )
                : NcCaptionText(label, color: color ?? NcThemes.current.textColor, fontSize: fontSize),
          ],
        ),
      ),
    );
  }
}

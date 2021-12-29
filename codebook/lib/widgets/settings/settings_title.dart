// ignore_for_file: prefer_const_constructors_in_immutables

import 'package:codebook/widgets/conditional_wrap/condtional_wrapper.dart';
import 'package:codebook/widgets/home/filter/input.dart';
import 'package:codebook/widgets/settings/settings.dart';
import 'package:flutter/material.dart';
import 'package:nekolib.ui/ui.dart';

class SettingsTitle extends StatelessWidget {
  SettingsTitle({Key? key, this.onQuerry, required this.title, this.trailing, this.trailingSpacing = NcSpacing.smallSpacing}) : super(key: key);

  final String title;
  final Widget? trailing;
  final double trailingSpacing;
  final Function(String)? onQuerry;

  @override
  Widget build(BuildContext context) {
    return ConditionalWrapper(
      condition: onQuerry != null,
      child: ConditionalWrapper(
        condition: trailing != null,
        builder: (context, child) => Row(
          children: [child, SizedBox(width: trailingSpacing), trailing!],
        ),
        child: NcCaptionText(
          title,
          fontSize: SettingsPage.titleSize,
          textAlign: TextAlign.start,
        ),
      ),
      builder: (context, child) => Stack(
        children: [
          child,
          Center(
            child: Container(
              padding: const EdgeInsets.only(right: NcSpacing.xlSpacing),
              width: SettingsPage.searchWidth,
              child: FilterInput(placeholder: "Search", onChanged: onQuerry!),
            ),
          )
        ],
      ),
    );
  }
}

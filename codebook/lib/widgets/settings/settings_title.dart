import 'package:codebook/widgets/conditional_wrap/condtional_wrapper.dart';
import 'package:codebook/widgets/home/filter/input.dart';
import 'package:codebook/widgets/settings/settings.dart';
import 'package:flutter/material.dart';
import 'package:nekolib.ui/ui.dart';

class SettingsTitle extends StatelessWidget {
  const SettingsTitle({Key? key, this.onQuerry, required this.title, this.trailing}) : super(key: key);

  final String title;
  final Widget? trailing;
  final Function(String)? onQuerry;

  @override
  Widget build(BuildContext context) {
    return ConditionalWrapper(
      condition: onQuerry != null,
      child: NcCaptionText(title, fontSize: SettingsPage.titleSize),
      builder: (context, child) => Stack(
        children: [
          ConditionalWrapper(
            condition: trailing != null,
            builder: (context, child) => Row(
              children: [child, NcSpacing.medium(), trailing!],
            ),
            child: child,
          ),
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

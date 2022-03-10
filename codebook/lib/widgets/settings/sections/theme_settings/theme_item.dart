import 'package:codebook/widgets/conditional_wrap/condtional_wrapper.dart';
import 'package:codebook/widgets/settings/sections/code_themes_settings/code_theme.dart';
import 'package:codebook/widgets/selected_indicator.dart';
import 'package:codebook/widgets/themed_card.dart';
import 'package:flutter/material.dart';
import 'package:nekolib_ui/core.dart';

class ThemeItem extends StatelessWidget {
  const ThemeItem({Key? key, required this.theme, required this.selected, required this.onTap}) : super(key: key);

  final NcTheme theme;
  final bool selected;
  final Function() onTap;

  static const double width = CodeTheme.minWidth;
  static const double height = 160;

  @override
  Widget build(BuildContext context) {
    return ConditionalWrapper(
      condition: !selected,
      builder: (context, child) => MouseRegion(
        cursor: SystemMouseCursors.click,
        child: GestureDetector(
          onTap: onTap,
          child: child,
        ),
      ),
      child: ThemedCard(
        width: ThemeItem.width,
        height: ThemeItem.height,
        outlined: selected,
        child: Column(
          children: [
            Align(
              alignment: Alignment.topRight,
              child: selected ? SelectedIndicator() : const SizedBox(height: SelectedIndicator.iconSize + SelectedIndicator.padding),
            ),
            NcSpacing.medium(),
            Icon(
              theme.icon,
              color: theme.iconColor,
              size: 30,
            ),
            NcSpacing.xl(),
            NcBodyText(theme.name),
          ],
        ),
      ),
    );
  }
}

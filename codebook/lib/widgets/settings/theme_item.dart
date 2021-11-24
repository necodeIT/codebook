import 'package:codebook/widgets/codeblock/code_block.dart';
import 'package:codebook/widgets/codeblock/tag/tag_input.dart';
import 'package:codebook/widgets/conditional_wrap/condtional_wrapper.dart';
import 'package:codebook/widgets/home/filter/filter.dart';
import 'package:codebook/widgets/settings/code_theme.dart';
import 'package:codebook/widgets/settings/selected_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nekolib.ui/ui.dart';
import 'package:nekolib.ui/ui/themes/theme.dart';
import 'package:nekolib.ui/ui/themes/themes.dart';

class ThemeItem extends StatelessWidget {
  const ThemeItem({Key? key, required this.theme, required this.selected, required this.onTap}) : super(key: key);

  final NcTheme theme;
  final bool selected;
  final Function() onTap;

  static const double width = CodeTheme.minWidth;
  static const double height = 150;

  @override
  Widget build(BuildContext context) {
    return ConditionalWrapper(
      condition: !selected,
      builder: (context, child) => MouseRegion(
        cursor: SystemMouseCursors.click,
        child: Material(
          borderRadius: BorderRadius.circular(CodeBlock.borderRadius),
          child: GestureDetector(
            onTap: onTap,
            child: child,
          ),
          color: NcThemes.current.primaryColor,
          elevation: CodeBlock.elevation,
        ),
      ),
      child: Container(
        padding: const EdgeInsets.all(CodeTheme.padding),
        width: ThemeItem.width,
        height: ThemeItem.height,
        decoration: BoxDecoration(
          border: Border.all(color: selected ? NcThemes.current.accentColor : NcThemes.current.primaryColor),
          borderRadius: BorderRadius.circular(CodeBlock.borderRadius),
          color: selected ? NcThemes.current.accentColor.withOpacity(TagInput.backgroundOpacity) : NcThemes.current.primaryColor,
        ),
        child: Column(
          children: [
            Align(
              alignment: Alignment.topRight,
              child: selected ? const SelectedIndicator() : const SizedBox(height: SelectedIndicator.iconSize + SelectedIndicator.padding),
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

import 'package:codebook/widgets/home/filter/filter.dart';
import 'package:flutter/material.dart';
import 'package:nekolib.ui/ui.dart';

import 'package:codebook/widgets/codeblock/language_tag/language_input.dart';
import 'package:codebook/widgets/codeblock/tag/tag.dart';

class FilterSelect extends StatelessWidget {
  const FilterSelect({Key? key, required this.selected, required this.label, this.radio = false, required this.onTap}) : super(key: key);

  final bool selected;
  final String label;
  final bool radio;
  final Function(String) onTap;

  @override
  Widget build(BuildContext context) {
    var color = !selected ? NcThemes.current.tertiaryColor : NcThemes.current.accentColor;

    return AnimatedSize(
      duration: Filter.animationDuration,
      curve: Filter.animationCurve,
      child: Padding(
        padding: const EdgeInsets.only(bottom: NcSpacing.smallSpacing, right: NcSpacing.smallSpacing),
        child: GestureDetector(
          onTap: () => onTap(label),
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: Tag.defaultBaddingVertical, horizontal: Tag.defaultPaddingHorizontal),
            decoration: BoxDecoration(
              border: Border.all(color: color),
              borderRadius: BorderRadius.circular(Tag.defaultBorderRadius),
              color: color.withOpacity(LanguageInput.backgroundOpacity),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (!radio && selected)
                  Icon(
                    Icons.check,
                    color: color,
                    size: Tag.defaultFontSize,
                  ),
                if (!radio && selected) NcSpacing.xs(),
                Text(
                  label,
                  style: TextStyle(
                    color: color,
                    fontSize: Tag.defaultFontSize,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

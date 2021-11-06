import 'package:codebook/widgets/conditional_wrap/condtional_wrapper.dart';
import 'package:codebook/widgets/codeblock/language_tag/language_input.dart';
import 'package:codebook/widgets/home/filter/filter.dart';
import 'package:flutter/material.dart';
import 'package:nekolib.ui/ui.dart';
import 'package:nekolib.ui/ui/themes/themes.dart';

class Tag extends StatelessWidget {
  Tag({Key? key, required this.label, this.editMode = false, this.onTap, this.fontSize = defaultFontSize, this.padding = defaultPadding, this.color}) : super(key: key) {
    detectAll = false;
    icon = Icons.close;
  }

  Tag.add({Key? key, required this.onTap, this.fontSize = defaultFontSize, this.padding = defaultPadding, String? label, IconData? icon, this.color}) : super(key: key) {
    detectAll = true;
    this.icon = icon ?? Icons.add;
    editMode = false;
    this.label = label ?? "Tag";
  }

  late final Color? color;
  late final String label;
  late final IconData? icon;
  final Function()? onTap;
  late final bool editMode;
  late final bool detectAll;
  final double fontSize;
  final EdgeInsets padding;

  static const double defaultBorderRadius = 30;
  static const double defaultBaddingVertical = 5;
  static const double defaultPaddingHorizontal = 10;
  static const defaultPadding = EdgeInsets.symmetric(vertical: Tag.defaultBaddingVertical, horizontal: Tag.defaultPaddingHorizontal);
  static const double defaultFontSize = 15;

  @override
  build(BuildContext context) {
    var color = this.color ?? (editMode ? NcThemes.current.tertiaryColor : NcThemes.current.accentColor);

    return AnimatedSize(
      duration: Filter.animationDuration,
      curve: Filter.animationCurve,
      child: ConditionalWrapper(
        condition: detectAll && onTap != null,
        builder: (context, child) => GestureDetector(
          onTap: onTap,
          child: child,
        ),
        child: Container(
          padding: padding,
          decoration: BoxDecoration(
            border: Border.all(color: color),
            borderRadius: BorderRadius.circular(Tag.defaultBorderRadius),
            color: color.withOpacity(LanguageInput.backgroundOpacity),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (detectAll) Icon(icon, color: color, size: Tag.defaultFontSize),
              if (detectAll) NcSpacing.xs(),
              Text(
                label,
                style: TextStyle(
                  color: color,
                  fontSize: fontSize,
                ),
              ),
              if (!detectAll && editMode) NcSpacing.xs(),
              if (!detectAll && editMode)
                ConditionalWrapper(
                  builder: (context, child) => GestureDetector(
                    onTap: onTap,
                    child: child,
                  ),
                  child: Icon(icon, color: color, size: fontSize),
                  condition: onTap != null,
                ),
            ],
          ),
        ),
      ),
    );
  }
}

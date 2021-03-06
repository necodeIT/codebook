import 'package:codebook/widgets/codeblock/language_tag/language_input.dart';
import 'package:codebook/widgets/home/filter/filter.dart';
import 'package:flutter/material.dart';
import 'package:nekolib_ui/core.dart';
import 'package:nekolib_ui/utils.dart';

class Tag extends StatelessWidget {
  Tag({Key? key, required this.label, this.editMode = false, this.onTap, this.fontSize = defaultFontSize, this.padding = defaultPadding, this.color}) : super(key: key) {
    detectAll = false;
    icon = Icons.close;
  }

  Tag.add({Key? key, required this.onTap, this.fontSize = defaultFontSize, this.padding = defaultPadding, String? label, this.icon, this.color}) : super(key: key) {
    detectAll = true;
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
        wrapper: (context, child) => MouseRegion(
          cursor: SystemMouseCursors.click,
          child: GestureDetector(
            onTap: onTap,
            child: child,
          ),
        ),
        child: HoverBuilder(
          builder: (context, hovering) => AnimatedContainer(
            duration: Filter.animationDuration,
            curve: Filter.animationCurve,
            padding: padding,
            decoration: BoxDecoration(
              border: Border.all(color: hovering ? accentColor : color),
              borderRadius: BorderRadius.circular(Tag.defaultBorderRadius),
              color: (hovering ? accentColor : color).withOpacity(LanguageInput.backgroundOpacity),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (detectAll && icon != null) Icon(icon, color: color, size: Tag.defaultFontSize),
                if (detectAll && icon != null) NcSpacing.xs(),
                NcBodyText(
                  label,
                  color: hovering ? accentColor : color,
                  fontSize: fontSize,
                ),
                if (!detectAll && editMode && icon != null) NcSpacing.xs(),
                if (!detectAll && editMode && icon != null)
                  ConditionalWrapper(
                    wrapper: (context, child) => MouseRegion(
                      cursor: SystemMouseCursors.click,
                      child: GestureDetector(
                        onTap: onTap,
                        child: child,
                      ),
                    ),
                    child: Icon(icon, color: hovering ? accentColor : color, size: fontSize),
                    condition: onTap != null,
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

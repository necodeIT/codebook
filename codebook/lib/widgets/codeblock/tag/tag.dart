import 'package:codebook/widgets/conditional_wrap/condtional_wrapper.dart';
import 'package:codebook/widgets/codeblock/language_tag/language_input.dart';
import 'package:codebook/widgets/home/filter/filter.dart';
import 'package:flutter/material.dart';
import 'package:nekolib.ui/ui.dart';
import 'package:nekolib.ui/ui/themes/themes.dart';

class Tag extends StatelessWidget {
  Tag({Key? key, required this.label, required this.editMode, this.onTap}) : super(key: key) {
    detectAll = false;
    icon = Icons.close;
  }

  Tag.add({Key? key, required this.onTap}) : super(key: key) {
    detectAll = true;
    icon = Icons.add;
    editMode = false;
    label = "Tag";
  }

  late final String label;
  late final IconData? icon;
  final Function()? onTap;
  late final bool editMode;
  late final bool detectAll;

  static const double borderRadius = 30;
  static const double paddingVertical = 5;
  static const double paddingHorizontal = 10;
  static const double fontSize = 15;

  @override
  build(BuildContext context) {
    var color = editMode ? NcThemes.current.tertiaryColor : NcThemes.current.accentColor;

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
          padding: const EdgeInsets.symmetric(vertical: Tag.paddingVertical, horizontal: Tag.paddingHorizontal),
          decoration: BoxDecoration(
            border: Border.all(color: color),
            borderRadius: BorderRadius.circular(Tag.borderRadius),
            color: color.withOpacity(LanguageInput.backgroundOpacity),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (detectAll) Icon(icon, color: color, size: Tag.fontSize),
              if (detectAll) NcSpacing.xs(),
              Text(
                label,
                style: TextStyle(
                  color: color,
                  fontSize: Tag.fontSize,
                ),
              ),
              if (!detectAll && editMode) NcSpacing.xs(),
              if (!detectAll && editMode)
                ConditionalWrapper(
                  builder: (context, child) => GestureDetector(
                    onTap: onTap,
                    child: child,
                  ),
                  child: Icon(icon, color: color, size: Tag.fontSize),
                  condition: onTap != null,
                ),
            ],
          ),
        ),
      ),
    );
  }
}

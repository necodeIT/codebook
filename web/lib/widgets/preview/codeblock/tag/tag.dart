import 'package:flutter/material.dart';
import 'package:nekolib.ui/ui.dart';
import 'package:web/widgets/preview/codeblock/language_tag/language_input.dart';

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

    return Container(
      padding: padding,
      decoration: BoxDecoration(
        border: Border.all(color: color),
        borderRadius: BorderRadius.circular(Tag.defaultBorderRadius),
        color: color.withOpacity(LanguageInput.backgroundOpacity),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (detectAll && icon != null) Icon(icon, color: color, size: Tag.defaultFontSize),
          if (detectAll && icon != null) NcSpacing.xs(),
          NcBodyText(
            label,
            color: color,
            fontSize: fontSize,
            selectable: false,
          ),
        ],
      ),
    );
  }
}

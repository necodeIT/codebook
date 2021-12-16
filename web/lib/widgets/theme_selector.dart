import 'package:flutter/material.dart';
import 'package:nekolib.ui/ui.dart';
import 'package:web/widgets/condtional_wrapper.dart.dart';

class ThemeSelector extends StatelessWidget {
  const ThemeSelector({Key? key, required this.theme}) : super(key: key);

  final NcTheme theme;

  static const double radius = 50;
  static const double borderWidth = 1;
  static const double size = 35;
  static const double iconSize = 15;
  static const double margin = 20;

  @override
  Widget build(BuildContext context) {
    var isCurrent = NcThemes.current == theme;

    return ConditionalWrapper(
      condition: !isCurrent,
      builder: (context, child) {
        return GestureDetector(
          child: child,
          onTap: () => NcThemes.current = theme,
        );
      },
      child: Container(
        margin: const EdgeInsets.only(right: margin),
        height: size,
        width: size,
        decoration: BoxDecoration(
          color: theme.primaryColor,
          borderRadius: BorderRadius.circular(radius),
          border: Border.all(
            color: isCurrent ? theme.accentColor : theme.primaryColor,
            width: borderWidth,
          ),
          boxShadow: ncShadow,
        ),
        child: Center(
          child: Icon(
            theme.icon,
            size: iconSize,
            color: theme.iconColor,
          ),
        ),
      ),
    );
  }
}

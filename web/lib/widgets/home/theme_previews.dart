// ignore_for_file: prefer_const_constructors_in_immutables

import 'package:flutter/material.dart';
import 'package:nekolib.ui/ui.dart';
import 'package:web/themes.dart.dart';
import 'package:web/widgets/theme_selector.dart';

class ThemePreviews extends StatelessWidget {
  ThemePreviews({Key? key, this.mainAxisAlignment = MainAxisAlignment.end, this.crossAxisAlignment = CrossAxisAlignment.start, this.mainAxisSize = MainAxisSize.max}) : super(key: key);

  final MainAxisAlignment mainAxisAlignment;
  final CrossAxisAlignment crossAxisAlignment;
  final MainAxisSize mainAxisSize;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: mainAxisAlignment,
      crossAxisAlignment: crossAxisAlignment,
      mainAxisSize: mainAxisSize,
      children: [
        ThemeSelector(theme: NcThemes.light),
        ThemeSelector(theme: NcThemes.sakura),
        ThemeSelector(theme: CustomThemes.darkPurple),
        ThemeSelector(theme: NcThemes.ocean),
      ],
    );
  }
}

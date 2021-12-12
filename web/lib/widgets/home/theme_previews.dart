// ignore_for_file: prefer_const_constructors_in_immutables

import 'package:flutter/material.dart';
import 'package:nekolib.ui/ui.dart';
import 'package:web/themes.dart.dart';
import 'package:web/widgets/theme_selector.dart';

class ThemePreviews extends StatelessWidget {
  ThemePreviews({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ThemeSelector(theme: NcThemes.light),
        ThemeSelector(theme: NcThemes.sakura),
        ThemeSelector(theme: CustomThemes.darkPurple),
        ThemeSelector(theme: NcThemes.ocean),
      ],
    );
  }
}

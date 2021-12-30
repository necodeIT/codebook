// ignore_for_file: prefer_const_constructors_in_immutables

import 'package:codebook/widgets/settings/settings_title.dart';
import 'package:codebook/widgets/settings/sections/theme_settings/theme_item.dart';
import 'package:flutter/material.dart';
import 'package:nekolib.ui/ui.dart';

class ThemeSettings extends StatefulWidget {
  ThemeSettings({Key? key}) : super(key: key);

  @override
  State<ThemeSettings> createState() => _ThemeSettingsState();
}

class _ThemeSettingsState extends State<ThemeSettings> {
  String _querry = "";

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SettingsTitle(title: "Themes", onQuerry: updateQuerry),
        NcSpacing.small(),
        Wrap(
          spacing: NcSpacing.smallSpacing,
          runSpacing: NcSpacing.smallSpacing,
          children: [
            for (var theme in NcThemes.all.values)
              if (theme.name.toLowerCase().contains(_querry.toLowerCase())) ThemeItem(theme: theme, selected: NcThemes.current == theme, onTap: () => updateTheme(theme)),
          ],
        ),
      ],
    );
  }

  updateQuerry(String theme) {
    setState(() {
      _querry = theme;
    });
  }

  updateTheme(NcTheme theme) {
    setState(() {
      NcThemes.current = theme;
    });
  }
}

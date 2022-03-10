// ignore_for_file: prefer_const_constructors_in_immutables

import 'package:codebook/code_themes.dart';
import 'package:codebook/db/settings.dart';
import 'package:codebook/themes.dart';
import 'package:codebook/widgets/codeblock/tag/tag.dart';
import 'package:codebook/widgets/settings/sections/code_themes_settings/code_theme.dart';
import 'package:codebook/widgets/settings/settings.dart';
import 'package:codebook/widgets/settings/settings_title.dart';
import 'package:flutter/material.dart';
import 'package:nekolib_ui/core.dart';

class CodeThemeSettings extends StatefulWidget {
  CodeThemeSettings({Key? key}) : super(key: key);

  @override
  State<CodeThemeSettings> createState() => _CodeThemeSettingsState();
}

class _CodeThemeSettingsState extends State<CodeThemeSettings> {
  String _querry = "";

  @override
  Widget build(BuildContext context) {
    var usingRecommended = Settings.codeTheme == CustomThemes.recommendedCodeThemes[NcThemes.current];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SettingsTitle(
          title: "Code Themes",
          trailing: Tag.add(
            label: usingRecommended ? SettingsPage.recommendedLabel : SettingsPage.useRecommendedLabel,
            fontSize: SettingsPage.recommendedFontSize,
            padding: SettingsPage.recommendedPadding,
            onTap: () => updateCodeTheme(CustomThemes.recommendedCodeThemes[NcThemes.current]!),
            icon: usingRecommended ? Icons.check : Icons.warning_amber_rounded,
            color: usingRecommended ? NcThemes.current.successColor : NcThemes.current.warningColor,
          ),
          onQuerry: updateQuerry,
        ),
        NcSpacing.small(),
        Wrap(
          spacing: NcSpacing.smallSpacing,
          runSpacing: NcSpacing.smallSpacing,
          children: [
            for (var theme in kCodeThemes.keys)
              if (theme.toLowerCase().contains(_querry.toLowerCase())) CodeTheme(theme: theme, recomended: CustomThemes.recommendedCodeThemes[NcThemes.current] == theme, selected: Settings.codeTheme == theme, onTap: () => updateCodeTheme(theme)),
          ],
        ),
      ],
    );
  }

  updateCodeTheme(String theme) {
    setState(() {
      Settings.codeTheme = theme;
    });
  }

  updateQuerry(String theme) {
    setState(() {
      _querry = theme;
    });
  }
}

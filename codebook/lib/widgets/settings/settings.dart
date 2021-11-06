import 'package:codebook/code_themes.dart';
import 'package:codebook/db/settings.dart';
import 'package:codebook/themes.dart';
import 'package:codebook/widgets/codeblock/tag/tag.dart';
import 'package:codebook/widgets/home/filter/input.dart';
import 'package:codebook/widgets/settings/code_theme.dart';
import 'package:codebook/widgets/settings/theme_item.dart';
import 'package:flutter/material.dart';
import 'package:nekolib.ui/ui.dart';
import 'package:nekolib.ui/ui/themes/theme.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  static const double titleSize = 20;
  static const double searchWidth = 250 + NcSpacing.xlSpacing;
  static const recommendedLabel = "Using Recommended";
  static const useRecommendedLabel = "Use Recommended";
  static const recommendedPadding = EdgeInsets.symmetric(vertical: 2.5, horizontal: 5);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  String _themeSeach = "";
  String _codeThemeSeach = "";

  @override
  Widget build(BuildContext context) {
    var usingRecommended = Settings.codeTheme == CustomThemes.themeCodeThemes[NcThemes.current];
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              NcCaptionText("Themes", fontSize: SettingsPage.titleSize),
              Center(
                child: Container(
                  padding: const EdgeInsets.only(right: NcSpacing.xlSpacing),
                  width: SettingsPage.searchWidth,
                  child: FilterInput(placeholder: "Search", onChanged: updateThemeSearch),
                ),
              )
            ],
          ),
          NcSpacing.small(),
          Wrap(
            spacing: NcSpacing.smallSpacing,
            runSpacing: NcSpacing.smallSpacing,
            children: [
              for (var theme in NcThemes.all.values)
                if (theme.name.toLowerCase().contains(_themeSeach.toLowerCase())) ThemeItem(theme: theme, selected: NcThemes.current == theme, onTap: () => updateTheme(theme)),
            ],
          ),
          NcSpacing.xl(),
          Stack(
            children: [
              Align(
                alignment: Alignment.bottomLeft,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    NcCaptionText("Code Themes", fontSize: SettingsPage.titleSize),
                    NcSpacing.xs(),
                    Tag.add(
                      label: usingRecommended ? SettingsPage.recommendedLabel : SettingsPage.useRecommendedLabel,
                      fontSize: 12,
                      padding: SettingsPage.recommendedPadding,
                      onTap: () => updateCodeTheme(CustomThemes.themeCodeThemes[NcThemes.current]!),
                      icon: usingRecommended ? Icons.check : Icons.warning_amber_rounded,
                      color: usingRecommended ? NcThemes.current.successColor : NcThemes.current.warningColor,
                    ),
                  ],
                ),
              ),
              Center(
                child: Container(
                  padding: const EdgeInsets.only(right: NcSpacing.xlSpacing),
                  width: SettingsPage.searchWidth,
                  child: FilterInput(placeholder: "Search", onChanged: updateCodeThemeSearch),
                ),
              )
            ],
          ),
          NcSpacing.small(),
          Wrap(
            spacing: NcSpacing.smallSpacing,
            runSpacing: NcSpacing.smallSpacing,
            children: [
              for (var theme in kCodeThemes.keys)
                if (theme.toLowerCase().contains(_codeThemeSeach.toLowerCase())) CodeTheme(theme: theme, recomended: CustomThemes.themeCodeThemes[NcThemes.current] == theme, selected: Settings.codeTheme == theme, onTap: () => updateCodeTheme(theme)),
            ],
          ),
          NcSpacing.xl(),
        ],
      ),
    );

    // return NcBodyText("Settings");
  }

  updateCodeThemeSearch(String theme) {
    setState(() {
      _codeThemeSeach = theme;
    });
  }

  updateThemeSearch(String theme) {
    setState(() {
      _themeSeach = theme;
    });
  }

  updateCodeTheme(String theme) {
    setState(() {
      Settings.codeTheme = theme;
    });
  }

  updateTheme(NcTheme theme) {
    setState(() {
      NcThemes.current = theme;
    });
  }
}

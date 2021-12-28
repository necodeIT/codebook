// ignore_for_file: prefer_const_constructors_in_immutables
import 'package:codebook/widgets/settings/sections/code_themes_settings/code_theme_settings.dart';
import 'package:codebook/widgets/settings/sections/sync_settings/sync_settings.dart';
import 'package:codebook/widgets/settings/sections/theme_settings/theme_settings.dart';
import 'package:flutter/material.dart';
import 'package:nekolib.ui/ui.dart';

class SettingsPage extends StatefulWidget {
  SettingsPage({Key? key}) : super(key: key);

  static const double titleSize = 20;
  static const double searchWidth = 250 + NcSpacing.xlSpacing;
  static const double recommendedFontSize = 12;
  static const recommendedLabel = "Using Recommended";
  static const useRecommendedLabel = "Use Recommended";
  static const recommendedPadding = EdgeInsets.symmetric(vertical: 2.5, horizontal: 5);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          NcCaptionText("Sync", fontSize: SettingsPage.titleSize),
          NcSpacing.small(),
          SyncSettings(),
          NcSpacing.small(),
          const ThemeSettings(),
          NcSpacing.xl(),
          CodeThemeSettings(),
          NcSpacing.xl(),
        ],
      ),
    );

    // return NcBodyText("Settings");
  }
}

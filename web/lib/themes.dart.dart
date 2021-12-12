import 'package:flutter/material.dart';
import 'package:nekolib.ui/ui.dart';
import 'package:nekolib.ui/ui/themes/theme.dart';

class CustomThemes {
  static final darkPurple = NcThemes.dark.copyWith(
    "Dark Purple",
    icon: Icons.nightlight_outlined,
    iconColor: const Color(0xFF8E45F6),
    accentColor: const Color(0xFF8E45F6),
  );

  static final lightPurple = NcThemes.light.copyWith(
    "Light Purple",
    icon: NcThemes.light.icon,
    iconColor: const Color(0xFF6200EE),
    accentColor: const Color(0xFF6200EE),
  );

  static final darkGreen = NcThemes.dark.copyWith(
    "Dark Green",
    icon: Icons.nightlight_outlined,
    iconColor: const Color(0xFF0C8004),
    // iconColor: const Color(0xFF1AA410),
    accentColor: const Color(0xFF0C8004),
  );

  static final lightGreen = NcThemes.light.copyWith(
    "Light Green",
    icon: NcThemes.light.icon,
    iconColor: const Color(0xFF18CC0A),
    accentColor: const Color(0xFF18CC0A),
  );

  static final recommendedCodeThemes = Map<NcTheme, String>.unmodifiable({
    lightPurple: "Routeros",
    lightGreen: "Qtcreator Light",
    darkPurple: "Atelier Cave Dark",
    darkGreen: "Obsidian",
    NcThemes.dark: "Dracula",
    NcThemes.ocean: "Ocean",
    NcThemes.light: "Brown Paper",
    NcThemes.sakura: "Kimbie Light"
    // NcThemes.
  });

  static void registerAll() {
    NcThemes.registerExternalTheme(darkPurple);
    NcThemes.registerExternalTheme(lightPurple);
    NcThemes.registerExternalTheme(lightGreen);
    NcThemes.registerExternalTheme(darkGreen);
  }
}

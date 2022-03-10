import 'package:flutter/material.dart';
import 'package:nekolib_ui/core.dart';

class CustomThemes {
  static final darkPurple = darkTheme.copyWith(
    "Dark Purple",
    icon: Icons.nightlight_outlined,
    iconColor: const Color(0xFF8E45F6),
    accentColor: const Color(0xFF8E45F6),
  );

  static final lightPurple = lightTheme.copyWith(
    "Light Purple",
    icon: lightTheme.icon,
    iconColor: const Color(0xFF6200EE),
    accentColor: const Color(0xFF6200EE),
  );

  static final darkGreen = darkTheme.copyWith(
    "Dark Green",
    icon: Icons.nightlight_outlined,
    iconColor: const Color(0xFF0C8004),
    // iconColor: const Color(0xFF1AA410),
    accentColor: const Color(0xFF0C8004),
  );

  static final lightGreen = lightTheme.copyWith(
    "Light Green",
    icon: lightTheme.icon,
    iconColor: const Color(0xFF18CC0A),
    accentColor: const Color(0xFF18CC0A),
  );

  static final recommendedCodeThemes = Map<NcTheme, String>.unmodifiable({
    lightPurple: "Routeros",
    lightGreen: "Qtcreator Light",
    darkPurple: "Atelier Cave Dark",
    darkGreen: "Obsidian",
    darkTheme: "Dracula",
    oceanTheme: "Ocean",
    lightTheme: "Brown Paper",
    sakuraTheme: "Kimbie Light"
    // NcThemes.
  });

  static void init() {
    lightGreen;
    lightPurple;
    darkGreen;
    darkPurple;
  }
}

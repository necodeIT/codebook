import 'package:flutter/material.dart';
import 'package:nekolib.ui/ui.dart';

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

  static void registerAll() {
    NcThemes.registerTheme(darkPurple);
    NcThemes.registerTheme(lightPurple);
    NcThemes.registerTheme(lightGreen);
    NcThemes.registerTheme(darkGreen);
  }
}

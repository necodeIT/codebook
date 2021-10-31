import 'package:flutter/material.dart';
import 'package:nekolib.ui/ui.dart';

class CustomThemes {
  static final darkPurple = NcThemes.dark.copyWith(
    "Dark Purple",
    icon: NcThemes.dark.icon,
    iconColor: const Color(0xFF8E45F6),
    accentColor: const Color(0xFF8E45F6),
  );

  static final lightPurple = NcThemes.light.copyWith(
    "Dark Purple",
    icon: NcThemes.light.icon,
    iconColor: const Color(0xFF6200EE),
    accentColor: const Color(0xFF6200EE),
  );

  static void registerAll() {
    NcThemes.registerExternalTheme(darkPurple);
    NcThemes.registerExternalTheme(lightPurple);
  }
}

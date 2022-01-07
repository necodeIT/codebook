// ignore_for_file: prefer_const_constructors_in_immutables

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:platform_detect/platform_detect.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:web/widgets/themed_button.dart';

class DownloadButton extends StatelessWidget {
  DownloadButton({Key? key}) : super(key: key);

  static const label = "Download";

  static const List<TargetPlatform> supportedPlatforms = [
    TargetPlatform.windows,
  ];

  static const baseUrl = "https://github.com/necodeIT/codebook/releases/latest/download";

  static const Map<TargetPlatform, String> downloadLinks = {TargetPlatform.windows: "$baseUrl/WindowsSetup.exe"};

  static const Map<TargetPlatform, IconData> platformIcons = {
    TargetPlatform.windows: FontAwesome.windows,
    TargetPlatform.macOS: FontAwesome.apple,
    TargetPlatform.linux: FontAwesome.linux,
  };

  static bool get platformSupported => supportedPlatforms.contains(defaultTargetPlatform);
  static String get platformDownloadLink => downloadLinks[defaultTargetPlatform] ?? "";
  static IconData get platformIcon => platformIcons[defaultTargetPlatform] ?? Icons.error;

  static download() => launch(platformDownloadLink);

  @override
  Widget build(BuildContext context) {
    return ThemedButton(
      label: label,
      icon: platformIcon,
      onPressed: platformSupported ? download : null,
      disabledMessage: "${operatingSystem.name} is not supported yet.",
    );
  }
}

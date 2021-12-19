// ignore_for_file: prefer_const_constructors_in_immutables

import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:platform_detect/platform_detect.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:web/widgets/themed_button.dart';

class DownloadButton extends StatelessWidget {
  DownloadButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ThemedButton(
      label: "Download",
      icon: operatingSystem.isWindows
          ? FontAwesome.windows
          : operatingSystem.isMac
              ? FontAwesome.apple
              : FontAwesome.linux,
      onPressed: operatingSystem.isWindows ? () => launch("https://github.com/necodeIT/code-book/releases/latest/download/WindowsSetup.exe") : null,
      disabledMessage: "${operatingSystem.name} is not supported yet.",
    );
  }
}

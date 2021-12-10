import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:nekolib.ui/ui.dart';
import 'package:platform_detect/platform_detect.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:web/widgets/home/desktop.dart';
import 'package:web/widgets/home/home.dart';
import 'package:web/widgets/preview/preview.dart';
import 'package:web/widgets/themed_button.dart';

class HomeTabletLayout extends StatelessWidget {
  const HomeTabletLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(NcSpacing.xlSpacing),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            NcSpacing.xl(),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                NcTitleText(
                  "Easily manage your code snippets.",
                  fontSize: HomeDesktopLayout.titleSize,
                ),
                NcSpacing.medium(),
                NcCaptionText("CodeBook is an easy way to manage your code snippets.", fontSize: HomeDesktopLayout.captionSize),
                NcSpacing.medium(),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ThemedButton(
                      label: "Download",
                      icon: operatingSystem.isWindows
                          ? FontAwesome.windows
                          : operatingSystem.isMac
                              ? FontAwesome.apple
                              : FontAwesome.linux,
                      onPressed: operatingSystem.isWindows
                          ? () {
                              // TODO: Match download to operating system
                              launch("https://github.com/necodeIT/code-book/releases/latest/download/WindowsSetup.exe");

                              // download file based on operating system
                            }
                          : null,
                      disabledMessage: "${operatingSystem.name} is not supported yet.",
                    ),
                    NcSpacing.medium(),
                    ThemedButton(
                      label: "GitHub",
                      onPressed: () => launch(Home.repo),
                      outlined: true,
                      icon: Feather.github,
                    ),
                  ],
                ),
              ],
            ),
            NcSpacing.xl(),
            NcSpacing.xl(),
            Preview(),
            NcSpacing.xl(),
          ],
        ),
      ),
    );
  }
}

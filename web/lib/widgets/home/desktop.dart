import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:nekolib.ui/ui.dart';
import 'package:platform_detect/platform_detect.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:web/widgets/background_path.dart';
import 'package:web/widgets/home/home.dart';
import 'package:web/widgets/preview/preview.dart';
import 'package:web/widgets/theme_selector.dart';
import 'package:web/widgets/themed_button.dart';

class HomeDesktopLayout extends StatelessWidget {
  const HomeDesktopLayout({Key? key}) : super(key: key);

  static const double titleSize = 60;
  static const double captionSize = 20;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CustomPaint(
          painter: BackgroundPainter(),
          child: const SizedBox.expand(),
        ),
        // NcVectorImage(code: backgroundSvg),
        Positioned(
          top: ThemeSelector.margin,
          right: 0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              for (var theme in NcThemes.all.values) ThemeSelector(theme: theme),
            ],
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            NcSpacing.xl(),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                NcTitleText(
                  "Easily\nmanage your\ncode snippets.",
                  fontSize: HomeDesktopLayout.titleSize,
                ),
                NcSpacing.medium(),
                NcCaptionText("CodeBook is an easy way to manage\nyour code snippets.", fontSize: HomeDesktopLayout.captionSize),
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
                          ? () => launch("https://github.com/necodeIT/code-book/releases/latest/download/WindowsSetup.exe")

                          // download file based on operating system

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
      ],
    );
  }
}

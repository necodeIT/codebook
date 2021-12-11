import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:nekolib.ui/ui.dart';
import 'package:platform_detect/platform_detect.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:web/widgets/adaptive_layout_property.dart';
import 'package:web/widgets/home/desktop.dart';
import 'package:web/widgets/home/home.dart';
import 'package:web/widgets/preview/preview.dart';
import 'package:web/widgets/themed_button.dart';

class HomeTabletLayout extends StatelessWidget {
  HomeTabletLayout({Key? key}) : super(key: key);

  final previewSizes = AdaptiveLayoutProperty(breakPoints: {
    double.infinity: const Size(950, 520),
    1150: const Size(770, 450),
    953: const Size(700, 380),
    890: const Size(620, 350),
    800: const Size(520, 350),
    700: const Size(400, 300),
    615: const Size(350, 250),
  });

  final previewState = AdaptiveLayoutProperty(breakPoints: {
    double.infinity: true,
    980: false,
  });

  @override
  Widget build(BuildContext context) {
    var previewSize = previewSizes.value(context);

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
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                NcTitleText(
                  "Easily manage your code snippets.",
                  fontSize: HomeDesktopLayout.titleSize,
                  textAlign: TextAlign.center,
                ),
                NcSpacing.medium(),
                NcCaptionText(
                  "CodeBook is an easy way to manage your code snippets.",
                  fontSize: HomeDesktopLayout.captionSize,
                  textAlign: TextAlign.center,
                ),
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
                      onPressed: operatingSystem.isWindows ? () => launch("https://github.com/necodeIT/code-book/releases/latest/download/WindowsSetup.exe") : null,
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
            NcSpacing.xl(),
            NcSpacing.xl(),
            Preview(
              stack: previewState.value(context),
              width: previewSize.width,
              height: previewSize.height,
            ),
            NcSpacing.xl(),
          ],
        ),
      ),
    );
  }
}

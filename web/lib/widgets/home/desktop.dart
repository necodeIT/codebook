import 'package:flutter/material.dart';
import 'package:nekolib.ui/ui.dart';
import 'package:web/widgets/background_path.dart';
import 'package:web/widgets/home/download_button.dart';
import 'package:web/widgets/home/guthub_button.dart';
import 'package:web/widgets/home/theme_previews.dart';
import 'package:web/widgets/preview/preview.dart';
import 'package:web/widgets/theme_selector.dart';

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
        Positioned(top: ThemeSelector.margin, right: 0, child: ThemePreviews()),
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
                    DownloadButton(),
                    NcSpacing.medium(),
                    GitHubButton(),
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

import 'package:flutter/material.dart';
import 'package:nekolib.ui/ui.dart';
import 'package:web/widgets/adaptive_layout_property.dart';
import 'package:web/widgets/home/layouts/desktop.dart';
import 'package:web/widgets/home/buttons/download_button.dart';
import 'package:web/widgets/home/buttons/guthub_button.dart';
import 'package:web/widgets/home/theme_previews.dart';
import 'package:web/widgets/preview/preview.dart';

class HomeTabletLayout extends StatelessWidget {
  HomeTabletLayout({Key? key}) : super(key: key);

  final previewScales = AdaptiveLayoutProperty<double>(breakPoints: {
    double.infinity: 1,
    1150: .9,
    1131: .8,
    953: .6,
    890: .5,
  });

  final previewState = AdaptiveLayoutProperty(breakPoints: {
    double.infinity: true,
    980: false,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.all(NcSpacing.xlSpacing),
        width: double.infinity,
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
                    DownloadButton(),
                    NcSpacing.medium(),
                    GitHubButton(),
                  ],
                ),
              ],
            ),
            NcSpacing.xl(),
            NcSpacing.xl(),
            NcSpacing.xl(),
            ThemePreviews(
              mainAxisAlignment: MainAxisAlignment.center,
            ),
            NcSpacing.large(),
            Preview(
              stack: previewState.value(context),
              scale: previewScales.value(context),
            ),
            NcSpacing.xl(),
          ],
        ),
      ),
    );
  }
}

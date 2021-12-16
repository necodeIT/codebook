// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:nekolib.ui/ui.dart';
import 'package:web/widgets/adaptive_layout_property.dart';
import 'package:web/widgets/home/guthub_button.dart';
import 'package:web/widgets/home/theme_previews.dart';
import 'package:web/widgets/preview/preview.dart';

class HomeMobileLayout extends StatelessWidget {
  HomeMobileLayout({Key? key}) : super(key: key);

  static const double titleSize = 40;
  static const double captionSize = 25;

  final previewSizes = AdaptiveLayoutProperty(breakPoints: {
    double.infinity: const Size(500, 300),
  });

  @override
  Widget build(BuildContext context) {
    var previewSize = previewSizes.value(context);

    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.all(NcSpacing.xlSpacing),
        width: double.infinity,
        child: Column(
          children: [
            NcTitleText(
              "Easily manage your code snippets.",
              fontSize: HomeMobileLayout.titleSize,
              textAlign: TextAlign.center,
            ),
            NcSpacing.xl(),
            NcCaptionText(
              "CodeBook is an easy way to manage your code snippets.",
              fontSize: HomeMobileLayout.captionSize,
              textAlign: TextAlign.center,
            ),
            NcSpacing.xl(),
            ThemePreviews(
              mainAxisAlignment: MainAxisAlignment.center,
            ),
            NcSpacing.xl(),
            Preview(
              stack: false,
              width: previewSize.width,
              height: previewSize.height,
            ),
            NcSpacing.xl(),
            GitHubButton(),
          ],
        ),
      ),
    );
  }
}

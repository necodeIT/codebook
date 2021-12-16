// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:nekolib.ui/ui.dart';
import 'package:web/svg/logo.dart';
import 'package:web/widgets/adaptive_layout_property.dart';
import 'package:web/widgets/home/guthub_button.dart';
import 'package:web/widgets/home/theme_previews.dart';
import 'package:web/widgets/preview/preview.dart';

class HomeMobileLayout extends StatelessWidget {
  HomeMobileLayout({Key? key}) : super(key: key);

  static const double titleSize = 40;
  static const double captionSize = 20;
  static const double sliverHeight = 50;

  final previewSizes = AdaptiveLayoutProperty(breakPoints: {
    double.infinity: const Size(500, 300),
  });

  final iconSizes = AdaptiveLayoutProperty(breakPoints: <double, double>{
    double.infinity: 150,
  });

  @override
  Widget build(BuildContext context) {
    var previewSize = previewSizes.value(context);
    var iconSize = iconSizes.value(context);

    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.all(NcSpacing.xlSpacing),
        width: double.infinity,
        child: Column(
          children: [
            NcVectorImage(
              code: logoSVG,
              width: iconSize,
              height: iconSize,
            ),
            Text(
              "Easily manage your code snippets.",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: titleSize,
                color: NcThemes.current.accentColor,
                fontWeight: FontWeight.bold,
              ),
            ),
            NcSpacing.xl(),
            NcCaptionText(
              "CodeBook is an easy way to manage your code snippets.",
              fontSize: HomeMobileLayout.captionSize,
              textAlign: TextAlign.center,
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

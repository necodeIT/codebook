import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:nekolib.ui/ui.dart';
import 'package:platform_detect/platform_detect.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:web/widgets/preview/preview.dart';
import 'package:web/widgets/themed_button.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  static const double titleSize = 60;
  static const double captionSize = 20;
  static const repo = "https://github.com/necodeIT/code-book";

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    super.initState();
    NcThemes.onCurrentThemeChange = () => setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: NcThemes.current.secondaryColor,
      body: Stack(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  NcTitleText(
                    "Easily\nmanage your\ncode snippets.",
                    fontSize: Home.titleSize,
                  ),
                  NcSpacing.medium(),
                  NcCaptionText("CodeBook is an easy way to manage\nyour code snippets.", fontSize: Home.captionSize),
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
              // NcSpacing.xl(),
              // NcSpacing.xl(),
              // Preview(),
              // NcSpacing.xl(),
            ],
          ),
        ],
      ),
    );
  }
}

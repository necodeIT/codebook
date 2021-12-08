import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:nekolib.ui/ui.dart';
import 'package:platform_detect/platform_detect.dart';
import 'package:url_launcher/url_launcher.dart';

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
                      NcButton(
                        text: "Download",
                        leadingIcon: Icon(
                          operatingSystem.isWindows
                              ? FontAwesome.windows
                              : operatingSystem.isMac
                                  ? FontAwesome.apple
                                  : FontAwesome.linux,
                          color: NcThemes.current.buttonTextColor,
                        ),
                        onTap: () {
                          // launch "https://github.com/necodeIT/code-book/releases/latest/download/$setupFile" but adapt on operatingSystem
                          // so that it works on all platforms
                          // if operatingSystem.isWindows download setupFile is WindowsSetup.exe
                          // if operatingSystem.isMac download setupFile is CodeBook.dmg
                          // if operatingSystem.isLinux download setupFile is CodeBook.AppImage
                          var setupFile = "CodeBook.AppImage";
                          if (operatingSystem.isWindows) {
                            setupFile = "WindowsSetup.exe";
                          } else if (operatingSystem.isMac) {
                            setupFile = "CodeBook.dmg";
                          }

                          launch("https://github.com/necodeIT/code-book/releases/latest/download/$setupFile");
                        },
                      ),
                      NcSpacing.medium(),
                      NcButton(text: "GitHub", onTap: () => launch(Home.repo)),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:nekolib.ui/ui.dart';
import 'package:platform_detect/platform_detect.dart';
import 'package:web/themes.dart.dart';
import 'package:web/widgets/home/buttons/download_button.dart';
import 'package:web/widgets/home/buttons/guthub_button.dart';
import 'package:web/widgets/home/layouts/mobile/themed_list_tile.dart';
import 'package:web/widgets/home/theme_previews.dart';
import 'package:web/widgets/themed_divider.dart';

class MobileDrawer extends StatelessWidget {
  const MobileDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: NcThemes.current.primaryColor,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: ListView(
          controller: ScrollController(),
          children: [
            SizedBox(
              height: 60,
              child: DrawerHeader(
                child: NcTitleText(
                  "CodeBook",
                  fontSize: 20,
                ),
              ),
            ),
            ThemedDivider(),
            if (DownloadButton.platformSupported)
              ThemedListTile(
                leading: Icons.file_download_outlined,
                title: DownloadButton.label,
                subtitle: "Get CodeBook for ${operatingSystem.name}",
                onTap: DownloadButton.download,
              ),
            ThemedListTile(
              leading: GitHubButton.icon,
              title: GitHubButton.text,
              subtitle: "Open the GiHub repository",
              onTap: GitHubButton.openRepo,
            ),
            if (DownloadButton.platformSupported) ThemedDivider(),
            for (var theme in ThemePreviews.themes)
              ThemedListTile(
                leading: theme.icon,
                title: theme.name,
                onTap: () => NcThemes.current = theme,
                subtitle: "Theme",
                color: NcThemes.current == theme ? theme.accentColor : null,
              ),
          ],
        ),
      ),
    );
  }
}

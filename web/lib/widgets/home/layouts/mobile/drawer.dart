import 'package:flutter/material.dart';
import 'package:nekolib.ui/ui.dart';
import 'package:web/themes.dart.dart';
import 'package:web/widgets/home/buttons/guthub_button.dart';
import 'package:web/widgets/home/layouts/mobile/themed_list_tile.dart';

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
              height: 80,
              child: DrawerHeader(
                child: NcTitleText(
                  "CodeBook",
                  fontSize: 20,
                ),
              ),
            ),
            ThemedListTile(
              leading: GitHubButton.icon,
              title: GitHubButton.text,
              subtitle: "Open the GiHub Repository",
              onTap: GitHubButton.openRepo,
            ),
            const Divider(),
            ThemedListTile(leading: NcThemes.light.icon, title: NcThemes.light.name, onTap: () => NcThemes.current = NcThemes.light, subtitle: "Theme"),
            ThemedListTile(leading: NcThemes.sakura.icon, title: NcThemes.sakura.name, onTap: () => NcThemes.current = NcThemes.sakura, subtitle: "Theme"),
            ThemedListTile(leading: CustomThemes.darkPurple.icon, title: CustomThemes.darkPurple.name, onTap: () => NcThemes.current = CustomThemes.darkPurple, subtitle: "Theme"),
            ThemedListTile(leading: NcThemes.ocean.icon, title: NcThemes.ocean.name, onTap: () => NcThemes.current = NcThemes.ocean, subtitle: "Theme"),
          ],
        ),
      ),
    );
  }
}

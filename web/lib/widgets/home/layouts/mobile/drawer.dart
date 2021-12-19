import 'package:flutter/material.dart';
import 'package:nekolib.ui/ui.dart';
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
          ],
        ),
      ),
    );
  }
}

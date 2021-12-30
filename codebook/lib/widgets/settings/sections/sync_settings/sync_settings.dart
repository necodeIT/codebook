// ignore_for_file: prefer_const_constructors_in_immutables

import 'package:codebook/db/settings.dart';
import 'package:codebook/db/sync/sync.dart';
import 'package:codebook/widgets/button.dart';
import 'package:codebook/widgets/settings/settings_title.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:nekolib.ui/ui.dart';

class SyncSettings extends StatefulWidget {
  SyncSettings({Key? key}) : super(key: key);

  @override
  State<SyncSettings> createState() => _SyncSettingsState();
}

class _SyncSettingsState extends State<SyncSettings> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SettingsTitle(
          title: "Sync",
          trailingSpacing: 0,
        ),
        NcSpacing.small(),
        Row(
          children: [
            NcBodyText(
              "Enable sync",
              fontSize: 18,
            ),
            Switch(
              value: Settings.sync,
              activeColor: NcThemes.current.accentColor,
              inactiveThumbColor: NcThemes.current.primaryColor,
              inactiveTrackColor: NcThemes.current.tertiaryColor.withOpacity(.5),
              onChanged: (value) {
                setState(() {
                  Settings.sync = value;
                });
              },
            ),
          ],
        ),
        NcSpacing.small(),
        Row(
          children: [
            NcBodyText(
              "Account",
              fontSize: 18,
            ),
            NcSpacing.xs(),
            if(Sync.authorized) NcBodyText("(${Sync.username})", fontSize: 15),
          ],
        ),
        NcSpacing.xs(),
        ThemedElevatedButton.icon(
          onPressed: () => Sync.login(context).then((value) => setState(() {})),
          text: Sync.authorized ? "Change" : "Login",
          icon: Feather.github,
        ),
      ],
    );
  }
}

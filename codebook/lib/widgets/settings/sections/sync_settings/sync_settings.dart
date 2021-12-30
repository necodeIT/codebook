// ignore_for_file: prefer_const_constructors_in_immutables

import 'package:codebook/db/settings.dart';
import 'package:codebook/db/sync/sync.dart';
import 'package:codebook/widgets/button.dart';
import 'package:codebook/widgets/settings/sections/sync_settings/count_down.dart';
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
        StreamBuilder<bool>(
          stream: Sync.locked,
          builder: (context, snapshot) => snapshot.data ?? false
              ? Row(
                  children: [
                    NcBodyText(
                      "Sync is temporarily disabled due to API issues.",
                      fontSize: 15,
                    ),
                    CountDown(fontSize: 15)
                  ],
                )
              : const SizedBox.shrink(),
        ),
        if (Sync.isLocked) NcSpacing.small(),
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
            if (Sync.authorized) NcBodyText("(${Sync.username})", fontSize: 15),
          ],
        ),
        NcSpacing.xs(),
        ThemedElevatedButton.icon(
          onPressed: () => Sync.login(context).then((value) => setState(() {})),
          text: Sync.authorized ? "Change" : "Login",
          icon: Feather.github,
        ),
        if (Sync.authorized) NcSpacing.small(),
        if (Sync.authorized)
          ThemedElevatedButton.icon(
            onPressed: Sync.sync,
            text: "Force sync",
            icon: Icons.update,
          ),
      ],
    );
  }

  String _printDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return "${twoDigits(duration.inHours)}:$twoDigitMinutes:$twoDigitSeconds";
  }
}

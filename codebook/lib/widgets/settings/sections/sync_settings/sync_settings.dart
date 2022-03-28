// ignore_for_file: prefer_const_constructors_in_immutables

import 'package:codebook/db/settings.dart';
import 'package:codebook/db/sync/sync.dart';
import 'package:codebook/utils.dart';
import 'package:codebook/widgets/settings/sections/sync_settings/count_down.dart';
import 'package:codebook/widgets/settings/sections/sync_settings/device_card.dart';
import 'package:codebook/widgets/settings/settings_title.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:nekolib_ui/core.dart';

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
          trailing: Transform.scale(
            alignment: Alignment.centerLeft,
            origin: const Offset(0, 5), // Don't ask why but this alings the swtich vertically with the label
            transformHitTests: true,
            scale: 0.8,
            child: Switch(
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
          ),
        ),
        NcSpacing.small(),
        Wrap(
          spacing: NcSpacing.smallSpacing,
          runSpacing: NcSpacing.smallSpacing,
          children: [
            DeviceCard(
              icon: Feather.github,
              label: Sync.authorized ? Sync.username : "Login",
              onTap: () => Sync.login(context).then((value) => setState(() {})),
              // outlined: Sync.authorized,
              tooltip: Sync.authorized ? "Change account" : null,
            ),
            if (Settings.sync && Sync.authorized)
              StreamBuilder<bool>(
                stream: Sync.locked,
                builder: (context, snapshot) => snapshot.data ?? false
                    ? CountDown()
                    : DeviceCard(
                        icon: Feather.refresh_ccw,
                        label: "Sync",
                        onTap: Sync.sync,
                        tooltip: "Force sync",
                      ),
              ),
            DeviceCard(
              icon: FontAwesome.file_text_o,
              label: "Clear logs",
              onTap: clearLogs,
              tooltip: "Clear all log files except the current seession",
            ),
          ],
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

// ignore_for_file: prefer_const_constructors_in_immutables

import 'package:codebook/db/sync/sync.dart';
import 'package:codebook/widgets/button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';

class SyncSettings extends StatefulWidget {
  SyncSettings({Key? key}) : super(key: key);

  @override
  State<SyncSettings> createState() => _SyncSettingsState();
}

class _SyncSettingsState extends State<SyncSettings> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        ThemedElevatedButton.icon(
          onPressed: () => Sync.login(context).then((value) => setState(() {})),
          text: "Login",
          icon: Feather.github,
        ),
      ],
    );
  }
}

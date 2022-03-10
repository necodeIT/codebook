import 'dart:io';

import 'package:codebook/updater/updater.dart';
import 'package:codebook/widgets/home/in_out_dialog/in_out_dialog.dart';
import 'package:flutter/material.dart';
import 'package:nekolib_ui/core.dart';
import 'package:url_launcher/url_launcher.dart';

class UpdatePrompt extends StatefulWidget {
  const UpdatePrompt({Key? key}) : super(key: key);

  static const downloadErrorCode = '''
  2e56924f28d0e85c03216e3ac1498642ecaf154cd36e7e21a47b217c5ffe1d58
  9c7333de503f5734cb4495e3643535e6c4846703d3acb7e414304eeffaed5999
  7b5d4225c9b80900802127e29769775249c9bf15b9c7e10446e7ed285e44467e
  20bc7b827193d832a656b64d5a3c3594661307eb6d744ab8400213da5877e961
  f6dd9b5280fdc44ad8ae8c439ec19f8e97ca15fe28f473ac6b7d840a5395dfb2
  62d9de54f5c812041e195234cc404b71df713dc5ae40d392750a4b4bd98ef2aa
  205eba23d7887f602ea1a83d27fde5684a28b01268cec7f28deadb28b2ced281
  eb381bb8889f7759f7e3963e90ce92a4b24133974b7c4d7c2a4ca28fb9e64b1c
  b3621fdffd6876e7a5640fdecd26fe8c9404fc6ceeebc36b7f4d53d8a8e12f6f
  288fe412ad2043125dc981e9f5746637887bdb03bf91ff216cc815024e774912
  ''';

  @override
  State<UpdatePrompt> createState() => _UpdatePromptState();
}

class _UpdatePromptState extends State<UpdatePrompt> {
  bool _downloading = false;
  bool _downloadError = false;
  int _progress = 0;

  @override
  Widget build(BuildContext context) {
    // column with text "New version available" and button with text "Update to $Updater.latestReleaseName"
    return Scaffold(
        backgroundColor: NcThemes.current.primaryColor,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              if (_downloadError)
                Center(
                  child: Icon(
                    Icons.error_outline_outlined,
                    color: NcThemes.current.errorColor,
                    size: InOutDialog.iconSize,
                  ),
                ),
              NcSpacing.large(),
              if (_downloadError)
                GestureDetector(
                  onTap: () => launch(Updater.setupDownloadUrl),
                  child: Row(children: [
                    NcCaptionText(
                      "An error occured while automatically updating. Please try updating manually.",
                      fontSize: 20,
                    ),
                    NcSpacing.small(),
                    Icon(
                      Icons.arrow_forward_outlined,
                      color: NcThemes.current.textColor,
                    ),
                  ]),
                ),
              if (!_downloading && !_downloadError)
                NcCaptionText(
                  'New update available!',
                  fontSize: 30,
                ),
              if (_downloading && !_downloadError)
                NcBodyText(
                  _progress != 100 ? "Downloading ${Updater.latestVersionName} ($_progress%)" : "Launching installer...",
                  fontSize: 20,
                ),
              NcSpacing.medium(),
              if (!_downloading && !_downloadError)
                ElevatedButton(
                  style: ButtonStyle(backgroundColor: MaterialStateProperty.all(accentColor)),
                  child: NcTitleText(
                    'Update to ${Updater.latestVersionName}',
                    buttonText: true,
                    fontSize: 15,
                  ),
                  onPressed: () {
                    setState(() {
                      _downloading = true;
                    });

                    Updater.upgrade(
                      (current, total) => setState(
                        () {
                          _progress = (current / total * 100).floor();
                        },
                      ),
                    ).onError((error, stackTrace) {
                      setState(() {
                        _downloadError = true;
                      });
                      return UpdatePrompt.downloadErrorCode; // Error code so that app doesn't quit when Future.then is called
                    }).then((value) async {
                      if (value == UpdatePrompt.downloadErrorCode) return;

                      await Process.start(value, []);
                      exit(0);
                    });
                  },
                ),
              if (_downloading && !_downloadError)
                SizedBox(
                  width: 600,
                  child: LinearProgressIndicator(
                    color: NcThemes.current.accentColor,
                    backgroundColor: NcThemes.current.tertiaryColor,
                  ),
                ),
            ],
          ),
        ));
  }
}

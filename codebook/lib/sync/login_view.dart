import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:nekolib.ui/ui.dart';

class GitHubLoginPrompt extends StatefulWidget {
  const GitHubLoginPrompt({Key? key, required this.onSuccess, required this.onCancel, required this.sucesssFile}) : super(key: key);

  final Function(String) onSuccess;
  final Function() onCancel;
  final File sucesssFile;

  @override
  State<GitHubLoginPrompt> createState() => _GitHubLoginPromptState();
}

class _GitHubLoginPromptState extends State<GitHubLoginPrompt> {
  bool _cancel = false;

  awaitAuth() async {
    while (!widget.sucesssFile.existsSync()) {
      if (_cancel) break;
      await Future.delayed(const Duration(milliseconds: 100));
    }

    if (_cancel) return;
    await Future.delayed(const Duration(milliseconds: 500));
    var content = await widget.sucesssFile.readAsString();
    widget.onSuccess(content);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: NcThemes.current.secondaryColor,
      body: FutureBuilder(
        future: awaitAuth(),
        builder: (context, state) {
          return state.connectionState == ConnectionState.done
              ? Center(
                  child: NcBodyText(_cancel ? "Cancelled" : "Done"),
                )
              : Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      NcCaptionText(
                        "Authorizing GitHub",
                        fontSize: 20,
                      ),
                      NcSpacing.medium(),
                      CircularProgressIndicator(
                        color: NcThemes.current.accentColor,
                      ),
                      NcSpacing.medium(),
                      ElevatedButton(
                        onPressed: () {
                          setState(() {
                            _cancel = true;
                          });
                          widget.onCancel();
                        },
                        child: NcCaptionText(
                          "Cancel",
                          fontSize: 15,
                        ),
                        style: ButtonStyle(backgroundColor: MaterialStateProperty.all(NcThemes.current.accentColor)),
                      ),
                    ],
                  ),
                );
        },
      ),
    );
  }
}

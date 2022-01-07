import 'package:flutter/material.dart';
import 'package:nekolib.ui/ui.dart';
import 'package:timeline_tile/timeline_tile.dart';
import 'package:web/widgets/auth/themed_timeline_tile.dart';

class Auth extends StatelessWidget {
  const Auth({Key? key}) : super(key: key);

  static const route = "/auth";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: NcThemes.current.primaryColor,
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ThemedTimelineTile(
              isDone: false,
              alignment: TimelineAlign.center,
              // lineXY: .7,
              isFirst: true,
              startChild: NcTitleText(
                "Authorize CodeBook-Sync",
                textAlign: TextAlign.end,
              ),
              endChild: NcBodyText("Authorize CodeBook-Sync to access your gists."),
            ),
            ThemedTimelineTile(
              isDone: false,
              alignment: TimelineAlign.center,
              // lineXY: lineXY,
              endChild: Container(
                width: 30,
                color: Colors.amberAccent,
              ),
            ),
            ThemedTimelineTile(
              isDone: false,
              alignment: TimelineAlign.center,
              isLast: true,
              endChild: Container(
                constraints: const BoxConstraints(
                  minHeight: 80,
                ),
                color: Colors.lightGreenAccent,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

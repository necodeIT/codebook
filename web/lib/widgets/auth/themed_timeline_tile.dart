import 'package:flutter/material.dart';
import 'package:nekolib.ui/ui.dart';
import 'package:timeline_tile/timeline_tile.dart';

class ThemedTimelineTile extends StatelessWidget {
  const ThemedTimelineTile({Key? key, this.isFirst = false, this.endChild, this.startChild, this.alignment = TimelineAlign.manual, this.isLast = false, required this.isDone}) : super(key: key);

  final bool isFirst;
  final bool isLast;
  final Widget? endChild;
  final Widget? startChild;
  final TimelineAlign alignment;
  final bool isDone;

  static const double lineXY = .5;

  @override
  Widget build(BuildContext context) {
    return TimelineTile(
      alignment: alignment,
      lineXY: lineXY,
      isFirst: isFirst,
      isLast: isLast,
      indicatorStyle: isDone
          ? IndicatorStyle(color: NcThemes.current.accentColor, iconStyle: IconStyle(iconData: Icons.check, color: NcThemes.current.primaryColor))
          : IndicatorStyle(
              indicator: Container(
              width: 10,
              height: 10,
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(60), color: Colors.transparent, border: Border.all(color: NcThemes.current.tertiaryColor)),
            )),
      beforeLineStyle: LineStyle(color: NcThemes.current.accentColor),
      endChild: endChild,
      startChild: startChild,
    );
  }
}

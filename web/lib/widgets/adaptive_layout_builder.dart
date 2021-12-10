import 'package:flutter/material.dart';

class AdaptiveLayoutBuilder extends StatelessWidget {
  const AdaptiveLayoutBuilder({Key? key, required this.desktop, required this.tablet, required this.mobile, this.tabletBreakpoint, this.mobileBreakpoint}) : super(key: key);

  final Widget desktop;
  final Widget tablet;
  final Widget mobile;
  final double? tabletBreakpoint;
  final double? mobileBreakpoint;

  static const defaultTabletBreakpoint = 768.0;
  static const defaultMobileBreakpint = 480.0;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    if (size.width > (tabletBreakpoint ?? defaultTabletBreakpoint)) {
      return desktop;
    } else if (size.width > (mobileBreakpoint ?? defaultMobileBreakpint)) {
      return tablet;
    } else {
      return mobile;
    }
  }
}

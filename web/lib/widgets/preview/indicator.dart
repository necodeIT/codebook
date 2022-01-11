// ignore_for_file: prefer_const_constructors_in_immutables

import 'package:flutter/material.dart';
import 'package:nekolib.ui/ui.dart';
import 'package:web/themes.dart.dart';
import 'package:web/widgets/condtional_wrapper.dart.dart';
import 'package:web/widgets/preview/preview.dart';
import 'dart:async';

class PreviewIndicator extends StatefulWidget {
  const PreviewIndicator({Key? key, required this.index, required this.currentIndex, required this.length, required this.duration, this.onTap}) : super(key: key);

  final int index;
  final int currentIndex;
  final int length;
  final Duration duration;
  final Function()? onTap;

  static const updateInterval = Duration(milliseconds: 5);

  static final ThemeableProperty<Color> indicatorBackgroundColor = ThemeableProperty.only(Colors.transparent, {
    NcThemes.light.name: NcThemes.light.tertiaryColor.withOpacity(.5),
    NcThemes.sakura.name: NcThemes.sakura.tertiaryColor.withOpacity(.5),
    NcThemes.dark.name: NcThemes.dark.tertiaryColor,
    NcThemes.ocean.name: NcThemes.ocean.tertiaryColor,
    CustomThemes.darkPurple.name: CustomThemes.darkPurple.tertiaryColor,
  });

  @override
  _PreviewIndicatorState createState() => _PreviewIndicatorState();
}

class _PreviewIndicatorState extends State<PreviewIndicator> {
  late Timer _timer;
  double _seconds = 0;
  int _duration = 0;
  late bool useTimer;
  @override
  void initState() {
    useTimer = widget.currentIndex + 1 == widget.index || widget.index == 0 && widget.currentIndex == widget.length - 1;
    _duration = widget.duration.inSeconds;
    _seconds = 0;
    _timer = Timer.periodic(PreviewIndicator.updateInterval, increaseProgress);
    super.initState();
  }

  @override
  void dispose() {
    _timer.cancel();
    _seconds = 0;
    super.dispose();
  }

  increaseProgress(Timer _) {
    if (!useTimer) return;
    setState(() {
      _seconds += PreviewIndicator.updateInterval.inMilliseconds / 1000;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ConditionalWrapper(
      condition: widget.currentIndex != widget.index,
      builder: (context, child) => MouseRegion(
        cursor: SystemMouseCursors.click,
        child: GestureDetector(
          onTap: widget.onTap,
          child: child,
        ),
      ),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: NcSpacing.smallSpacing),
        height: Preview.indicatorSize,
        width: Preview.indicatorSize,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(Preview.indicatorRadius),
          color: widget.index == widget.currentIndex ? NcThemes.current.primaryColor : PreviewIndicator.indicatorBackgroundColor.value,
          border: widget.index == widget.currentIndex ? Border.all(color: NcThemes.current.accentColor) : null,
        ),
        child: useTimer
            ? CircularProgressIndicator(
                color: NcThemes.current.accentColor,
                backgroundColor: PreviewIndicator.indicatorBackgroundColor.value,
                strokeWidth: 1,
                value: _seconds / _duration,
              )
            : null,
      ),
    );
  }
}

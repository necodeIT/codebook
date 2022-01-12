import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:nekolib.ui/ui.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:web/widgets/condtional_wrapper.dart.dart';
import 'package:web/widgets/preview/filter/filter.dart';
import 'package:web/widgets/preview/home/home.dart';
import 'package:web/widgets/preview/indicator.dart';
import 'package:web/widgets/preview/settings/settings.dart';
import 'dart:async';

class Preview extends StatefulWidget {
  // ignore: prefer_const_constructors_in_immutables
  Preview({Key? key, this.width = 950, this.height = 520, this.stack = true, this.scale = 1, this.mainAxisSize = MainAxisSize.min}) : super(key: key);

  final double width;
  final double height;
  final double scale;
  final bool stack;
  final MainAxisSize mainAxisSize;

  static const double navIconSize = 30;
  static const double indicatorSize = 15;
  static const double indicatorRadius = 30;
  static const Duration animDuration = Duration(milliseconds: 300);
  static const Duration nextViewTimer = Duration(seconds: 10);
  static const Curve animCurve = Curves.easeInOut;

  @override
  State<Preview> createState() => _PreviewState();
}

class _PreviewState extends State<Preview> {
  int _currentIndex = 0;
  late Timer _timer;

  late List<Widget> views;

  @override
  void initState() {
    resetTimer(false);

    super.initState();
  }

  nextPage({bool reset = true}) {
    if (reset) {
      resetTimer(true);
    }
    setState(() {
      if (_currentIndex < views.length - 1) {
        _currentIndex++;
      } else {
        _currentIndex = 0;
      }
    });
  }

  resetTimer(bool hasTimer) {
    if (hasTimer) {
      _timer.cancel();
    }
    _timer = Timer.periodic(Preview.nextViewTimer, (_) => nextPage(reset: false));
  }

  prevPage({bool reset = true}) {
    if (reset) {
      resetTimer(true);
    }
    setState(() {
      if (_currentIndex > 0) {
        _currentIndex--;
      } else {
        _currentIndex = views.length - 1;
      }
    });
  }

  jumpToIndex(int index) {
    if (index == _currentIndex) return;
    setState(() {
      _currentIndex = index;
    });
    resetTimer(true);
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    views = [
      HomePreview(),
      FilterPreview(),
      SettingsPreview(),
    ];

    return ConditionalWrapper(
      condition: widget.stack,
      builder: (context, child) => Transform.scale(
        scale: widget.scale,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            InkWell(
              splashFactory: NoSplash.splashFactory,
              highlightColor: Colors.transparent,
              onTap: prevPage,
              child: Icon(
                FontAwesome.chevron_left,
                size: Preview.navIconSize,
                color: NcThemes.current.textColor,
              ),
            ),
            NcSpacing.xl(),
            child,
            NcSpacing.xl(),
            InkWell(
              splashFactory: NoSplash.splashFactory,
              highlightColor: Colors.transparent,
              onTap: nextPage,
              child: Icon(
                FontAwesome.chevron_right,
                size: Preview.navIconSize,
                color: NcThemes.current.textColor,
              ),
            ),
          ],
        ),
      ),
      falseBuilder: (context, child) => Column(
        mainAxisSize: widget.mainAxisSize,
        children: [
          for (var view in views)
            Transform.scale(
              scale: widget.scale,
              child: Container(
                margin: const EdgeInsets.only(bottom: NcSpacing.xlSpacing),
                width: widget.width,
                height: widget.height,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(ncRadius),
                  boxShadow: ncShadow,
                  color: NcThemes.current.secondaryColor,
                ),
                child: AnimatedContainer(
                  duration: Preview.animDuration,
                  curve: Preview.animCurve,
                  child: view,
                ),
              ),
            ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: widget.width,
            height: widget.height,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(ncRadius),
              boxShadow: ncShadow,
              color: NcThemes.current.secondaryColor,
            ),
            child: PageTransitionSwitcher(
              transitionBuilder: (child, animation, secondaryAnimation) => FadeThroughTransition(
                // transitionType: SharedAxisTransitionType.horizontal,
                animation: animation,
                secondaryAnimation: secondaryAnimation,
                child: child,
                fillColor: Colors.transparent,
              ),
              child: views[_currentIndex],
            ),
          ),
          NcSpacing.medium(),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              for (int i = 0; i < views.length; i++)
                PreviewIndicator(
                  key: GlobalKey(),
                  index: i,
                  currentIndex: _currentIndex,
                  length: views.length,
                  duration: Preview.nextViewTimer,
                  onTap: () => jumpToIndex(i),
                ),
            ],
          )
        ],
      ),
    );
  }
}

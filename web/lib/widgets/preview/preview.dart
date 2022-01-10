import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:nekolib.ui/ui.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:web/widgets/condtional_wrapper.dart.dart';
import 'package:web/widgets/preview/filter/filter.dart';
import 'package:web/widgets/preview/home/home.dart';
import 'package:web/widgets/preview/transform.dart';

class Preview extends StatefulWidget {
  // ignore: prefer_const_constructors_in_immutables
  Preview({Key? key, this.width, this.height, this.stack = true}) : super(key: key);

  final double? width;
  final double? height;
  final bool stack;

  static const double navIconSize = 30;
  static const Duration animDuration = Duration(milliseconds: 300);
  static const Curve animCurve = Curves.easeInOut;

  @override
  State<Preview> createState() => _PreviewState();
}

class _PreviewState extends State<Preview> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    List<Widget> _views = [
      HomePreview(),
      FilterPreview(),
    ];

    return ConditionalWrapper(
      condition: widget.stack,
      builder: (context, child) => PreviewTransform(
        child: child,
      ),
      child: ConditionalWrapper(
        condition: widget.stack,
        builder: (context, child) => Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            GestureDetector(
              onTap: () {
                if (_currentIndex > 0) {
                  setState(() {
                    _currentIndex--;
                  });
                }
              },
              child: Icon(
                FontAwesome.chevron_left,
                size: Preview.navIconSize,
                color: _currentIndex > 0 ? NcThemes.current.textColor : NcThemes.current.tertiaryColor,
              ),
            ),
            NcSpacing.xl(),
            child,
            NcSpacing.xl(),
            InkWell(
              splashFactory: NoSplash.splashFactory,
              highlightColor: Colors.transparent,
              onTap: () {
                if (_currentIndex < _views.length - 1) {
                  setState(() {
                    _currentIndex++;
                  });
                }
              },
              child: Icon(
                FontAwesome.chevron_right,
                size: Preview.navIconSize,
                color: _currentIndex < _views.length - 1 ? NcThemes.current.textColor : NcThemes.current.tertiaryColor,
              ),
            ),
          ],
        ),
        falseBuilder: (context, child) => Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            for (var view in _views)
              Container(
                margin: EdgeInsets.only(bottom: NcSpacing.xlSpacing),
                width: widget.width ?? 900,
                height: widget.height ?? 550,
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
          ],
        ),
        child: Container(
            width: widget.width ?? 900,
            height: widget.height ?? 550,
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
              child: _views[_currentIndex],
            )

            //   duration: Preview.animDuration,
            //   curve: Preview.animCurve,
            // child: _currentIndex == 0 ? HomePreview() : FilterPreview(),
            // ),
            ),
      ),
    );
  }
}

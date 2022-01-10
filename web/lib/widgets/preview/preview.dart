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
  static const tag = "prev";

  @override
  State<Preview> createState() => _PreviewState();
}

class _PreviewState extends State<Preview> {
  @override
  Widget build(BuildContext context) {
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
              onTap: () {},
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
              onTap: () {},
              child: Icon(
                FontAwesome.chevron_right,
                size: Preview.navIconSize,
                color: NcThemes.current.textColor,
              ),
            ),
          ],
        ),
        falseBuilder: (context, child) => Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            child,
            NcSpacing.large(),
            child,
          ],
        ),
        child: AnimatedContainer(
          duration: Preview.animDuration,
          curve: Preview.animCurve,
          width: widget.width ?? 900,
          height: widget.height ?? 550,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(ncRadius),
            boxShadow: ncShadow,
            color: NcThemes.current.secondaryColor,
          ),
          child: HomePreview(),
        ),
      ),
    );
  }
}

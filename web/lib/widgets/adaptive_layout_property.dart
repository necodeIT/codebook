import 'package:flutter/widgets.dart';

class AdaptiveLayoutProperty<T> {
  AdaptiveLayoutProperty({required this.breakPoints, this.mode = AdaptiveLayoutModes.width});

  final Map<double, T> breakPoints;
  final AdaptiveLayoutModes mode;

  T value(BuildContext context) {
    assert(breakPoints.isNotEmpty);

    final mediaQuery = MediaQuery.of(context);
    final size = mediaQuery.size;
    final width = size.width;
    final height = size.height;
    final screenSize = mode == AdaptiveLayoutModes.width ? width : height;
    final screenSizeBreakPoints = breakPoints.keys.toList();
    screenSizeBreakPoints.sort((a, b) => a.compareTo(b));

    for (var screenSizeBreakPoint in screenSizeBreakPoints) {
      if (screenSize <= screenSizeBreakPoint) {
        return breakPoints[screenSizeBreakPoint]!;
      }
    }
    return breakPoints[screenSizeBreakPoints.last]!;
  }
}

enum AdaptiveLayoutModes {
  height,
  width,
}

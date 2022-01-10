import 'dart:math';

import 'package:flutter/material.dart';

class PreviewTransform extends StatelessWidget {
  const PreviewTransform({Key? key, required this.child}) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    // return Transform(
    //   transform: Matrix4.identity()
    //     ..setEntry(3, 2, 0.001)
    //     ..rotateX(pi)
    //     ..rotateY(0.523599)
    //     ..rotateZ(0.01),
    //   child: child,
    // );
    return child;
  }
}

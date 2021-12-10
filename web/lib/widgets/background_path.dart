import 'package:flutter/material.dart';
import 'package:nekolib.ui/ui.dart';

class BackgroundPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = NcThemes.current.accentColor.withOpacity(.4)
      ..style = PaintingStyle.fill;

    Path path = Path();
    path.lineTo(0, size.height * .6);
    // path.quadraticBezierTo(0, size.height * .5, size.width * .25, size.height * .75);
    // path.arcToPoint(Offset(0, size.height * 0.6708063), radius: Radius.elliptical(size.width * 0.05462108, size.height * 0.08537535), rotation: 0, largeArc: false, clockwise: false);
    path.lineTo(size.width, size.height * .25);
    path.lineTo(size.width, 0);
    path.lineTo(0, 0);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}

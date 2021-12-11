import 'package:flutter/material.dart';
import 'package:nekolib.ui/ui.dart';

class BackgroundPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // Paint paint = Paint()
    //   ..color = NcThemes.current.accentColor.withOpacity(.4)
    //   ..style = PaintingStyle.fill;

    // Path path = Path();
    // path.lineTo(0, size.height * .75);
    // // path.relativeQuadraticBezierTo(0, size.height * .6, size.width * .25, size.height * .6);
    // path.lineTo(size.width * .5, size.height * .6);
    // // path.arcToPoint(Offset(0, size.height * 0.6708063), radius: Radius.elliptical(size.width * 0.05462108, size.height * 0.08537535), rotation: 0, largeArc: false, clockwise: false);
    // path.lineTo(size.width, size.height * .25);
    // path.lineTo(size.width, 0);
    // path.lineTo(0, 0);
    // canvas.drawPath(path, paint);
    Paint paint0 = Paint()
      ..color = NcThemes.current.accentColor.withOpacity(.4)
      ..style = PaintingStyle.fill
      ..strokeWidth = 1.0;

    const yfactor = 1.25;
    const xfactor = 1;

    Path path0 = Path();
    path0.moveTo(0, 0);
    path0.quadraticBezierTo(0, size.height * 0.3735000 * yfactor, 0, size.height * 0.4980000 * yfactor);
    path0.cubicTo(size.width * 0.0165625 * xfactor, size.height * 0.5460000 * yfactor, size.width * 0.0321875 * xfactor, size.height * 0.6540000 * yfactor, size.width * 0.1562500 * xfactor, size.height * 0.6100000 * yfactor);
    path0.quadraticBezierTo(size.width * 0.3671875 * xfactor, size.height * 0.5235000 * yfactor, size.width, size.height * 0.2640000 * yfactor);
    path0.lineTo(size.width, 0);
    path0.lineTo(0, 0);
    path0.close();

    canvas.drawPath(path0, paint0);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}

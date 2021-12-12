import 'package:flutter/material.dart';
import 'package:nekolib.ui/ui.dart';
import 'package:web/themes.dart.dart';

class BackgroundPainter extends CustomPainter {
  final ThemeableProperty<Color> color = ThemeableProperty.only(Colors.black, {
    NcThemes.light.name: NcThemes.light.accentColor.withOpacity(.4),
    NcThemes.ocean.name: NcThemes.ocean.tertiaryColor,
    NcThemes.sakura.name: NcThemes.sakura.accentColor.withOpacity(.4),
    CustomThemes.darkPurple.name: CustomThemes.darkPurple.accentColor.withOpacity(.4),
  });

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint0 = Paint()
      ..color = color.value
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

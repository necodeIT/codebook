import 'package:flutter/material.dart';
import 'package:nekolib.ui/ui.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:responsive_framework/responsive_framework.dart';

class Preview extends StatefulWidget {
  // ignore: prefer_const_constructors_in_immutables
  Preview({Key? key}) : super(key: key);

  static const double navIconSize = 30;

  @override
  State<Preview> createState() => _PreviewState();
}

class _PreviewState extends State<Preview> {
  @override
  Widget build(BuildContext context) {
    return Row(
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
        Container(
          width: 900,
          height: 550,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(ncRadius),
            boxShadow: ncShadow,
            color: NcThemes.current.primaryColor,
          ),
        ),
        NcSpacing.xl(),
        GestureDetector(
          onTap: () {},
          child: Icon(
            FontAwesome.chevron_right,
            size: Preview.navIconSize,
            color: NcThemes.current.textColor,
          ),
        ),
      ],
    );
  }
}

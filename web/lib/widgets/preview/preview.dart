import 'package:flutter/material.dart';
import 'package:nekolib.ui/ui.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';

class Preview extends StatefulWidget {
  // ignore: prefer_const_constructors_in_immutables
  Preview({Key? key}) : super(key: key);

  static const double navIconSize = 60;

  @override
  State<Preview> createState() => _PreviewState();
}

class _PreviewState extends State<Preview> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton(
          onPressed: () {},
          icon: Icon(
            Ionicons.ios_arrow_down_circle_sharp,
            size: Preview.navIconSize,
            color: NcThemes.current.textColor,
          ),
        ),
        NcSpacing.xl(),
        NcSpacing.xl(),
        Container(
          width: MediaQuery.of(context).size.width * .6,
          height: MediaQuery.of(context).size.height * .6,
          decoration: BoxDecoration(
            color: NcThemes.current.primaryColor,
          ),
        ),
      ],
    );
  }
}

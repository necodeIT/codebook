// ignore_for_file: prefer_const_constructors_in_immutables

import 'package:flutter/material.dart';
import 'package:nekolib.ui/ui/widgets/text/caption_text.dart';

class FilterPreview extends StatelessWidget {
  FilterPreview({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: NcCaptionText("Filter Preview"),
    );
  }
}

import 'package:codebook/widgets/codeblock/code_block.dart';
import 'package:flutter/material.dart';
import 'package:nekolib.ui/ui.dart';

import 'home.dart';

class Filter extends StatelessWidget {
  const Filter({Key? key, required this.onClose}) : super(key: key);

  final Function() onClose;

  static const double elevation = CodeBlock.elevation;
  static const double width = 500;

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: elevation,
      color: NcThemes.current.primaryColor,
      child: SizedBox(
        height: double.infinity,
        width: width,
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: NcSpacing.largeSpacing),
              alignment: Alignment.centerRight,
              width: double.infinity,
              child: IconButton(
                onPressed: onClose,
                icon: Icon(
                  Icons.close,
                  color: NcThemes.current.tertiaryColor,
                  size: Home.iconSize,
                ),
                splashColor: Colors.transparent,
                splashRadius: 1,
              ),
            )
          ],
        ),
      ),
    );
  }
}

// ignore_for_file: prefer_const_constructors_in_immutables

import 'package:flutter/material.dart';
import 'package:nekolib.ui/ui.dart';
import 'package:web/widgets/preview/codeblock/code_block.dart';
import 'package:web/widgets/preview/filter/filter/filter.dart';

class FilterPreview extends StatelessWidget {
  FilterPreview({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(NcSpacing.largeSpacing),
      child: Row(
        children: [
          Expanded(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    NcTitleText(
                      "CodeBook",
                      fontSize: 20,
                      selectable: false,
                    ),
                    Row(
                      children: [
                        Icon(Icons.upload, color: NcThemes.current.tertiaryColor),
                        NcSpacing.xs(),
                        Icon(Icons.download, color: NcThemes.current.tertiaryColor),
                        NcSpacing.xs(),
                        Icon(Icons.settings, color: NcThemes.current.tertiaryColor),
                        NcSpacing.xs(),
                        Icon(Icons.filter_alt_sharp, color: NcThemes.current.tertiaryColor),
                      ],
                    ),
                  ],
                ),
                NcSpacing.medium(),
                Expanded(
                  child: ListView(
                    children: [
                      CodeBlock(code: 'print("Hello World!")', desc: "Python hello world", language: "python", tags: const ["example"]),
                    ],
                  ),
                ),
              ],
            ),
          ),
          NcSpacing.medium(),
          Filter(tags: {"example": true, "catgirl": false}, languages: ["python"], language: "python"),
        ],
      ),
    );
  }
}

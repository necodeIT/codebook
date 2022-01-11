// ignore_for_file: prefer_const_constructors_in_immutables

import 'package:flutter/material.dart';
import 'package:nekolib.ui/ui.dart';
import 'package:web/widgets/preview/codeblock/code_block.dart';
import 'package:web/widgets/preview/filter/filter/filter.dart';

class FilterPreview extends StatelessWidget {
  FilterPreview({Key? key, this.filterWidth = Filter.defaultWidth}) : super(key: key);

  final double filterWidth;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: NcSpacing.largeSpacing),
      child: Row(
        children: [
          Expanded(
            child: Column(
              children: [
                NcSpacing.medium(),
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
                      ],
                    ),
                  ],
                ),
                NcSpacing.medium(),
                Expanded(
                  child: ListView(
                    physics: const NeverScrollableScrollPhysics(),
                    children: [
                      CodeBlock(code: 'print("Hello World!")', desc: "Python hello world", language: "python", tags: const ["example", "preview"]),
                      CodeBlock(code: 'path = "Test.txt"\ncontent = "Hello World!"\nf = open(path, "a")\nf.write(content)\nf.close()', desc: "Write file", language: "python", tags: const ["example", "preview"]),
                    ],
                  ),
                ),
              ],
            ),
          ),
          NcSpacing.medium(),
          Filter(tags: const {"example": true, "preview": false}, languages: const ["python"], language: "python", width: filterWidth),
        ],
      ),
    );
  }
}

// ignore_for_file: prefer_const_constructors_in_immutables

import 'package:flutter/material.dart';
import 'package:nekolib.ui/ui.dart';
import 'package:web/widgets/preview/codeblock/code_block.dart';

class HomePreview extends StatelessWidget {
  HomePreview({Key? key}) : super(key: key);

  static const double titleSize = 30;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: NcSpacing.largeSpacing, vertical: NcSpacing.mediumSpacing),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              NcTitleText(
                "CodeBook",
                fontSize: 20,
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
              controller: ScrollController(),
              physics: const NeverScrollableScrollPhysics(),
              children: [
                CodeBlock(code: 'print("Hello World!")', desc: "Python hello world", language: "python", tags: const ["example", "preview"]),
                CodeBlock(code: 'path = "Test.txt"\ncontent = "Hello World!"\nf = open(path, "a")\nf.write(content)\nf.close()', desc: "Write file", language: "python", tags: const ["example", "preview"]),
                CodeBlock(code: 'print("Hello World!")', desc: "Hello world in dart", language: "dart", tags: const ["example", "preview"]),
              ],
            ),
          )
        ],
      ),
    );
  }
}

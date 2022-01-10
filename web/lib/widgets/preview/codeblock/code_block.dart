// ignore_for_file: prefer_const_constructors_in_immutables

import 'package:flutter/material.dart';
import 'package:nekolib.ui/ui.dart';
import 'package:web/widgets/preview/codeblock/code_field.dart';
import 'package:web/widgets/preview/codeblock/tag/tag.dart';

import 'language_tag/language_tag.dart';

class CodeBlock extends StatefulWidget {
  CodeBlock({Key? key, required this.code, required this.desc, required this.language, required this.tags}) : super(key: key);

  final String code;
  final String desc;
  final String language;
  final List<String> tags;

  static const double iconSize = 20;
  static const double descSize = 16;

  @override
  State<CodeBlock> createState() => _CodeBlockState();
}

class _CodeBlockState extends State<CodeBlock> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: NcSpacing.xlSpacing),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          NcBodyText(
            widget.desc,
            overflow: TextOverflow.visible,
            fontSize: CodeBlock.descSize,
            selectable: false,
          ),
          NcSpacing.xs(),
          CodeField(
            code: widget.code,
            language: widget.language,
          ),
          NcSpacing.small(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(children: generateTags()),
              LanguageTag(
                initialValue: widget.language,
              ),
            ],
          )
        ],
      ),
    );
  }

  List<Widget> generateTags() {
    var list = <Widget>[];
    for (var tag in widget.tags) {
      list.add(Tag(label: tag));

      list.add(NcSpacing.small());
    }

    return list;
  }
}

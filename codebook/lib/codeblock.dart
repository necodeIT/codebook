import 'package:flutter/material.dart';
import 'package:nekolib.ui/ui.dart';

class CodeBlock extends StatefulWidget {
  const CodeBlock({Key? key, required this.description, required this.language, required this.tags, required this.code}) : super(key: key);

  final String description;
  final String code;
  final String language;
  final List<String> tags;

  @override
  State<CodeBlock> createState() => _CodeBlockState();
}

class _CodeBlockState extends State<CodeBlock> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        NcBodyText(widget.description),
        NcSpacing.xs(),
        Expanded(child: NcContainer(body: NcBodyText(widget.code), label: NcTitleText("dasad"))),
        NcSpacing.xs(),
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [Row(children: generateTags()), NcBodyText(widget.language)],
          ),
        )
      ],
    );
  }

  List<Widget> generateTags() {
    var list = <Widget>[];

    for (var tag in widget.tags) {
      list.add(NcBodyText(tag));
      list.add(NcSpacing.xs());
    }

    return list;
  }
}

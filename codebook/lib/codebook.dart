import 'package:codebook/widgets/language_tag/language_tag.dart';
import 'package:flutter/material.dart';
import 'package:nekolib.ui/ui.dart';

class CodeBook extends StatefulWidget {
  const CodeBook({Key? key}) : super(key: key);

  @override
  _CodeBookState createState() => _CodeBookState();
}

class _CodeBookState extends State<CodeBook> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(NcSpacing.largeSpacing),
      // child: ListView(
      //   // ignore: prefer_const_literals_to_create_immutables
      //   children: [
      //     CodeBlock(description: "Testytest", language: "catgirl", tags: ["dasdasd", "dasdad"], code: "deine mom"),
      //   ],
      // ),
      child: const LanguageTag(
        editMode: false,
      ),
      // child: HighlightView(
      //   'void main(){}',
      //   language: "c#",
      //   theme: oceanTheme,
      // ),
    );
  }
}

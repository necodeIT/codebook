import 'package:codebook/widgets/language_tag/language_input.dart';
import 'package:codebook/widgets/language_tag/language_tag.dart';
import 'package:flutter/material.dart';
import 'package:flutter_highlight/flutter_highlight.dart';
import 'package:nekolib.ui/ui.dart';

class CodeBlock extends StatefulWidget {
  const CodeBlock({Key? key, required this.description, required this.language, required this.tags, required this.code}) : super(key: key);

  final String description;
  final String code;
  final String language;
  final List<String> tags;

  static const double elevation = 3;
  static const double padding = 20;
  static const double borderRadius = LanguageInput.borderRadius;
  static const double iconSize = 20;

  @override
  State<CodeBlock> createState() => _CodeBlockState();
}

class _CodeBlockState extends State<CodeBlock> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        NcBodyText(
          widget.description,
          overflow: TextOverflow.visible,
        ),
        NcSpacing.xs(),
        Material(
          borderRadius: BorderRadius.circular(CodeBlock.borderRadius),
          elevation: CodeBlock.elevation,
          child: Container(
            padding: const EdgeInsets.all(CodeBlock.padding),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(CodeBlock.borderRadius),
              color: NcThemes.current.primaryColor,
            ),
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.remove_red_eye,
                          color: NcThemes.current.accentColor,
                          size: CodeBlock.iconSize,
                        ),
                        NcSpacing.small(),
                        Icon(
                          Icons.short_text,
                          color: NcThemes.current.tertiaryColor,
                          size: CodeBlock.iconSize,
                        ),
                        NcSpacing.small(),
                        Icon(
                          Icons.edit,
                          color: NcThemes.current.tertiaryColor,
                          size: CodeBlock.iconSize,
                        ),
                      ],
                    ),
                    OutlinedButton.icon(
                      onPressed: () {},
                      icon: Icon(
                        Icons.copy,
                        color: NcThemes.current.tertiaryColor,
                        size: CodeBlock.iconSize,
                      ),
                      label: NcCaptionText("COPY", buttonText: true),
                    )
                  ],
                ),
                NcSpacing.medium(),
                NcBodyText(widget.code),
              ],
            ),
          ),
        ),
        NcSpacing.small(),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(children: generateTags()),
            LanguageTag(
              initialValue: widget.language,
            )
          ],
        )
      ],
    );
  }

  List<Widget> generateTags() {
    var list = <Widget>[];

    for (var tag in widget.tags) {
      list.add(
        Chip(
          label: NcBodyText(tag, buttonText: true),
          backgroundColor: NcThemes.current.accentColor.withOpacity(LanguageInput.backgroundOpacity),
          shape: StadiumBorder(
            side: BorderSide(
              color: NcThemes.current.accentColor,
            ),
          ),
        ),
      );
      list.add(NcSpacing.xs());
    }

    return list;
  }
}

import 'package:clipboard/clipboard.dart';
import 'package:codebook/widgets/codeblock/code_field.dart';
import 'package:codebook/widgets/language_tag/language_input.dart';
import 'package:codebook/widgets/language_tag/language_tag.dart';
import 'package:flutter/material.dart';
import 'package:flutter_highlight/flutter_highlight.dart';
import 'package:nekolib.ui/ui.dart';

import 'view_mode.dart';

class CodeBlock extends StatefulWidget {
  const CodeBlock({Key? key, required this.description, required this.language, required this.tags, required this.code}) : super(key: key);

  final String description;
  final String code;
  final String language;
  final List<String> tags;

  static const double elevation = 3;
  static const int copiedDelay = 1;
  static const double padding = 10;
  static const double borderRadius = LanguageInput.borderRadius;
  static const double iconSize = 20;
  static const copy_text_preset = "COPY";
  static const copied_text_preset = "COPIED";
  static const copied_icon_preset = Icons.check;
  static const copy_icon_preset = Icons.copy;

  @override
  State<CodeBlock> createState() => _CodeBlockState();
}

class _CodeBlockState extends State<CodeBlock> {
  ViewMode _mode = ViewMode.Format;
  late String _language;
  late String _code;
  late IconData _copyIcon = CodeBlock.copy_icon_preset;
  late String _copyText = CodeBlock.copy_text_preset;

  void saveCodeToClipboard() {
    setState(() {
      _copyIcon = CodeBlock.copied_icon_preset;
      _copyText = CodeBlock.copied_text_preset;
    });

    FlutterClipboard.copy(_code);

    Future.delayed(
      const Duration(seconds: CodeBlock.copiedDelay),
    ).then(
      (value) => setState(() {
        _copyIcon = CodeBlock.copy_icon_preset;
        _copyText = CodeBlock.copy_text_preset;
      }),
    );
  }

  void updateLanguage(String lang) {
    _language = lang;
  }

  void updateCode(String code) {
    _code = code;
  }

  void changeMode(ViewMode mode) {
    setState(() {
      _mode = mode;
    });
  }

  @override
  void initState() {
    super.initState();
    _language = widget.language;
    _code = widget.code;
  }

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
        CodeField(
          mode: _mode,
          onModeChange: changeMode,
          code: _code,
          language: _language,
          onCodeChange: updateCode,
          copyIcon: _copyIcon,
          copyText: _copyText,
          onCopy: saveCodeToClipboard,
        ),
        NcSpacing.small(),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(children: generateTags()),
            LanguageTag(
              initialValue: _language,
              editMode: _mode == ViewMode.Edit,
              onValueChange: updateLanguage,
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

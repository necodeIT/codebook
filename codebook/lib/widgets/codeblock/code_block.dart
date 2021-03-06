import 'package:clipboard/clipboard.dart';
import 'package:codebook/db/db.dart';
import 'package:codebook/widgets/autocomplete/dropdown.dart';
import 'package:codebook/widgets/codeblock/code_field.dart';
import 'package:codebook/widgets/codeblock/tag/tag.dart';
import 'package:codebook/widgets/codeblock/tag/tag_input.dart';
import 'package:codebook/widgets/codeblock/language_tag/language_tag.dart';
import 'package:codebook/widgets/home/filter/filter.dart';
import 'package:codebook/widgets/text_input/input.dart';
import 'package:flutter/material.dart';
import 'package:nekolib_ui/core.dart';
import 'package:nekolib_utils/log.dart';

import 'view_mode.dart';

class CodeBlock extends StatefulWidget {
  const CodeBlock({
    Key? key,
    required this.onDelete,
    required this.code,
    required this.desc,
    required this.language,
    required this.tags,
    required this.onUpdate,
    required this.id,
  }) : super(key: key);

  final String code;
  final String desc;
  final String language;
  final List<String> tags;
  final String id;
  final Function() onDelete;

  /// desc, language, tags, code
  final Function(String, String, List<String>, String) onUpdate;

  static const int copiedDelay = 1;
  static const double iconSize = 20;
  static const double descSize = 16;
  static const copyTextPreset = "COPY";
  static const copiedTextPreset = "COPIED";
  static const descLabel = "Description";
  static const copiedIconPreset = Icons.check;
  static const copyIconPreset = Icons.copy;

  @override
  State<CodeBlock> createState() => _CodeBlockState();
}

class _CodeBlockState extends State<CodeBlock> {
  ViewMode _mode = ViewMode.format;
  late IconData _copyIcon = CodeBlock.copyIconPreset;
  late String _copyText = CodeBlock.copyTextPreset;
  Color _copyColor = NcThemes.current.accentColor;

  late String _code = widget.code;
  late String _desc = widget.desc;
  late String _language = widget.language;
  late final List<String> _tags = List.from(widget.tags, growable: true);

  void saveCodeToClipboard() {
    setState(() {
      _copyIcon = CodeBlock.copiedIconPreset;
      _copyText = CodeBlock.copiedTextPreset;
      _copyColor = NcThemes.current.successColor;
    });

    FlutterClipboard.copy(_code);

    log("${widget.desc}@${widget.id}: Copied code to clipboard!", LogTypes.tracking);

    Future.delayed(
      const Duration(seconds: CodeBlock.copiedDelay),
    ).then(
      (value) => setState(() {
        _copyIcon = CodeBlock.copyIconPreset;
        _copyText = CodeBlock.copyTextPreset;
        _copyColor = NcThemes.current.accentColor;
      }),
    );
  }

  void updateLanguage(String lang) {
    if (_language == lang) return;

    log("${widget.desc}@${widget.id}: user changed language from '$_language' to '$lang'", LogTypes.tracking);

    _language = lang;
  }

  void updateCode(String code) {
    if (code == _code) return;

    log("${widget.desc}@${widget.id}: user changed code from '$_code' to '$code'", LogTypes.tracking);

    _code = code;
  }

  void changeMode(ViewMode mode) {
    if (_mode == mode) return;

    if (_mode == ViewMode.edit && mode != ViewMode.edit) {
      widget.onUpdate(_desc, _language, _tags, _code);
      DB.update();
    }

    log("${widget.desc}@${widget.id}: user changed mode from '$_mode' to '$mode'", LogTypes.tracking);

    setState(() {
      _mode = mode;
    });
  }

  void updateDesc(String desc) {
    if (desc == _desc) return;

    log("${widget.desc}@${widget.id}: user changed desc from '$_desc' to '$desc'", LogTypes.tracking);

    _desc = desc;
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedSize(
      duration: Filter.animationDuration,
      curve: Filter.animationCurve,
      child: Padding(
        padding: const EdgeInsets.only(bottom: NcSpacing.xlSpacing),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (_mode == ViewMode.edit) NcSpacing.medium(),
            _mode != ViewMode.edit
                ? NcBodyText(
                    _desc,
                    overflow: TextOverflow.visible,
                    fontSize: CodeBlock.descSize,
                  )
                : TextInput(label: CodeBlock.descLabel, inintialText: _desc, onChange: updateDesc),
            NcSpacing.xs(),
            CodeField(
              mode: _mode,
              onModeChange: changeMode,
              code: _code,
              language: _language,
              onCodeChange: updateCode,
              copyIcon: _copyIcon,
              copyText: _copyText,
              copyColor: _mode == ViewMode.edit ? NcThemes.current.errorColor : _copyColor,
              onCopy: saveCodeToClipboard,
              onDelete: handleDeleteReq,
            ),
            NcSpacing.small(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(children: generateTags()),
                LanguageTag(
                  initialValue: _language,
                  editMode: _mode == ViewMode.edit,
                  onValueChange: updateLanguage,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  List<Widget> generateTags() {
    var list = <Widget>[];
    for (var tag in _tags) {
      list.add(
        Tag(
          editMode: _mode == ViewMode.edit,
          label: tag,
          onTap: _mode == ViewMode.edit
              ? () {
                  log("${widget.desc}@${widget.id}: user removed tag '$tag'", LogTypes.tracking);

                  setState(() {
                    _tags.remove(tag);
                  });
                }
              : null,
        ),
      );

      list.add(NcSpacing.small());
    }

    if (_mode == ViewMode.edit && _tagInput) {
      list.add(
        Autocomplete<String>(
          optionsBuilder: (value) => DB.tags.where((tag) => tag.toLowerCase().contains(value.text.toLowerCase())),
          fieldViewBuilder: (context, controller, focus, _) => TagInput(controller: controller, focus: focus, onSubmit: destroyTagInput),
          optionsViewBuilder: AutoCompleteDropdown.builder,
          onSelected: destroyTagInput,
        ),
      );
    }

    if (_mode == ViewMode.edit && !_tagInput) {
      list.add(Tag.add(onTap: createTagInput, icon: Icons.add));
    }

    return list;
  }

  bool _tagInput = false;

  handleDeleteReq() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: NcTitleText("Are you sure?"),
        content: NcBodyText("Are you sure you want to delete this ingredient?"),
        backgroundColor: NcThemes.current.primaryColor,
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              // Dont ask why it workds so i wont touch it
              setState(() {
                _mode = ViewMode.format;
              });

              log("user deleted ${widget.desc}@${widget.id}", LogTypes.tracking);

              widget.onDelete();
            },
            child: NcCaptionText("Yes"),
          ),
          TextButton(onPressed: () => Navigator.of(context).pop(), child: NcCaptionText("No"))
        ],
      ),
    );
  }

  createTagInput() {
    setState(() {
      _tagInput = true;
    });
  }

  destroyTagInput(String value) {
    log("${widget.desc}@${widget.id}: user added '$value'-tag", LogTypes.tracking);

    setState(() {
      _tagInput = false;
      if (value.isNotEmpty) _tags.add(value);
    });
  }
}

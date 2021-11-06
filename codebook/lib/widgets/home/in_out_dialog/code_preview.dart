import 'package:codebook/code_themes.dart';
import 'package:codebook/db/db.dart';
import 'package:codebook/db/ingredient.dart';
import 'package:codebook/db/settings.dart';
import 'package:codebook/widgets/codeblock/code_block.dart';
import 'package:codebook/widgets/codeblock/language_tag/language_input.dart';
import 'package:codebook/widgets/codeblock/tag/tag.dart';
import 'package:codebook/widgets/settings/code_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_highlight/flutter_highlight.dart';
import 'package:nekolib.ui/ui.dart';

class CodePreview extends StatefulWidget {
  const CodePreview({Key? key, required this.onTap, required this.checkDuplicate, required this.data}) : super(key: key);

  final Ingredient data;
  final Function(bool) onTap;
  final bool checkDuplicate;

  static const double width = 400;
  static const double height = 300;
  static const double duplicateFontSize = 13;
  static const EdgeInsets duplicatePadding = EdgeInsets.symmetric(vertical: 5, horizontal: 10);

  @override
  State<CodePreview> createState() => _CodePreviewState();
}

class _CodePreviewState extends State<CodePreview> {
  bool _selected = false;

  toggleSelected() {
    setState(() {
      _selected = !_selected;
    });

    widget.onTap(_selected);
  }

  @override
  Widget build(BuildContext context) {
    var duplicate = widget.checkDuplicate && DB.ingredients.any((catgirl) => catgirl.code == widget.data.code);
    var color = _selected
        ? duplicate
            ? NcThemes.current.warningColor
            : NcThemes.current.accentColor
        : NcThemes.current.primaryColor;

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: toggleSelected,
        child: Material(
          elevation: CodeBlock.elevation,
          color: NcThemes.current.primaryColor,
          borderRadius: BorderRadius.circular(CodeBlock.borderRadius),
          child: Container(
            width: CodePreview.width,
            height: CodePreview.height,
            padding: const EdgeInsets.all(CodeTheme.padding),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(CodeBlock.borderRadius),
              color: _selected ? color.withOpacity(LanguageInput.backgroundOpacity) : color,
              border: _selected ? Border.all(color: color) : null,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    NcBodyText(widget.data.desc, fontSize: CodeBlock.descSize),
                    if (_selected) CodeTheme.selectedIndicator,
                  ],
                ),
                NcSpacing.medium(),
                Expanded(
                  child: HighlightView(
                    widget.data.code,
                    language: widget.data.language,
                    theme: kCodeThemes[Settings.codeTheme]!,
                  ),
                ),
                if (duplicate) Tag(label: "Duplicate", color: NcThemes.current.errorColor, fontSize: CodePreview.duplicateFontSize, padding: CodePreview.duplicatePadding)
              ],
            ),
          ),
        ),
      ),
    );
  }
}

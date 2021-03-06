import 'package:codebook/code_themes.dart';
import 'package:codebook/db/db.dart';
import 'package:codebook/db/ingredient.dart';
import 'package:codebook/db/settings.dart';
import 'package:codebook/main.dart';
import 'package:codebook/widgets/codeblock/code_block.dart';
import 'package:codebook/widgets/codeblock/tag/tag.dart';
import 'package:codebook/widgets/selected_indicator.dart';
import 'package:codebook/widgets/themed_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_highlight/flutter_highlight.dart';
import 'package:nekolib_ui/core.dart';
import 'package:nekolib_ui/utils.dart';

class CodePreview extends StatefulWidget {
  const CodePreview({Key? key, required this.onToggle, required this.checkDuplicate, required this.data, required this.selected}) : super(key: key);

  final Ingredient data;
  final Function(bool) onToggle;
  final bool checkDuplicate;
  final bool selected;

  static const double width = 400;
  static const double height = 300;
  static const double duplicateFontSize = 13;
  static const EdgeInsets duplicatePadding = EdgeInsets.symmetric(vertical: 5, horizontal: 10);

  @override
  State<CodePreview> createState() => _CodePreviewState();
}

class _CodePreviewState extends State<CodePreview> {
  @override
  Widget build(BuildContext context) {
    var duplicate = widget.checkDuplicate && DB.ingredients.any((catgirl) => catgirl.code == widget.data.code);
    var exactDuplicate = widget.checkDuplicate && DB.ingredients.any((catgirl) => catgirl.hash == widget.data.hash);
    var color = widget.selected
        ? duplicate
            ? exactDuplicate
                ? errorColor
                : warningColor
            : NcThemes.current.accentColor
        : NcThemes.current.primaryColor;

    return GestureDetector(
      onTap: () => widget.onToggle(!widget.selected),
      child: ThemedCard(
        width: CodePreview.width,
        height: CodePreview.height,
        outlined: widget.selected,
        color: color,
        child: ScaleOnHover(
          duration: kHoverDuration,
          scale: 1.0125,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  NcBodyText(widget.data.desc, fontSize: CodeBlock.descSize),
                  if (widget.selected)
                    SelectedIndicator(
                        color: duplicate
                            ? exactDuplicate
                                ? errorColor
                                : warningColor
                            : NcThemes.current.accentColor),
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
              if (duplicate || exactDuplicate)
                Tag(
                  label: exactDuplicate ? "Duplicate" : "Duplicate Code",
                  color: exactDuplicate ? errorColor : warningColor,
                  fontSize: CodePreview.duplicateFontSize,
                  padding: CodePreview.duplicatePadding,
                )
            ],
          ),
        ),
      ),
    );
  }
}

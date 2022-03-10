import 'package:codebook/code_themes.dart';
import 'package:codebook/db/settings.dart';
import 'package:codebook/widgets/codeblock/view_mode.dart';
import 'package:codebook/widgets/codeblock/language_tag/language_input.dart';
import 'package:codebook/widgets/home/home_icon_button.dart';
import 'package:codebook/widgets/text_input/input.dart';
import 'package:codebook/widgets/themed_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_highlight/flutter_highlight.dart';
import 'package:nekolib_ui/core.dart';

import 'code_block.dart';

class CodeField extends StatelessWidget {
  const CodeField({
    Key? key,
    required this.mode,
    required this.onModeChange,
    required this.code,
    required this.language,
    required this.onCodeChange,
    required this.copyText,
    required this.copyIcon,
    required this.onCopy,
    required this.onDelete,
    required this.copyColor,
  }) : super(key: key);

  final ViewMode mode;
  final String code;
  final String copyText;
  final Color copyColor;
  final IconData copyIcon;
  final String language;
  final Function(ViewMode) onModeChange;
  final Function(String) onCodeChange;
  final Function() onDelete;
  final Function() onCopy;

  static const deleteText = "DELETE";
  static const codeLabel = "Code";

  @override
  Widget build(BuildContext context) {
    return ThemedCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  HomeIconButton(
                    tooltip: "Formatted view",
                    onPressed: () => onModeChange(ViewMode.format),
                    color: mode == ViewMode.format ? NcThemes.current.accentColor : NcThemes.current.tertiaryColor,
                    icon: Icons.remove_red_eye,
                  ),
                  NcSpacing.small(),
                  HomeIconButton(
                    tooltip: "Raw view",
                    onPressed: () => onModeChange(ViewMode.raw),
                    color: mode == ViewMode.raw ? NcThemes.current.accentColor : NcThemes.current.tertiaryColor,
                    icon: Icons.short_text,
                  ),
                  NcSpacing.small(),
                  HomeIconButton(
                    tooltip: "Edit view",
                    onPressed: () => onModeChange(ViewMode.edit),
                    color: mode == ViewMode.edit ? NcThemes.current.accentColor : NcThemes.current.tertiaryColor,
                    icon: Icons.edit,
                  ),
                ],
              ),
              OutlinedButton.icon(
                onPressed: mode == ViewMode.edit ? onDelete : onCopy,
                icon: Icon(
                  mode == ViewMode.edit ? Icons.delete : copyIcon,
                  color: copyColor,
                  size: CodeBlock.iconSize,
                ),
                label: Text(
                  mode == ViewMode.edit ? deleteText : copyText,
                  style: TextStyle(
                    color: copyColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                style: OutlinedButton.styleFrom(
                  backgroundColor: copyColor.withOpacity(LanguageInput.backgroundOpacity),
                  side: BorderSide(width: 1.0, color: copyColor),
                  padding: const EdgeInsets.all(8),
                  primary: copyColor,
                ),
              )
            ],
          ),
          NcSpacing.medium(),
          mode == ViewMode.format
              ? HighlightView(
                  code,
                  language: language,
                  theme: kCodeThemes[Settings.codeTheme]!,
                )
              : mode == ViewMode.raw
                  ? SelectableText(
                      code,
                      style: NcBaseText.style(),
                    )
                  : TextInput(
                      onChange: onCodeChange,
                      label: codeLabel,
                      inintialText: code,
                    ),
        ],
      ),
    );
  }
}

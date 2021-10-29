import 'package:codebook/widgets/codeblock/view_mode.dart';
import 'package:codebook/widgets/language_tag/language_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_highlight/flutter_highlight.dart';
import 'package:flutter_highlight/themes/github.dart';
import 'package:flutter_highlight/themes/ocean.dart';
import 'package:nekolib.ui/ui.dart';

import 'code_block.dart';

class CodeField extends StatelessWidget {
  const CodeField({Key? key, required this.mode, required this.onModeChange, required this.code, required this.language, required this.onCodeChange, required this.copyText, required this.copyIcon, required this.onCopy}) : super(key: key);

  final ViewMode mode;
  final String code;
  final String copyText;
  final IconData copyIcon;
  final String language;
  final void Function(ViewMode) onModeChange;
  final void Function(String) onCodeChange;
  final void Function() onCopy;

  @override
  Widget build(BuildContext context) {
    return Material(
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
                    IconButton(
                      onPressed: () => onModeChange(ViewMode.Format),
                      icon: Icon(
                        Icons.remove_red_eye,
                        color: mode == ViewMode.Format ? NcThemes.current.accentColor : NcThemes.current.tertiaryColor,
                        size: CodeBlock.iconSize,
                      ),
                    ),
                    NcSpacing.small(),
                    IconButton(
                      onPressed: () => onModeChange(ViewMode.Raw),
                      icon: Icon(
                        Icons.short_text,
                        color: mode == ViewMode.Raw ? NcThemes.current.accentColor : NcThemes.current.tertiaryColor,
                        size: CodeBlock.iconSize,
                      ),
                    ),
                    NcSpacing.small(),
                    IconButton(
                      onPressed: () => onModeChange(ViewMode.Edit),
                      icon: Icon(
                        Icons.edit,
                        color: mode == ViewMode.Edit ? NcThemes.current.accentColor : NcThemes.current.tertiaryColor,
                        size: CodeBlock.iconSize,
                      ),
                    ),
                  ],
                ),
                OutlinedButton.icon(
                  onPressed: onCopy,
                  icon: Icon(
                    copyIcon,
                    color: NcThemes.current.accentColor,
                    size: CodeBlock.iconSize,
                  ),
                  label: NcCaptionText(copyText, buttonText: true),
                  style: OutlinedButton.styleFrom(
                    backgroundColor: NcThemes.current.accentColor.withOpacity(LanguageInput.backgroundOpacity),
                    side: BorderSide(width: 1.0, color: NcThemes.current.accentColor),
                    padding: const EdgeInsets.all(8),
                    primary: NcThemes.current.accentColor,
                  ),
                )
              ],
            ),
            NcSpacing.medium(),
            mode == ViewMode.Format
                ? HighlightView(
                    code,
                    language: language,
                    theme: oceanTheme,
                  )
                : mode == ViewMode.Raw
                    ? SelectableText(
                        code,
                        style: NcBaseText.style(),
                      )
                    : NcInputField.multiline(
                        maxLines: null,
                        onValueChanged: onCodeChange,
                      ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_highlight/flutter_highlight.dart';
import 'package:nekolib.ui/ui.dart';
import 'package:web/themes.dart.dart';
import 'package:web/widgets/preview/code_themes.dart';
import 'package:web/widgets/preview/codeblock/language_tag/language_input.dart';
import 'package:web/widgets/preview/home_icon_button.dart';
import 'package:web/widgets/preview/themed_card.dart';

import 'code_block.dart';

class CodeField extends StatelessWidget {
  const CodeField({
    Key? key,
    required this.code,
    required this.language,
  }) : super(key: key);

  final String code;

  final String language;

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
                    icon: Icons.remove_red_eye,
                  ),
                  NcSpacing.small(),
                  HomeIconButton(
                    icon: Icons.short_text,
                  ),
                  NcSpacing.small(),
                  HomeIconButton(
                    icon: Icons.edit,
                  ),
                ],
              ),
              OutlinedButton.icon(
                onPressed: () {},
                icon: Icon(
                  Icons.copy,
                  color: NcThemes.current.accentColor,
                  size: CodeBlock.iconSize,
                ),
                label: NcTitleText(
                  "COPY",
                  color: NcThemes.current.accentColor,
                ),
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
          HighlightView(
            code,
            language: language,
            theme: kCodeThemes[CustomThemes.recommendedCodeThemes[NcThemes.current]!]!,
          ),
        ],
      ),
    );
  }
}

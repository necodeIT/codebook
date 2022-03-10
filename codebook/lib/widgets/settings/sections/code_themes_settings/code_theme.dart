import 'package:codebook/code_themes.dart';
import 'package:codebook/widgets/codeblock/tag/tag.dart';
import 'package:codebook/widgets/conditional_wrap/condtional_wrapper.dart';
import 'package:codebook/widgets/selected_indicator.dart';
import 'package:codebook/widgets/themed_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_highlight/flutter_highlight.dart';
import 'package:nekolib_ui/core.dart';

class CodeTheme extends StatelessWidget {
  const CodeTheme({Key? key, required this.theme, required this.recomended, required this.selected, required this.onTap}) : super(key: key);

  final String theme;
  final bool recomended;
  final bool selected;
  final Function() onTap;

  static const double minWidth = 300;
  static const double minHeight = 145;
  static const double padding = 10;
  static const String previewCode = '''
  public static void Main(String[] args){
    Console.WriteLine("Hello World!");
  }
  ''';
  static const String previewLang = "c#";

  @override
  Widget build(BuildContext context) {
    return ConditionalWrapper(
      condition: !selected,
      builder: (context, child) => MouseRegion(
        cursor: SystemMouseCursors.click,
        child: GestureDetector(
          onTap: onTap,
          child: child,
        ),
      ),
      child: ThemedCard(
        outlined: selected,
        width: minWidth,
        height: minHeight,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                HighlightView(
                  previewCode,
                  language: previewLang,
                  theme: kCodeThemes[theme]!,
                ),
                if (selected) SelectedIndicator()
              ],
            ),
            NcSpacing.medium(),
            Row(
              children: [
                NcBodyText(theme),
                if (recomended) NcSpacing.xs(),
                if (recomended)
                  Tag(
                    label: "Recommended",
                    fontSize: 12,
                    padding: const EdgeInsets.symmetric(vertical: 2.5, horizontal: 5),
                    color: NcThemes.current.successColor,
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:codebook/code_themes.dart';
import 'package:codebook/widgets/codeblock/code_block.dart';
import 'package:codebook/widgets/codeblock/tag/tag.dart';
import 'package:codebook/widgets/codeblock/tag/tag_input.dart';
import 'package:codebook/widgets/conditional_wrap/condtional_wrapper.dart';
import 'package:codebook/widgets/settings/selected_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_highlight/flutter_highlight.dart';
import 'package:nekolib.ui/ui.dart';
import 'package:nekolib.ui/ui/themes/themes.dart';

class CodeTheme extends StatelessWidget {
  const CodeTheme({Key? key, required this.theme, required this.recomended, required this.selected, required this.onTap}) : super(key: key);

  final String theme;
  final bool recomended;
  final bool selected;
  final Function() onTap;

  static const double minWidth = 300;
  static const double minHeight = 138;
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
      child: Material(
        borderRadius: BorderRadius.circular(CodeBlock.borderRadius),
        color: NcThemes.current.primaryColor,
        elevation: CodeBlock.elevation,
        child: Container(
          padding: const EdgeInsets.all(padding),
          width: minWidth,
          decoration: BoxDecoration(
            border: Border.all(color: selected ? NcThemes.current.accentColor : NcThemes.current.primaryColor),
            borderRadius: BorderRadius.circular(CodeBlock.borderRadius),
            color: selected ? NcThemes.current.accentColor.withOpacity(TagInput.backgroundOpacity) : NcThemes.current.primaryColor,
          ),
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
                  // ignoring const because the color wont update otherwise
                  // ignore: prefer_const_constructors
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
      ),
    );
  }
}

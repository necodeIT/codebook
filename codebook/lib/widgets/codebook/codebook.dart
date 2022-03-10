import 'package:codebook/db/db.dart';
import 'package:codebook/db/ingredient.dart';
import 'package:codebook/widgets/codebook/svg/no_data.dart';
import 'package:flutter/material.dart';
import 'package:nekolib_ui/core.dart';
import '../codeblock/code_block.dart';

class CodeBook extends StatefulWidget {
  const CodeBook({Key? key, required this.ingredients, required this.onDeleteIngredient}) : super(key: key);

  final List<Ingredient> ingredients;
  final Function(BuildContext context, Ingredient data) onDeleteIngredient;

  static const double titleSize = 30;

  @override
  _CodeBookState createState() => _CodeBookState();
}

class _CodeBookState extends State<CodeBook> {
  @override
  Widget build(BuildContext context) {
    return DB.ingredients.isNotEmpty
        ? ListView.builder(
            key: UniqueKey(), // bruh this fixes the bug with the listview displaying wrong data
            itemCount: widget.ingredients.length,
            controller: ScrollController(),
            itemBuilder: (context, index) {
              var data = widget.ingredients[index];
              return CodeBlock(
                code: data.code,
                desc: data.desc,
                language: data.language,
                tags: data.tags,
                onUpdate: (desc, lang, tags, code) => data.update(desc: desc, lang: lang, tags: tags, code: code),
                onDelete: () => widget.onDeleteIngredient(context, widget.ingredients[index]),
              );
            },
          )
        : Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const NcVectorImage(code: noDataSvg),
              NcBodyText(
                "No Ingredients... start adding some!",
                fontSize: CodeBlock.descSize,
              ),
            ],
          );
  }
}

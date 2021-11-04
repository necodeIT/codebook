import 'package:codebook/db/db.dart';
import 'package:codebook/db/ingredient.dart';
import 'package:codebook/widgets/codebook/svg/no_data.dart';
import 'package:flutter/material.dart';
import 'package:nekolib.ui/ui.dart';
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
        ? Expanded(
            child: ListView.separated(
              itemCount: widget.ingredients.length,
              separatorBuilder: (_, index) => NcSpacing.xl(),
              controller: ScrollController(),
              itemBuilder: (_, index) => CodeBlock(
                data: widget.ingredients[index],
                onDelete: () => widget.onDeleteIngredient(context, widget.ingredients[index]),
              ),
            ),
          )
        : Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const NcVectorImage(code: noDataSvg),
                NcBodyText("No Ingredients... start adding some!"),
              ],
            ),
          );
  }
}

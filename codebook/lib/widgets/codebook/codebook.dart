import 'package:codebook/db/db.dart';
import 'package:codebook/db/ingredient.dart';
import 'package:codebook/widgets/codebook/svg/no_data.dart';
import 'package:flutter/material.dart';
import 'package:nekolib.ui/ui.dart';
import '../codeblock/code_block.dart';

class CodeBook extends StatefulWidget {
  const CodeBook({Key? key}) : super(key: key);

  static const double titleSize = 30;

  @override
  _CodeBookState createState() => _CodeBookState();
}

class _CodeBookState extends State<CodeBook> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(NcSpacing.largeSpacing),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              NcTitleText(
                "CodeBook",
                fontSize: CodeBook.titleSize,
              ),
              IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.filter_alt_sharp,
                  color: NcThemes.current.tertiaryColor,
                  size: CodeBook.titleSize,
                ),
                splashColor: Colors.transparent,
                splashRadius: 1,
              ),
            ],
          ),
          NcSpacing.large(),
          DB.ingredients.isNotEmpty
              ? Expanded(
                  child: ListView(
                    // ignore: prefer_const_literals_to_create_immutables
                    children: generateBlocks(),
                  ),
                )
              : Column(
                  children: [
                    const NcVectorImage(code: noDataSvg),
                    NcBodyText("No Ingredients... start adding some!"),
                  ],
                ),
        ],
      ),
    );
  }

  deleteIngredient(Ingredient value) {
    setState(() {
      DB.rmIngredient(value);
    });
  }

  List<Widget> generateBlocks() {
    var blocks = <Widget>[];

    for (var block in DB.ingredients) {
      blocks.add(CodeBlock(
        data: block,
        onDelete: deleteIngredient,
      ));
      blocks.add(NcSpacing.xl());
    }

    return blocks;
  }
}

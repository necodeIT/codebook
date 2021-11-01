import 'package:codebook/db/db.dart';
import 'package:codebook/db/ingredient.dart';
import 'package:codebook/widgets/codeblock/home/filter/filter.dart';
import 'package:codebook/widgets/codebook/codebook.dart';
import 'package:flutter/material.dart';
import 'package:nekolib.ui/ui.dart';

class Home extends StatefulWidget {
  const Home({Key? key, required this.refresh}) : super(key: key);

  final Function() refresh;

  static const double iconSize = CodeBook.titleSize * .8;
  static const newLanguage = "python";
  static const newCode = 'print("Hello World")';
  static const newDesc = "New Ingredient";
  static const newTags = ["New"];

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var _filterMode = false;
  var _forceFilterMode = false;
  var _ingredients = DB.ingredients;
  var _currentFilterDesc = "";
  var _currentFilterTags = <String>[];
  String? _currentFilterLanguage;

  toggleFilterMode() {
    setState(() {
      _forceFilterMode = false;
      _filterMode = !_filterMode;
      _ingredients = DB.ingredients;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: NcSpacing.largeSpacing),
              child: Column(
                children: [
                  NcSpacing.small(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      NcTitleText(
                        "CodeBook",
                        fontSize: CodeBook.titleSize,
                      ),
                      Row(
                        children: [
                          IconButton(
                            onPressed: () {},
                            icon: Icon(
                              Icons.upload,
                              color: NcThemes.current.tertiaryColor,
                              size: Home.iconSize,
                            ),
                            splashColor: Colors.transparent,
                            splashRadius: 1,
                          ),
                          IconButton(
                            onPressed: () {},
                            icon: Icon(
                              Icons.download,
                              color: NcThemes.current.tertiaryColor,
                              size: Home.iconSize,
                            ),
                            splashColor: Colors.transparent,
                            splashRadius: 1,
                          ),
                          IconButton(
                            onPressed: () {},
                            icon: Icon(
                              Icons.settings,
                              color: NcThemes.current.tertiaryColor,
                              size: Home.iconSize,
                            ),
                            splashColor: Colors.transparent,
                            splashRadius: 1,
                          ),
                          if (!_filterMode)
                            IconButton(
                              onPressed: toggleFilterMode,
                              icon: Icon(
                                Icons.filter_alt_sharp,
                                color: NcThemes.current.tertiaryColor,
                                size: Home.iconSize,
                              ),
                              splashColor: Colors.transparent,
                              splashRadius: 1,
                            ),
                        ],
                      ),
                    ],
                  ),
                  NcSpacing.medium(),
                  CodeBook(ingredients: _ingredients, onDeleteIngredient: deleteIngredient),
                ],
              ),
            ),
          ),
          if (_filterMode)
            Filter(
              onClose: toggleFilterMode,
              onQuerry: filterIngredients,
              forceDesc: _forceFilterMode ? Home.newDesc : null,
              forceTags: _forceFilterMode ? Home.newTags : null,
              forceLangugae: _forceFilterMode ? Home.newLanguage : null,
            )
        ],
      ),
      backgroundColor: NcThemes.current.secondaryColor,
      floatingActionButton: FloatingActionButton.small(
        onPressed: addIngredient,
        child: Icon(
          Icons.add,
          color: NcThemes.current.tertiaryColor,
        ),
        backgroundColor: NcThemes.current.accentColor,
      ),
    );
  }

  filterIngredients(String desc, List<String> tags, String? language) {
    _currentFilterDesc = desc;
    _currentFilterTags = tags;
    _currentFilterLanguage = language;
    setState(() {
      _ingredients = DB.ingredients.where((ingredient) => ingredient.desc.toLowerCase().contains(desc.toLowerCase()) && (language == null || ingredient.language == language) && ingredient.tags.toSet().containsAll(tags.toSet())).toList();
    });
  }

  addIngredient() {
    DB.addIngredient(Ingredient(language: Home.newLanguage, code: Home.newCode, tags: Home.newTags, desc: Home.newDesc));
    filterIngredients(Home.newDesc, Home.newTags, Home.newLanguage);
    setState(() {
      _forceFilterMode = true;
      _filterMode = true;
    });
  }

  deleteIngredient(BuildContext context, Ingredient value) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: NcTitleText("U sure? - DONT PRESS THE DELETE BUTTON AGAIN AFTER YOU CONFIRM"),
        content: NcBodyText(
          '''
            U sure you wanna delete this? Missclick?

            DONT PRESS THE DELETE BUTTON AGAIN AFTER YOU CONFIRM - YOU WILL DELETE OTHER CODE BLOCKS

            READ FOR MORE INFO:
            You might have to switch to the formatted manually in order to make the ui update...
            Flutter seeems to have some mental issues so it wont fckn update the ui and im loosing my mind rn.
            Oh and dont worry if a different code block dissapears it will come back after you switch to the formatted view!
            ''',
        ),
        backgroundColor: NcThemes.current.primaryColor,
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              DB.rmIngredient(value);
              if (_filterMode) {
                filterIngredients(_currentFilterDesc, _currentFilterTags, _currentFilterLanguage);
              } else {
                setState(() {
                  _ingredients = DB.ingredients;
                });
              }
              widget.refresh();
            },
            child: NcCaptionText("Ye"),
          ),
          TextButton(onPressed: () => Navigator.of(context).pop(), child: NcCaptionText("Missclick"))
        ],
      ),
    );
  }
}

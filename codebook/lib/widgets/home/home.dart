import 'package:animations/animations.dart';
import 'package:codebook/db/db.dart';
import 'package:codebook/db/ingredient.dart';
import 'package:codebook/widgets/home/filter/filter.dart';
import 'package:codebook/widgets/codebook/codebook.dart';
import 'package:codebook/widgets/settings/settings.dart';
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
  var _settings = false;
  String? _currentFilterLanguage;

  toggleSettings() {
    setState(() {
      _settings = !_settings;
    });
  }

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
                        !_settings ? "CodeBook" : "Settings",
                        fontSize: CodeBook.titleSize,
                      ),
                      AnimatedSize(
                        duration: Filter.animationDuration,
                        curve: Filter.animationCurve,
                        child: Row(
                          children: [
                            if (!_settings)
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
                            if (!_settings)
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
                              onPressed: toggleSettings,
                              icon: Icon(
                                _settings ? Icons.close : Icons.settings,
                                color: NcThemes.current.tertiaryColor,
                                size: Home.iconSize,
                              ),
                              splashColor: Colors.transparent,
                              splashRadius: 1,
                            ),
                            if (!_filterMode && !_settings)
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
                      ),
                    ],
                  ),
                  NcSpacing.medium(),
                  Expanded(
                    child: PageTransitionSwitcher(
                      // duration: Duration(seconds: 2),
                      transitionBuilder: (child, animationIn, animationOut) => FadeThroughTransition(
                        fillColor: NcThemes.current.secondaryColor,
                        animation: animationIn,
                        secondaryAnimation: animationOut,
                        child: child,
                      ),
                      child: _settings ? const SettingsPage() : CodeBook(ingredients: _ingredients, onDeleteIngredient: deleteIngredient),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Filter(
            onClose: toggleFilterMode,
            onQuerry: filterIngredients,
            forceDesc: _forceFilterMode ? Home.newDesc : null,
            forceTags: _forceFilterMode ? Home.newTags : null,
            forceLangugae: _forceFilterMode ? Home.newLanguage : null,
            active: _filterMode && !_settings,
          )
        ],
      ),
      backgroundColor: NcThemes.current.secondaryColor,
      floatingActionButton: !_settings
          ? FloatingActionButton.small(
              onPressed: addIngredient,
              child: Icon(
                Icons.add,
                color: NcThemes.current.buttonTextColor,
              ),
              backgroundColor: NcThemes.current.accentColor,
            )
          : null,
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
    DB.rmIngredient(value);
    if (_filterMode) {
      filterIngredients(_currentFilterDesc, _currentFilterTags, _currentFilterLanguage);
    } else {
      setState(() {
        _ingredients = DB.ingredients;
      });
    }
    // Dont ask why it workds so i wont touch it
    setState(() {});
    widget.refresh();
  }
}

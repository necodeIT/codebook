import 'package:animations/animations.dart';
import 'package:codebook/db/db.dart';
import 'package:codebook/db/ingredient.dart';
import 'package:codebook/widgets/home/filter/filter.dart';
import 'package:codebook/widgets/codebook/codebook.dart';
import 'package:codebook/widgets/home/in_out_dialog/in_out_dialog.dart';
import 'package:codebook/widgets/settings/settings.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:nekolib.ui/ui.dart';

class Home extends StatefulWidget {
  const Home({Key? key, required this.refresh}) : super(key: key);

  final Function() refresh;

  static const double iconSize = CodeBook.titleSize * .8;
  static const newLanguage = "python";
  static const newCode = 'print("Hello World")';
  static const newDesc = "New Ingredient";
  static const importTitle = "Import Ingredients";
  static const exportTitle = "Export Ingredients";
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
                                onPressed: () => exportIngredients(context),
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
                                onPressed: () => importIngredients(context),
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
            forceDesc: _forceFilterMode ? "" : null,
            forceTags: _forceFilterMode ? Home.newTags : null,
            forceLangugae: null,
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

  /// Shows a dialog to import ingredients from a file.
  importIngredients(BuildContext context) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      dialogTitle: Home.importTitle,
      allowedExtensions: ["json"],
      type: FileType.custom,
    );

    if (result == null) return;

    showDialog(
      context: context,
      builder: (context) => InOutDialog.import(
        data: result,
        onSubmit: (data) {
          DB.import(data);
          refresh();
          _showFeedback(context: context, data: data);
        },
      ),
    );
  }

  /// Shows a feedback snackbar.
  _showFeedback({required BuildContext context, bool importMode = true, List<Ingredient>? data, Object? error}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: NcBodyText(error != null ? "Error ${importMode ? "importing" : "exporting"} ingredients: ${error.toString()}" : "Sucessfully ${importMode ? "imported" : "exported"} ${data!.length} ingredient${data.length == 1 ? "" : "s"}"),
        backgroundColor: NcThemes.current.tertiaryColor,
      ),
    );
  }

  /// Shows a dialog to export ingredients to a file.
  exportIngredients(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => InOutDialog.export(
        onSubmit: (data) async {
          var path = await FilePicker.platform.saveFile(
            fileName: "catgirl",
            dialogTitle: Home.exportTitle,
            allowedExtensions: ["json"],
            type: FileType.custom,
          );

          if (path == null) return;

          try {
            DB.export(path, data);
            _showFeedback(context: context, importMode: false, data: data);
          } catch (e) {
            _showFeedback(context: context, error: e);
          }
        },
      ),
    );
  }

  /// Filters the database by the given [desc], [tags] and [language].
  filterIngredients(String desc, List<String> tags, String? language) {
    _currentFilterDesc = desc;
    _currentFilterTags = tags;
    _currentFilterLanguage = language;
    setState(() {
      _ingredients = DB.ingredients.where((ingredient) => ingredient.desc.toLowerCase().contains(desc.toLowerCase()) && (language == null || ingredient.language == language) && ingredient.tags.toSet().containsAll(tags.toSet())).toList();
    });
  }

  /// Adds a new ingredient to the database.
  addIngredient() {
    DB.addIngredient(Ingredient(language: Home.newLanguage, code: Home.newCode, tags: Home.newTags, desc: Home.newDesc));
    filterIngredients("", Home.newTags, null);
    setState(() {
      _forceFilterMode = true;
      _filterMode = true;
    });
  }

  /// Refreshes the view and makes a new query to the database.
  refresh() {
    if (_filterMode) {
      filterIngredients(_currentFilterDesc, _currentFilterTags, _currentFilterLanguage);
    } else {
      setState(() {
        _ingredients = DB.ingredients;
      });
    }
  }

  /// Deletes the given [value] from the database.+
  deleteIngredient(BuildContext context, Ingredient value) {
    DB.rmIngredient(value);
    refresh();
    // Dont ask why it workds so i wont touch it
    setState(() {});
    widget.refresh();
  }
}

import 'dart:async';
import 'package:codebook/db/db.dart';
import 'package:codebook/db/ingredient.dart';
import 'package:codebook/widgets/home/in_out_dialog/body.dart';
import 'package:codebook/widgets/home/in_out_dialog/code_preview.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:nekolib_ui/core.dart';

class InOutDialog extends StatefulWidget {
  InOutDialog.export({Key? key, required this.onSubmit}) : super(key: key) {
    import = false;
    data = const FilePickerResult([]);
  }
  InOutDialog.import({Key? key, required this.data, required this.onSubmit}) : super(key: key) {
    import = true;
  }

  late final bool import;
  late final FilePickerResult data;
  final Function(List<Ingredient>) onSubmit;

  static const double iconSize = 50;

  @override
  _InOutDialogState createState() => _InOutDialogState();
}

class _InOutDialogState extends State<InOutDialog> {
  bool _importError = false;
  List<Ingredient> _selected = [];

  Future<List<Ingredient>> fetchImportData() async {
    var completer = Completer<List<Ingredient>>();
    try {
      var ingredients = await DB.extractIngredientsFromPath(widget.data.files.first.path!);
      completer.complete(ingredients);
    } catch (e) {
      if (!_importError) setState(() => _importError = true);

      completer.completeError(e);
    }
    return completer.future;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: NcThemes.current.secondaryColor,
      content: SizedBox(
        width: CodePreview.width * 2 + NcSpacing.mediumSpacing + 1,
        child: widget.import
            ? FutureBuilder(
                future: fetchImportData(),
                builder: (context, AsyncSnapshot<List<Ingredient>> snapshot) {
                  var loading = snapshot.connectionState != ConnectionState.done;
                  var done = !loading;
                  var error = snapshot.error != null;
                  return done && !error
                      ? InOutBody(
                          onSelectionChange: (selection) => _selected = selection,
                          ingredients: snapshot.data ?? [],
                          import: true,
                        )
                      : Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            NcSpacing.large(),
                            if (loading)
                              Center(
                                child: CircularProgressIndicator(
                                  color: NcThemes.current.accentColor,
                                ),
                              ),
                            if (done && error)
                              Center(
                                child: Icon(
                                  Icons.error_outline_outlined,
                                  color: NcThemes.current.errorColor,
                                  size: InOutDialog.iconSize,
                                ),
                              ),
                            NcSpacing.large(),
                            if (loading) NcBodyText("Loading Ingredients..."),
                            if (done && error) NcBodyText("Ooops... there was an error"),
                          ],
                        );
                },
              )
            : InOutBody(
                onSelectionChange: (selection) => _selected = selection,
                ingredients: DB.ingredients,
                import: false,
              ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: NcCaptionText(_importError ? "Ok" : "Cancel"),
        ),
        if (!_importError)
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              widget.onSubmit(_selected);
            },
            child: NcCaptionText(
              widget.import ? "Import" : "Export",
            ),
          )
      ],
    );
  }
}

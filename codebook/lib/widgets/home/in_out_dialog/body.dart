import 'package:codebook/db/ingredient.dart';
import 'package:codebook/widgets/home/home.dart';
import 'package:flutter/material.dart';
import 'package:nekolib.ui/ui.dart';

import 'code_preview.dart';

class InOutBody extends StatefulWidget {
  const InOutBody({Key? key, required this.onSelectionChange, required this.ingredients, required this.import}) : super(key: key);

  final Function(List<Ingredient>) onSelectionChange;
  final List<Ingredient> ingredients;
  final bool import;

  @override
  InOutBodyState createState() => InOutBodyState();
}

class InOutBodyState extends State<InOutBody> {
  List<Ingredient> _selected = List.empty(growable: true);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            NcCaptionText(widget.import ? Home.importTitle : Home.exportTitle),
            Row(
              children: [
                TextButton(
                  onPressed: selectAll,
                  child: Text(
                    "Select all",
                    style: TextStyle(color: NcThemes.current.accentColor, fontWeight: FontWeight.w600),
                  ),
                ),
                TextButton(
                  onPressed: selectNone,
                  child: Text(
                    "Select none",
                    style: TextStyle(color: NcThemes.current.accentColor, fontWeight: FontWeight.w600),
                  ),
                ),
              ],
            ),
          ],
        ),
        NcSpacing.medium(),
        Expanded(
          child: Center(
            child: SingleChildScrollView(
              controller: ScrollController(),
              child: Wrap(
                spacing: NcSpacing.mediumSpacing,
                runSpacing: NcSpacing.mediumSpacing,
                children: [
                  for (var data in widget.ingredients)
                    CodePreview(
                      onToggle: (value) => _updateSelection(value, data),
                      checkDuplicate: widget.import,
                      data: data,
                      selected: _selected.contains(data),
                    ),
                ],
              ),
            ),
          ),
        ),
        NcSpacing.small(),
      ],
    );
  }

  _updateSelection(bool selected, Ingredient data) {
    if (selected && !_selected.contains(data)) _selected.add(data);

    if (!selected && _selected.contains(data)) _selected.remove(data);
    refresh();
  }

  refresh() {
    setState(() {
      widget.onSelectionChange(_selected);
    });
  }

  selectAll() {
    _selected = List.from(widget.ingredients, growable: true);
    refresh();
  }

  selectNone() {
    _selected = List.empty(growable: true);
    refresh();
  }
}

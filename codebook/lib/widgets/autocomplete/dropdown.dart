import 'package:codebook/widgets/autocomplete/button.dart';
import 'package:flutter/material.dart';
import 'package:nekolib_ui/core.dart';

class AutoCompleteDropdown extends StatelessWidget {
  const AutoCompleteDropdown({Key? key, required this.options, required this.insert}) : super(key: key);

  static Widget builder(BuildContext context, void Function(String) insert, Iterable<String> options) => AutoCompleteDropdown(options: options.toList(), insert: insert);

  final List<String> options;
  final void Function(String) insert;

  static const double borderRadius = 10;
  static const double padding = 10;

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(borderRadius),
      color: NcThemes.current.primaryColor,
      child: Padding(
        padding: const EdgeInsets.all(padding),
        child: ListView(
          children: [for (var option in options) AutoCompleteDropdownButton(option: option, onTap: () => insert(option))],
        ),
      ),
    );
  }
}

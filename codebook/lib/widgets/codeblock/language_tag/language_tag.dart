import 'package:codebook/supported_languages.dart';
import 'package:codebook/widgets/autocomplete/button.dart';
import 'package:codebook/widgets/autocomplete/dropdown.dart';
import 'package:flutter/material.dart';

import 'language_input.dart';

class LanguageTag extends StatelessWidget {
  LanguageTag({Key? key, this.editMode = false, required this.initialValue, this.onValueChange}) : super(key: key);

  final bool editMode;
  final String initialValue;
  final Function(String)? onValueChange;

  @override
  Widget build(BuildContext context) {
    return Autocomplete<String>(
      initialValue: TextEditingValue(text: initialValue),
      optionsBuilder: (value) => value.text.isEmpty ? const Iterable<String>.empty() : kSupportedLanguages.where((lan) => lan.contains(value.text)),
      fieldViewBuilder: (context, controller, focus, _) => LanguageInput(
        controller: controller,
        focus: focus,
        disabled: !editMode,
        onValueChange: onValueChange,
      ),
      onSelected: onValueChange,
      optionsViewBuilder: AutoCompleteDropdown.builder,
    );
  }
}

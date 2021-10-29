import 'package:flutter/material.dart';

import '../../supported_languages.dart';
import 'language_input.dart';

class LanguageTag extends StatelessWidget {
  const LanguageTag({Key? key, this.editMode = false, required this.initialValue, this.onValueChange}) : super(key: key);

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
    );
  }
}

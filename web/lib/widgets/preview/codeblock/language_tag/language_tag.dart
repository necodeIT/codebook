import 'package:flutter/material.dart';

import 'language_input.dart';

class LanguageTag extends StatelessWidget {
  const LanguageTag({Key? key, required this.initialValue}) : super(key: key);

  final String initialValue;

  @override
  Widget build(BuildContext context) {
    return Autocomplete<String>(
      initialValue: TextEditingValue(text: initialValue),
      optionsBuilder: (value) => [],
      fieldViewBuilder: (context, controller, focus, _) => LanguageInput(
        controller: controller,
        focus: focus,
        disabled: true,
      ),
    );
  }
}

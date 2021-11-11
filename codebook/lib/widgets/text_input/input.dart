import 'dart:ui';

import 'package:codebook/widgets/codeblock/language_tag/language_input.dart';
import 'package:flutter/material.dart';
import 'package:nekolib.ui/ui/themes/themes.dart';

class TextInput extends StatefulWidget {
  const TextInput({Key? key, this.inintialText, this.onChange, this.onSubmit, this.controller, required this.label}) : super(key: key);

  final String? inintialText;
  final String label;
  final Function(String)? onChange;
  final Function(String)? onSubmit;
  final TextEditingController? controller;

  static InputBorder border({Color? color}) => OutlineInputBorder(
        borderSide: BorderSide(color: color ?? NcThemes.current.accentColor),
        borderRadius: BorderRadius.circular(LanguageInput.borderRadius),
      );

  @override
  _TextInputState createState() => _TextInputState();
}

class _TextInputState extends State<TextInput> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? TextEditingController(text: widget.inintialText);
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _controller,
      onChanged: widget.onChange,
      onSubmitted: widget.onSubmit,
      style: TextStyle(color: NcThemes.current.textColor),
      keyboardType: TextInputType.multiline,
      maxLines: null,
      cursorColor: NcThemes.current.accentColor,
      decoration: InputDecoration(
        border: TextInput.border(),
        labelText: widget.label,
        labelStyle: TextStyle(color: NcThemes.current.accentColor, fontSize: 20),
        focusedBorder: TextInput.border(),
        enabledBorder: TextInput.border(),
        errorBorder: TextInput.border(color: NcThemes.current.errorColor),
        disabledBorder: TextInput.border(color: NcThemes.current.tertiaryColor),
        focusedErrorBorder: TextInput.border(color: NcThemes.current.errorColor),
      ),
    );
  }
}

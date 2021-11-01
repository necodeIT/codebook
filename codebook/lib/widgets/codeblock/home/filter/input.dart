import 'package:flutter/material.dart';
import 'package:nekolib.ui/ui.dart';

class FilterInput extends StatelessWidget {
  const FilterInput({Key? key, required this.onChanged, this.placeholder}) : super(key: key);

  final Function(String) onChanged;
  final String? placeholder;

  static InputBorder border({Color? color}) => UnderlineInputBorder(borderSide: BorderSide(color: color ?? NcThemes.current.accentColor));

  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: onChanged,
      cursorColor: NcThemes.current.accentColor,
      style: TextStyle(color: NcThemes.current.textColor),
      decoration: InputDecoration(
        hintText: placeholder,
        hintStyle: TextStyle(color: NcThemes.current.textColor),
        border: border(),
        enabledBorder: border(color: NcThemes.current.tertiaryColor),
        focusedBorder: border(),
        suffixIcon: Icon(
          Icons.search,
          color: NcThemes.current.accentColor,
        ),
      ),
    );
  }
}

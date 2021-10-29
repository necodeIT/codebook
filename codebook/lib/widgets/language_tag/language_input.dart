import 'package:flutter/material.dart';
import 'package:nekolib.ui/ui.dart';

class LanguageInput extends StatelessWidget {
  const LanguageInput({Key? key, required this.controller, required this.focus, this.disabled = false}) : super(key: key);

  final TextEditingController controller;
  final FocusNode focus;
  final bool disabled;

  InputBorder get border => OutlineInputBorder(
      borderSide: BorderSide(
        color: NcThemes.current.accentColor,
      ),
      borderRadius: BorderRadius.circular(borderRadius));

  static const double backgroundOpacity = .2;
  static const double borderRadius = 5;
  static const double fontSize = 15;
  static const double elevation = 3;
  static const EdgeInsets padding = EdgeInsets.fromLTRB(10, 10, 7, 10);

  @override
  Widget build(BuildContext context) {
    return disabled
        ? buildField()
        : Material(
            elevation: elevation,
            child: buildField(),
            borderRadius: BorderRadius.circular(borderRadius),
          );
  }

  Widget buildField() {
    return IntrinsicWidth(
      child: TextField(
        enabled: !disabled,
        textAlign: TextAlign.center,
        textAlignVertical: TextAlignVertical.center,
        expands: false,
        autocorrect: false,
        style: NcBaseText.style().copyWith(
          fontSize: fontSize,
          color: NcThemes.current.accentColor,
        ),
        controller: controller,
        focusNode: focus,
        cursorColor: NcThemes.current.accentColor,
        decoration: disabled
            ? InputDecoration(
                contentPadding: padding,
                fillColor: NcThemes.current.accentColor.withOpacity(backgroundOpacity),
                filled: true,
                isDense: true,
                focusColor: Colors.transparent,
                hoverColor: Colors.transparent,
                border: border,
                focusedBorder: border,
                enabledBorder: border,
                disabledBorder: border,
              )
            : InputDecoration(
                contentPadding: padding,
                fillColor: NcThemes.current.primaryColor,
                filled: true,
                isDense: true,
                focusColor: Colors.transparent,
                hoverColor: Colors.transparent,
                border: border,
                focusedBorder: border,
                enabledBorder: border,
                disabledBorder: border,
              ),
      ),
    );
  }
}

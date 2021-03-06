import 'package:codebook/widgets/codeblock/language_tag/language_input.dart';
import 'package:codebook/widgets/codeblock/tag/tag.dart';
import 'package:flutter/material.dart';
import 'package:nekolib_ui/core.dart';

class TagInput extends StatelessWidget {
  const TagInput({Key? key, required this.controller, required this.focus, this.onValueChange, this.onSubmit}) : super(key: key);

  final TextEditingController controller;
  final FocusNode focus;
  final Function(String)? onValueChange;
  final Function(String)? onSubmit;

  InputBorder get border => OutlineInputBorder(
      borderSide: BorderSide(
        color: NcThemes.current.accentColor,
      ),
      borderRadius: BorderRadius.circular(borderRadius));

  static const double backgroundOpacity = LanguageInput.backgroundOpacity;
  static const double borderRadius = Tag.defaultBorderRadius;
  static const double fontSize = 15;
  static const double elevation = LanguageInput.elevation;
  static const EdgeInsets padding = EdgeInsets.fromLTRB(10, 10, 7, 10);

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: elevation,
      child: buildField(),
      borderRadius: BorderRadius.circular(borderRadius),
    );
  }

  Widget buildField() {
    return IntrinsicWidth(
      child: TextField(
        onSubmitted: onSubmit,
        onChanged: onValueChange,
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
        // decoration: disabled
        //     ? InputDecoration(
        //         contentPadding: padding,
        //         fillColor: NcThemes.current.accentColor.withOpacity(backgroundOpacity),
        //         filled: true,
        //         isDense: true,
        //         focusColor: Colors.transparent,
        //         hoverColor: Colors.transparent,
        //         border: border,
        //         focusedBorder: border,
        //         enabledBorder: border,
        //         disabledBorder: border,
        //       )
        decoration: InputDecoration(
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

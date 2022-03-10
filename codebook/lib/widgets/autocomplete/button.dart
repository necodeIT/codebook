import 'package:flutter/material.dart';
import 'package:nekolib_ui/core.dart';

class AutoCompleteDropdownButton extends StatelessWidget {
  const AutoCompleteDropdownButton({Key? key, required this.option, required this.onTap}) : super(key: key);

  final String option;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: NcBodyText(option),
      focusColor: NcThemes.current.primaryColor,
      hoverColor: NcThemes.current.tertiaryColor,
      splashColor: NcThemes.current.tertiaryColor,
    );
  }
}

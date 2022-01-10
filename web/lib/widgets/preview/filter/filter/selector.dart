import 'package:flutter/material.dart';
import 'package:nekolib.ui/ui.dart';
import 'package:web/widgets/preview/codeblock/tag/tag.dart';

class FilterSelect extends StatelessWidget {
  const FilterSelect({Key? key, required this.selected, required this.label, this.radio = false}) : super(key: key);

  final bool selected;
  final String label;
  final bool radio;

  @override
  Widget build(BuildContext context) {
    return Tag.add(
      onTap: () {},
      label: label,
      icon: !radio && selected ? Icons.check : null,
      color: !selected ? NcThemes.current.tertiaryColor : NcThemes.current.accentColor,
    );
  }
}

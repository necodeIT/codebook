import 'package:flutter/material.dart';
import 'package:nekolib_ui/core.dart';
import 'package:codebook/widgets/codeblock/tag/tag.dart';

class FilterSelect extends StatelessWidget {
  const FilterSelect({Key? key, required this.selected, required this.label, this.radio = false, required this.onTap}) : super(key: key);

  final bool selected;
  final String label;
  final bool radio;
  final Function(String) onTap;

  @override
  Widget build(BuildContext context) {
    return Tag.add(
      onTap: () => onTap(label),
      label: label,
      icon: !radio && selected ? Icons.check : null,
      color: !selected ? NcThemes.current.tertiaryColor : NcThemes.current.accentColor,
    );
  }
}

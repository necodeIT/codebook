// ignore_for_file: prefer_const_constructors_in_immutables

import 'package:flutter/material.dart';
import 'package:nekolib.ui/ui.dart';
import 'package:web/widgets/preview/filter/filter/filter_header.dart';
import 'package:web/widgets/preview/filter/filter/input.dart';
import 'package:web/widgets/preview/filter/filter/selector.dart';
import 'package:web/widgets/preview/home_icon_button.dart';
import 'package:web/widgets/preview/themed_card.dart';

class Filter extends StatefulWidget {
  Filter({Key? key, required this.tags, required this.languages, required this.language}) : super(key: key);

  final Map<String, bool> tags;
  final List<String> languages;
  final String language;

  static const double elevation = ThemedCard.elevation;
  static const double width = 350;
  static const animationDuration = Duration(milliseconds: 500);
  static const animationCurve = Curves.easeOutExpo;

  @override
  State<Filter> createState() => _FilterState();
}

class _FilterState extends State<Filter> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: NcThemes.current.primaryColor,
        boxShadow: const [
          BoxShadow(
            color: Colors.black45,
            offset: Offset(0.0, 1),
            blurRadius: Filter.elevation,
          ),
        ],
      ),
      height: double.infinity,
      width: Filter.width,
      padding: const EdgeInsets.symmetric(horizontal: NcSpacing.largeSpacing, vertical: NcSpacing.smallSpacing),
      child: ListView(
        controller: ScrollController(),
        children: [
          Container(
            alignment: Alignment.centerRight,
            width: double.infinity,
            child: HomeIconButton(
              icon: Icons.close,
            ),
          ),
          FilterInput(placeholder: "Search"),
          NcSpacing.large(),
          NcSpacing.large(),
          FilterHeader(active: true, title: "Tags"),
          Wrap(
            spacing: NcSpacing.smallSpacing,
            runSpacing: NcSpacing.smallSpacing,
            children: [
              for (var tag in widget.tags.keys)
                FilterSelect(
                  label: tag,
                  selected: widget.tags[tag]!,
                )
            ],
          ),
          NcSpacing.large(),
          NcSpacing.large(),
          FilterHeader(active: true, title: "Language"),
          Wrap(
            spacing: NcSpacing.smallSpacing,
            runSpacing: NcSpacing.smallSpacing,
            children: [
              for (var language in widget.languages)
                FilterSelect(
                  selected: language == widget.language,
                  label: language,
                  radio: true,
                ),
            ],
          ),
        ],
      ),
    );
  }
}

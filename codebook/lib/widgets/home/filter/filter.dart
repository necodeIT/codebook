import 'package:codebook/db/db.dart';
import 'package:codebook/widgets/home/filter/filter_header.dart';
import 'package:codebook/widgets/home/filter/input.dart';
import 'package:codebook/widgets/home/filter/selector.dart';
import 'package:codebook/widgets/home/home_icon_button.dart';
import 'package:codebook/widgets/themed_card.dart';
import 'package:flutter/material.dart';
import 'package:nekolib_ui/core.dart';

class Filter extends StatefulWidget {
  const Filter({Key? key, required this.onClose, required this.onQuerry, this.forceTags, this.forceLangugae, this.forceDesc, required this.active}) : super(key: key);

  final Function(String, List<String>, String?) onQuerry;
  final Function() onClose;
  final List<String>? forceTags;
  final String? forceLangugae;
  final String? forceDesc;
  final bool active;

  static const double elevation = ThemedCard.elevation;
  static const double width = 500;
  static const animationDuration = Duration(milliseconds: 500);
  static const animationCurve = Curves.easeOutExpo;

  @override
  State<Filter> createState() => _FilterState();
}

class _FilterState extends State<Filter> {
  String _search = "";
  String? _langugae;
  List<String> _tags = [];

  updateSearch(String value) {
    _search = value;
    querry();
  }

  updateLanguage(String? value) {
    setState(() {
      _langugae = value;
    });
    querry();
  }

  addTag(String tag) {
    if (_tags.contains(tag)) return;

    setState(() {
      _tags.add(tag);
    });

    querry();
  }

  clearTags(bool? enabled) {
    if (enabled ?? true) return;

    setState(() {
      _tags.clear();
    });

    querry();
  }

  clearLanguage(bool? enabled) {
    if (enabled ?? true) return;

    updateLanguage(null);
  }

  toggleTag(String tag) {
    if (_tags.contains(tag)) return rmTag(tag);

    addTag(tag);
  }

  rmTag(String tag) {
    if (!_tags.contains(tag)) return;

    setState(() {
      _tags.remove(tag);
    });

    querry();
  }

  querry() => widget.onQuerry(_search, _tags, _langugae);

  @override
  Widget build(BuildContext context) {
    _search = widget.active ? widget.forceDesc ?? _search : "";
    _langugae = widget.active ? widget.forceLangugae ?? _langugae : null;
    _tags = widget.active ? widget.forceTags ?? _tags : [];
    return AnimatedContainer(
      duration: Filter.animationDuration,
      curve: Filter.animationCurve,
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
      width: widget.active ? Filter.width : 0,
      padding: widget.active ? const EdgeInsets.symmetric(horizontal: NcSpacing.largeSpacing, vertical: NcSpacing.smallSpacing) : EdgeInsets.zero,
      child: widget.active
          ? ListView(
              controller: ScrollController(),
              children: [
                Container(
                  alignment: Alignment.centerRight,
                  width: double.infinity,
                  child: HomeIconButton(
                    tooltip: "Close",
                    onPressed: widget.onClose,
                    icon: Icons.close,
                  ),
                ),
                FilterInput(placeholder: "Search", onChanged: updateSearch),
                NcSpacing.large(),
                NcSpacing.large(),
                FilterHeader(active: _tags.isNotEmpty, title: "Tags", onToggle: clearTags),
                Wrap(
                  spacing: NcSpacing.smallSpacing,
                  runSpacing: NcSpacing.smallSpacing,
                  children: [
                    for (var tag in DB.tags)
                      FilterSelect(
                        label: tag,
                        selected: _tags.contains(tag),
                        onTap: toggleTag,
                      )
                  ],
                ),
                NcSpacing.large(),
                NcSpacing.large(),
                FilterHeader(active: _langugae != null, title: "Language", onToggle: clearLanguage),
                Wrap(
                  spacing: NcSpacing.smallSpacing,
                  runSpacing: NcSpacing.smallSpacing,
                  children: [
                    for (var language in DB.lanugages)
                      FilterSelect(
                        selected: language == _langugae,
                        label: language,
                        onTap: updateLanguage,
                        radio: true,
                      ),
                  ],
                ),
              ],
            )
          : null,
    );
  }
}

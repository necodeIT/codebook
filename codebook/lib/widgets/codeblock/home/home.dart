import 'package:codebook/widgets/codeblock/home/filter.dart';
import 'package:codebook/widgets/codebook/codebook.dart';
import 'package:flutter/material.dart';
import 'package:nekolib.ui/ui.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  static const double iconSize = CodeBook.titleSize * .8;

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool _filterMode = false;

  toggleFilterMode() {
    setState(() {
      _filterMode = !_filterMode;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: NcSpacing.largeSpacing),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    NcTitleText(
                      "CodeBook",
                      fontSize: CodeBook.titleSize,
                    ),
                    Row(
                      children: [
                        IconButton(
                          onPressed: () {},
                          icon: Icon(
                            Icons.upload,
                            color: NcThemes.current.tertiaryColor,
                            size: Home.iconSize,
                          ),
                          splashColor: Colors.transparent,
                          splashRadius: 1,
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: Icon(
                            Icons.download,
                            color: NcThemes.current.tertiaryColor,
                            size: Home.iconSize,
                          ),
                          splashColor: Colors.transparent,
                          splashRadius: 1,
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: Icon(
                            Icons.settings,
                            color: NcThemes.current.tertiaryColor,
                            size: Home.iconSize,
                          ),
                          splashColor: Colors.transparent,
                          splashRadius: 1,
                        ),
                        if (!_filterMode)
                          IconButton(
                            onPressed: toggleFilterMode,
                            icon: Icon(
                              Icons.filter_alt_sharp,
                              color: NcThemes.current.tertiaryColor,
                              size: Home.iconSize,
                            ),
                            splashColor: Colors.transparent,
                            splashRadius: 1,
                          ),
                      ],
                    ),
                  ],
                ),
                NcSpacing.medium(),
                const CodeBook(),
              ],
            ),
          ),
        ),
        if (_filterMode) Filter(onClose: toggleFilterMode)
      ],
    );
  }
}

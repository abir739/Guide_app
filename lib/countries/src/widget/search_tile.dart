import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../model/country.dart';
import '../theme/dialog_theme.dart';
import '../provider/picker_provider.dart';

class SearchTile extends StatelessWidget {
  const SearchTile({
    super.key,
    required this.dialogTheme,
    required this.controller,
    required this.elements,
  });

  final DialogThemeData dialogTheme;
  final TextEditingController controller;
  final List<Country> elements;

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Container(
          color: dialogTheme.tilesTheme.backgroundColor ??
              Theme.of(context).focusColor,
          alignment: (Directionality.of(context) == TextDirection.ltr)
              ? Alignment.centerLeft
              : Alignment.centerRight,
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          width: double.infinity,
          height: dialogTheme.tileHeight,
          child: Text(
            dialogTheme.tilesTheme.searchTitle,
            style: dialogTheme.tilesTheme.style.copyWith(
                fontSize: dialogTheme.tilesTheme.style.fontSize ?? 16),
          )),
      Container(
        color: dialogTheme.backgroundColor,
        height: dialogTheme.tileHeight,
        child: TextField(
          textInputAction: TextInputAction.search,
          style: dialogTheme.style
              .copyWith(fontSize: dialogTheme.style.fontSize ?? 16),
          controller: controller,
          decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding:
                  const EdgeInsets.only(left: 15, bottom: 0, top: 0, right: 15),
              hintText: dialogTheme.tilesTheme.searchHint,
              hintStyle: dialogTheme.tilesTheme.searchHintStyle),
          onChanged: ((value) {
            String s = value.toUpperCase();

            context.read<SettingsProvider>().countries = elements
                .where((e) =>
                    e.dialing_code.contains(s) ||
                    e.name.common.toUpperCase().startsWith(s))
                .toList();
          }),
        ),
      ),
    ]);
  }
}

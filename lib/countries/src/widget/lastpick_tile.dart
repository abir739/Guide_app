import 'package:flutter/material.dart';
import '../model/country.dart';
import '../theme/dialog_theme.dart';
import '../model/languages.dart';
import '../model/names.dart';

class LastPickTile extends StatelessWidget {
  final DialogThemeData dialogTheme;
  final Country country;
  final Languages language;
  final Names displayName;
  const LastPickTile({
    super.key,
    required this.dialogTheme,
    required this.country,
    required this.language,
    this.displayName = Names.common,
  });

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
            dialogTheme.tilesTheme.lastPickTitle,
            style: dialogTheme.tilesTheme.style.copyWith(
                fontSize: dialogTheme.tilesTheme.style.fontSize ?? 16),
          )),
      SizedBox(
        height: dialogTheme.tileHeight,
        child: ListTile(
            leading: (dialogTheme.isShowFlag)
                ? Image.asset(
                    "assets/flags/${country.iso_3166_1_alpha2.toLowerCase()}.png",
                    package: 'country_list_picker',
                    width: dialogTheme.tileHeight * .8,
                  )
                : null,
            title: Text(
              (displayName == Names.common)
                  ? country.name.common
                  : country.name.official,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              softWrap: false,
              style: dialogTheme.style
                  .copyWith(fontSize: dialogTheme.style.fontSize ?? 16),
            ),
            trailing: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: (dialogTheme.isShowAlphabetsBar == false ||
                          language == Languages.Chinese ||
                          language == Languages.Korean ||
                          language == Languages.Japanese)
                      ? 0.0
                      : 20.0,
                ),
                child: Icon(
                  dialogTheme.tilesTheme.lastPickIcon.icon,
                  color: (dialogTheme.tilesTheme.lastPickIcon.color) ??
                      Theme.of(context).colorScheme.primary,
                  size: dialogTheme.tilesTheme.lastPickIcon.size ??
                      dialogTheme.tileHeight * .6,
                )),
            onTap: null),
      )
    ]);
  }
}

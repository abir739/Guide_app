import 'package:flutter/material.dart';
import '../model/country.dart';
import '../model/languages.dart';
import '../theme/dialog_theme.dart';
import '../model/names.dart';

class CountryListTile extends StatelessWidget {
  const CountryListTile({
    super.key,
    required this.country,
    required this.language,
    this.dialogTheme = const DialogThemeData(),
    this.displayName = Names.common,
  });

  final Country country;
  final Languages language;
  final DialogThemeData dialogTheme;
  final Names displayName;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
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
            displayName == Names.common
                ? country.name.common
                : country.name.official,
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
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
            child: (dialogTheme.isShowDialCode)
                ? Text(country.dialing_code,
                    textDirection: TextDirection.ltr,
                    style: dialogTheme.style
                        .copyWith(fontSize: dialogTheme.style.fontSize ?? 16))
                : null,
          ),
          onTap: () {
            Navigator.pop(context, country);
          }),
    );
  }
}

import 'package:flutter/material.dart';
import './tiles_theme_data.dart';
import './alphabets_bar_themes.dart';
export './tiles_theme_data.dart';
export './alphabets_bar_themes.dart';

class DialogThemeData {
  ///An app bar to display at the top of country list dialog.
  final PreferredSizeWidget? appBar;

  /// [isShowFloatButton] is a [bool] variable that determines whether or not to display the float button.
  /// If set to true, the float button will be shown, and if set to false, the float button will be hidden.
  /// This variable is declared as final, indicating that it can't be reassigned after being initialized.
  final bool isShowFloatButton;

  /// [isShowDialCode] is a [bool] variable that determines whether or not to display dial codes.
  /// If set to true, dial codes will be shown, and if set to false, dial codes will be hidden.
  /// This variable is declared as final, indicating that it can't be reassigned after being initialized.
  final bool isShowDialCode;

  /// [isShowFlag] is a [bool] variable that determines whether or not to display flags.
  /// If set to true, flags will be shown, and if set to false, flags will be hidden.
  /// This variable is declared as final, indicating that it can't be reassigned after being initialized.
  final bool isShowFlag;

  /// [isShowSearchTile] is a [bool] variable that determines whether or not to display the search tile.
  /// If set to true, the search tile will be shown, and if set to false, the search tile will be hidden.
  /// This variable is declared as final, indicating that it can't be reassigned after being initialized.
  final bool isShowSearchTile;

  /// [isShowLastPickTile] is a [bool] variable that determines whether or not to display the last pick tile.
  /// If set to true, the last pick will be shown, and if set to false, the last pick will be hidden.
  /// This variable is declared as final, indicating that it can't be reassigned after being initialized.
  final bool isShowLastPickTile;

  /// [isShowAlphabetsBar] is a [bool] variable that determines whether or not to display the alphabet bar.
  /// If set to true, the alphabet bar will be shown, and if set to false, the alphabet bar will be hidden.
  /// This variable is declared as final, indicating that it can't be reassigned after being initialized.
  final bool isShowAlphabetsBar;

  /// Country dialog background color.
  final Color? backgroundColor;

  /// Country text style.
  final TextStyle style;

  /// Height of the tile.
  /// [tileHeight] must be greater than 50.0
  final double tileHeight;

  /// Theme data of dialog tiles.
  final TilesThemeData tilesTheme;

  ///Alphabets bar Theme.
  ///
  ///Example:
  ///```dart
  /// dialogTheme: const CountryListDialogTheme(
  ///   alphabetsBar: AlphabetsBarThemes(
  ///     backgroundColor: Colors.transparent,
  ///     textStyle: TextStyle(color: Colors.black),
  ///     selectedBackgroundColor: Colors.redAccent,
  ///     selectedTextStyle: TextStyle(color: Colors.white),
  ///   ),
  /// )
  ///```
  ///or to hide Alphabets bar
  ///```dart
  /// dialogTheme: const CountryListDialogTheme(
  ///   alphabetsBar: AlphabetsBarThemes(visible: false),)
  ///```
  final AlphabetsBarThemeData alphabetsBarTheme;

  const DialogThemeData({
    this.tilesTheme = const TilesThemeData(),
    this.alphabetsBarTheme = const AlphabetsBarThemeData(),
    this.isShowLastPickTile = true,
    this.isShowSearchTile = true,
    this.isShowAlphabetsBar = true,
    this.appBar,
    this.isShowFlag = true,
    this.isShowFloatButton = true,
    this.backgroundColor,
    this.isShowDialCode = true,
    this.style = const TextStyle(fontSize: 16),
    this.tileHeight = 50.0,
  }) : assert(tileHeight >= 50.0, "tileheight must be greater than 50.0");
}

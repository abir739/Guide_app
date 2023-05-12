import 'package:flutter/material.dart';

class TilesThemeData {
  /// Text style of tile title.
  final TextStyle style;

  /// Background color of tile title.
  final Color? backgroundColor;

  /// Text of search tile title.
  final String searchTitle;

  /// Text that suggests what sort of input the search field.
  final String searchHint;

  /// The style to use for the [searchHint].
  final TextStyle searchHintStyle;

  /// Text of last pick tile title.
  final String lastPickTitle;

  /// Icon  of last pick tile.
  final Icon lastPickIcon;

  /// Text of current location tile title.
  final String currentLocationTileTitle;

  const TilesThemeData({
    // General
    this.style = const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
    this.backgroundColor,

    // Search Tile
    this.searchTitle = "Search",
    this.searchHint = "name/dial code...",
    this.searchHintStyle =
        const TextStyle(fontSize: 16, color: Color(0xFF9E9E9E)),

    // Last Pick Tile
    this.lastPickTitle = "Last Pick",
    this.lastPickIcon = const Icon(Icons.check),

    // Current Location Tile
    this.currentLocationTileTitle = "Current Location",
  });
}

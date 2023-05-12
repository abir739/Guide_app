import 'package:flutter/material.dart';

class AlphabetsBarThemeData {
  /// Background of unselected alphabet.
  final Color backgroundColor;

  /// Background of selected alphabet.
  final Color selectedBackgroundColor;

  /// Text style of unselected alphabet.
  final TextStyle style;

  /// Text style of selected alphabet.
  final TextStyle selectedStyle;

  const AlphabetsBarThemeData({
    this.backgroundColor = Colors.transparent,
    this.selectedBackgroundColor = Colors.transparent,
    this.style = const TextStyle(fontSize: 12),
    this.selectedStyle =
        const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
  });
}

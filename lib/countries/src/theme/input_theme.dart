import 'package:flutter/material.dart';

class InputThemeData {
  final EdgeInsetsGeometry contentPadding;

  /// The shape of the border to be drawn around the [InputField] can be defined using the [border] variable.
  ///
  /// This variable can take on several different values including:
  ///
  /// [InputBorder.none], which means no border will be drawn.
  ///
  /// [UnderlineInputBorder], which draws a horizontal line at the bottom of the [InputField].
  ///
  /// [OutlineInputBorder], which results in a rounded rectangle being drawn around the [InputField].
  ///
  /// note that: if [border] property of the [inputTheme]is not equal [InputBorder.none], the [border] of [CountryListPicker] will be canceled.
  final InputBorder border;

  /// Text that suggests what sort of input the field accepts.
  final String? hintText;

  /// The style to use for the [hintText].
  final TextStyle hintStyle;

  /// The style to use for the input field contents.
  final TextStyle style;

  ///Character used for obscuring text if obscureText is true.
  ///Must be only a single character.
  final String obscuringCharacter;

  ///Whether to hide the text being edited.
  ///
  ///When this is set to true, all the characters in the text field are replaced by [obscuringCharacter],
  ///and the text in the field cannot be copied with copy or cut.
  final bool obscureText;

  ///Create the [mask] formatter for TextField
  ///
  ///The keys of the [filter] assign which character in the mask should be replaced and the values validate
  ///the entered character By default # match to the number.
  final String? mask;

  // final bool autoHint;
  // final bool autoMask;

  const InputThemeData({
    this.contentPadding = const EdgeInsets.only(left: 12),
    this.border = InputBorder.none,
    this.hintStyle = const TextStyle(fontSize: 16, color: Color(0xFF9E9E9E)),
    this.hintText, // = "Enter your phone number",
    this.style = const TextStyle(fontSize: 16),
    this.mask, // = "### #### ###",
    this.obscuringCharacter = '•',
    this.obscureText = false,
    // this.autoHint = true,
    // this.autoMask = true,
  });
}

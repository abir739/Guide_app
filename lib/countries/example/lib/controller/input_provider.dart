import 'package:flutter/material.dart';
import '../controller/settings_provider.dart';
import '../model/borders.dart';

class InputProvider extends ChangeNotifier {
  SettingsProvider _settings = SettingsProvider();

  void update(SettingsProvider settings) {
    _settings = settings;
    notifyListeners();
  }

// ****************************************************************************************************
  bool _isShowTextField = true;
  bool get isShowTextField => _isShowTextField;
  set isShowTextField(bool value) {
    _isShowTextField = value;
    notifyListeners();
  }

  TextStyle _textStyle =
      const TextStyle(fontWeight: FontWeight.normal, fontSize: 16);
  TextStyle get textStyle => _textStyle.copyWith(
      color: _textStyle.color ??
          (_settings.isDarkMode == true ? Colors.white : Colors.black));
  set textStyle(TextStyle value) {
    _textStyle = value;
    notifyListeners();
  }

  String _mask = "### #### ###";
  String get mask => _mask;
  set mask(String value) {
    _mask = value;

    notifyListeners();
  }

  bool _isObscureText = false;
  bool get isObscureText => _isObscureText;
  set isObscureText(bool value) {
    _isObscureText = value;
    notifyListeners();
  }

  String _obscuringCharacter = "*";
  String get obscuringCharacter => _obscuringCharacter;
  set obscuringCharacter(String value) {
    _obscuringCharacter = value;

    notifyListeners();
  }

// ****************************************************************************************************
  String _hintString = "Enter your phone number";
  String get hintString => _hintString;
  set hintString(String value) {
    _hintString = value;
    notifyListeners();
  }

  TextStyle _hintTextStyle =
      const TextStyle(fontWeight: FontWeight.normal, color: Colors.grey);
  TextStyle get hintTextStyle => _hintTextStyle;

  set hintTextStyle(TextStyle value) {
    _hintTextStyle = value;
    notifyListeners();
  }
// ****************************************************************************************************

  Borders _border = Borders.none;
  Borders get border => _border;
  set border(Borders value) {
    _border = value;
    notifyListeners();
  }

  double _borderWidth = 2;
  double get borderWidth => _borderWidth;
  set borderWidth(double value) {
    _borderWidth = value;
    notifyListeners();
  }
  // ****************************************************************************************************
}

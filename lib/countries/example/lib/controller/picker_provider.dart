import 'package:flutter/material.dart';
import 'package:country_list_picker/country_list_picker.dart';
import '../controller/settings_provider.dart';
import '../model/borders.dart';

class PickerProvider extends ChangeNotifier {
  SettingsProvider _settings = SettingsProvider();
  void update(SettingsProvider settings) {
    _settings = settings;
    notifyListeners();
  }

  bool _separated = false;
  bool get separated => _separated;
  set separated(bool value) {
    _separated = value;
    notifyListeners();
  }

  Languages _language = Languages.English;
  Languages get language => _language;
  set language(Languages value) {
    _language = value;
    notifyListeners();
  }

  TextDirection _textDirection = TextDirection.ltr;
  TextDirection get textDirection => _textDirection;
  set textDirection(TextDirection value) {
    _textDirection = value;
    notifyListeners();
  }

// ****************************************************************************************************
  bool _isShowFlag = true;
  bool get isShowFlag => _isShowFlag;
  set isShowFlag(bool value) {
    _isShowFlag = value;
    if (_isShowDialCode == false && value == false) isShowDialCode = true;
    notifyListeners();
  }

  Size _flagSize = const Size(40.0, 40.0);
  Size get flagSize => _flagSize;
  set flagSize(Size value) {
    _flagSize = value;
    notifyListeners();
  }

// ****************************************************************************************************
  bool _isShowDialCode = true;
  bool get isShowDialCode => _isShowDialCode;
  set isShowDialCode(bool value) {
    _isShowDialCode = value;
    if (_isShowFlag == false && value == false) isShowFlag = true;
    notifyListeners();
  }

  TextStyle _dialCodeTextStyle =
      const TextStyle(fontWeight: FontWeight.bold, fontSize: 16);
  TextStyle get dialCodeTextStyle => _dialCodeTextStyle.copyWith(
      color: _dialCodeTextStyle.color ??
          (_settings.isDarkMode == true ? Colors.white : Colors.black));
  set dialCodeTextStyle(TextStyle value) {
    _dialCodeTextStyle = value;
    notifyListeners();
  }

// ****************************************************************************************************
  bool _isDownIcon = true;
  bool get isDownIcon => _isDownIcon;
  set isDownIcon(bool value) {
    _isDownIcon = value;
    notifyListeners();
  }

// ****************************************************************************************************
  bool _isShowCountryName = true;
  bool get isShowCountryName => _isShowCountryName;
  set isShowCountryName(bool value) {
    _isShowCountryName = value;
    notifyListeners();
  }

  TextStyle _countryNameTextStyle = const TextStyle(
      fontWeight: FontWeight.normal, fontSize: 15, color: Colors.grey);

  TextStyle get countryNameTextStyle => _countryNameTextStyle;
  set countryNameTextStyle(TextStyle value) {
    _countryNameTextStyle = value;
    notifyListeners();
  }

// ****************************************************************************************************
  double _iconSize = 24;
  double get downIconSize => _iconSize;
  set downIconSize(double value) {
    _iconSize = value;
    notifyListeners();
  }

  Icon _downIcon = const Icon(Icons.keyboard_arrow_down, size: 24);
  Icon get downIcon => _downIcon;
  set downIcon(Icon value) {
    _downIcon = value;
    notifyListeners();
  }

// ****************************************************************************************************

  Borders _border = Borders.underline;
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

  //   Color? _borderColor; // =  const Colors.red;
  // Color get borderColor =>
  //     _borderColor ?? (_settings.isDarkMode == true ? darkprimarySwatch : lightprimarySwatch);
  // set borderColor(Color value) {
  //   _borderColor = value;
  //   notifyListeners();
  // }

}

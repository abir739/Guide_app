import 'package:flutter/material.dart';
import '../model/country.dart';

class SettingsProvider extends ChangeNotifier {
  SettingsProvider({required List<Country> elements}) {
    _countries = elements;
  }
  List<Country> _countries = [];
  List<Country> get countries => _countries;
  set countries(List<Country> value) {
    _countries = value;
    notifyListeners();
  }

  String? _selectedCharacter;
  String? get selectedCharacter => _selectedCharacter;
  set selectedCharacter(String? value) {
    if (_selectedCharacter != value) {
      _selectedCharacter = value;
      notifyListeners();
    }
  }

  bool _isShowFloatButton = false;
  bool get isShowFloatButton => _isShowFloatButton;
  set isShowFloatButton(bool value) {
    if (_isShowFloatButton != value) {
      _isShowFloatButton = value;
      notifyListeners();
    }
  }

  bool _inputOnFocus = false;
  bool get inputOnFocus => _inputOnFocus;
  set inputOnFocus(bool value) {
    if (_inputOnFocus != value) {
      _inputOnFocus = value;
      notifyListeners();
    }
  }
}

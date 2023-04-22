import 'package:flutter/material.dart';

class ThemeProvider with ChangeNotifier {
  ThemeMode _mode = ThemeMode.system;

  ThemeMode get mode => _mode;

  set mode(ThemeMode value) {
    _mode = value;
    notifyListeners();
  }
}

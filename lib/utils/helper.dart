

import 'package:flutter/material.dart';

import '../themes/colors.dart';

Color getLabelColor(Color color) {
  return color.computeLuminance() > 0.5 ? primary : white;
}

bool checkIsNullValue(dynamic value) {
  return [null, "null", 0, "0", ""].contains(value);
}

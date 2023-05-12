import 'package:flutter/material.dart';

class Argument {
  bool isExpanded;

  final String title;
  final Widget child;
  dynamic key;
  Argument({
    required this.title,
    required this.child,
    this.isExpanded = false,
  });
}

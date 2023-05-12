import 'package:flutter/material.dart';
import '../model/argument.dart';

export '../model/argument.dart';

class Screen {
  final String title;
  final IconData activeIcon;
  final IconData inactiveIcon;
  final List<Argument> arguments;
  final Widget? child;

  const Screen({
    required this.title,
    required this.activeIcon,
    required this.inactiveIcon,
    this.child,
    this.arguments = const [],
  });
}

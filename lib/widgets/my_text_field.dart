import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {
  final String label;
  final int maxLines;
  final int minLines;
  final Icon icon;
  const MyTextField({super.key, required this.label, this.maxLines = 1, this.minLines = 1, required this.icon});

  @override
  Widget build(BuildContext context) {
    return TextField(
      
      style: const TextStyle(color: Colors.black87),
      minLines: minLines,
      maxLines: maxLines,
      decoration: InputDecoration(
        suffixIcon: icon,
          labelText: label,
          labelStyle: const TextStyle(color: Colors.black45),
          
          focusedBorder:
              const UnderlineInputBorder(borderSide: BorderSide(color: Colors.black)),
          border:
              const UnderlineInputBorder(borderSide: BorderSide(color: Colors.grey))),
    );
  }
}
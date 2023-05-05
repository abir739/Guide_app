import 'package:flutter/material.dart';
import 'package:guide_app/themes/colors.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController? controller;
  final bool obscureText, readOnly, isDense;
  final Color? cursorColor;
  final TextInputType keyboardType;
  final TextInputAction textInputAction;
  final TextStyle? style;
  final int? maxLength, maxLines;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final String? hintText, labelText, errorText;
  final FocusNode? focusNode;
  final bool isError;
  final EdgeInsetsGeometry contentPadding;
  final String? Function(String?)? validator;
  final String? Function(String?)? onChange;
  final VoidCallback? onTap;
  final void Function(String?)? onSaved;
  final void Function(String?)? onSubmitted;
  final String? Function()? onEditingComplete;

  const CustomTextField({
    Key? key,
    this.controller,
    this.keyboardType = TextInputType.text,
    this.textInputAction = TextInputAction.done,
    this.style = const TextStyle(fontSize: 15),
    this.cursorColor = primary,
    this.obscureText = false,
    this.readOnly = false,
    this.isDense = true,
    this.maxLength,
    this.maxLines = 1,
    this.contentPadding = const EdgeInsets.only(left: 10),
    this.prefixIcon,
    this.suffixIcon,
    this.hintText,
    this.labelText,
    this.errorText,
    this.focusNode,
    this.isError = false,
    this.onTap,
    this.onSaved,
    this.onSubmitted,
    this.onEditingComplete,
    this.onChange,
    this.validator,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _buildTextField();
  }

  Widget _buildTextField() {
    return TextFormField(
      onTap: onTap,
      onSaved: onSaved,
      onEditingComplete: onEditingComplete,
      onFieldSubmitted: onSubmitted,
      onChanged: onChange,
      validator: validator,
      controller: controller,
      keyboardType: keyboardType,
      textInputAction: textInputAction,
      cursorColor: cursorColor,
      cursorHeight: 20,
      obscureText: obscureText,
      readOnly: readOnly,
      maxLength: maxLength,
      maxLines: maxLines,
      focusNode: focusNode,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        contentPadding: contentPadding,
        suffixIcon: suffixIcon,
        prefixIcon: prefixIcon,
        alignLabelWithHint: true,
        hintText: hintText,
        labelText: labelText,
        hintStyle: TextStyle(
            fontSize: 14, color: isError ? Colors.red : hintTextColor),
        labelStyle: TextStyle(
            fontSize: 14, color: isError ? Colors.red : hintTextColor),
        floatingLabelStyle: const TextStyle(fontSize: 12, color: primary),
        errorText: errorText,
        errorStyle: const TextStyle(color: Colors.red),
        disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: Colors.transparent, width: 1)),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: primary, width: 1)),
        errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: Colors.red, width: 1)),
        focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: Colors.red, width: 1)),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: lineBorderColor, width: 1)),
      ),
    );
  }
}

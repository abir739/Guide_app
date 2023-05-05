import 'package:flutter/material.dart';
import 'package:guide_app/themes/colors.dart';
import 'custom_textfield.dart';
import 'icon_button_widget.dart';

class CustomTextFieldPassword extends StatefulWidget {
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
  const CustomTextFieldPassword({
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
    this.contentPadding = const EdgeInsets.only(left: 15),
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
  State<CustomTextFieldPassword> createState() =>
      _CustomTextFieldPasswordState();
}

class _CustomTextFieldPasswordState extends State<CustomTextFieldPassword>
    with SingleTickerProviderStateMixin {
  bool _showPassword = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CustomTextField(
      prefixIcon: const Icon(
        Icons.lock,
        size: 17,
      ),
      suffixIcon: IconButtonWidget(
        onTap: () {
          setState(() {
            _showPassword = !_showPassword;
          });
        },
        customIcon: AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            transitionBuilder: (child, anim) => RotationTransition(
                  turns: child.key == const ValueKey('icon1')
                      ? Tween<double>(begin: 1, end: 0.75).animate(anim)
                      : Tween<double>(begin: 0.75, end: 1).animate(anim),
                  child: FadeTransition(opacity: anim, child: child),
                ),
            child: _showPassword
                ? const Icon(Icons.remove_red_eye, key: ValueKey('icon1'))
                : const Icon(
                    Icons.remove_red_eye_sharp,
                    key: ValueKey('icon2'),
                  )),
        //iconData: Icon( (_showPassword) ? Icons.remove_red_eye : Icons.home ),
      ),
      obscureText: !_showPassword,
      controller: widget.controller,
      labelText: "Password",
      onTap: widget.onTap,
      onSaved: widget.onSaved,
      onEditingComplete: widget.onEditingComplete,
      onChange: widget.onChange,
      validator: widget.validator,
      keyboardType: widget.keyboardType,
      textInputAction: widget.textInputAction,
      cursorColor: widget.cursorColor,
      readOnly: widget.readOnly,
      maxLength: widget.maxLength,
      maxLines: widget.maxLines,
      focusNode: widget.focusNode,
    );
  }
}

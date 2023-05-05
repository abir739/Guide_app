import 'package:flutter/material.dart';

class IconButtonWidget extends StatelessWidget {

  final GestureTapCallback? onTap;
  final Widget? customIcon;
  final double size;
  final Color? color;

  const IconButtonWidget({ 
    Key? key, 
    this.onTap, 
    this.customIcon,
    this.size = 25,
    this.color }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap :onTap,
      borderRadius: BorderRadius.circular(100),
      child: Padding(
        padding: const EdgeInsets.all(5),
        child: Container(
          padding: const EdgeInsets.all(6),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
            color: color
          ),
          child:  customIcon
        ),
      ),
    );
  }
}
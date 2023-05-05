import 'package:flutter/material.dart';
import 'package:guide_app/themes/colors.dart';

import '../utils/helper.dart';

class CustomButtonWidget extends StatelessWidget {
  final Color backgroundColor;
  final String title;
  final String icon;
  final String preIcon;
  final Function()? onTap;
  const CustomButtonWidget(
      {Key? key,
      this.backgroundColor = primary,
      this.title = "",
      this.icon = "",
      this.preIcon = "",
      this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
          fixedSize: const Size(double.infinity, 50), backgroundColor: backgroundColor,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30))),
      onPressed: onTap,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(title,
              style: TextStyle(
                color: getLabelColor(backgroundColor),
              )),
        ],
      ),
    );
  }
}

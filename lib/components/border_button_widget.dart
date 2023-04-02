import 'package:flutter/material.dart';
import 'package:guide_app/components/icon_widget.dart';
import 'package:guide_app/themes/colors.dart';

import '../utils/helper.dart';

class BorderButtonV2 extends StatelessWidget {
  final String title;
  final String icon;
  final String preIcon;
  final double iconSize;
  final Function()? onTap;
  const BorderButtonV2(
      {Key? key,
      this.title = "",
      this.icon = "",
      this.preIcon = "",
      this.iconSize = 20,
      this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        fixedSize: Size(70, 60),
        primary: white,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
            side: BorderSide(width: 1, color: lineBorderColor)),
        elevation: 0,
      ),
      onPressed: onTap,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          (checkIsNullValue(preIcon))
              ? SizedBox()
              : Padding(
                  padding: EdgeInsets.only(
                      right: (checkIsNullValue(title)) ? 0 : 10),
                  child: IconWidget(
                    size: iconSize,
                    icon: preIcon,
                    color: Colors.transparent,
                  ),
                ),
          Text(title,
              style: TextStyle(
                color: primary,
              )),
          (checkIsNullValue(icon))
              ? SizedBox()
              : Padding(
                  padding:
                      EdgeInsets.only(left: (checkIsNullValue(title)) ? 0 : 10),
                  child: IconWidget(size: iconSize, icon: icon),
                )
        ],
      ),
    );
  }
}

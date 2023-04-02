import 'package:flutter/material.dart';

import '../themes/colors.dart';
import '../utils/app_asset.dart';
import 'image_local_widget.dart';

class IconWidget extends StatelessWidget {
  final String icon;
  final double size;
  final Color? color; 
  const IconWidget({ Key? key, this.icon = "" ,this.size= 25, this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100)
      ),
      width: size,
      height: size,
      child: (color == Colors.transparent) ? ImageLocalWidget(asset: AppAsset.icon + icon) :
        ImageLocalWidget(asset: AppAsset.icon + icon, color: (color == null) ? primary : color)
    );
  }
}

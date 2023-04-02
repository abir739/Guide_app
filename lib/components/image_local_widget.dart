import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
class ImageLocalWidget extends StatelessWidget {
  final String asset;
  final Color? color; 
  const ImageLocalWidget({ Key? key, this.asset = "", this.color}) : super(key: key);

  get primary => null;

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(asset , color: color);
  }
}

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomAppBar extends StatelessWidget {
  final Widget belowWidget;
  final Widget? leftWidget;
  final Widget rightWidget;
  final Widget centerWidget;
  final String appBarTitle;
  final Color? color;
  const CustomAppBar({ 
    Key? key , 
    this.belowWidget = const SizedBox(),
    this.leftWidget,
    this.rightWidget = const SizedBox(),
    this.centerWidget = const SizedBox(),
    this.color,
    this.appBarTitle = ""
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      systemOverlayStyle: SystemUiOverlayStyle.dark,
      backgroundColor: color,
      automaticallyImplyLeading: false,
      title: Column(
        children: [
          Stack(
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child:  leftWidget
              ),

              Align(
                alignment: Alignment.center,
                child: centerWidget
              ),

              Align(
                alignment: Alignment.centerRight,
                child: rightWidget
              )

            ],
          ),
          belowWidget
        ],
      )
    );
  }

}
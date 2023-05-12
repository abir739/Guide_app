import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../controller/dialog_provider.dart';
import '../../widget/custom_list_tile.dart';
import '../../widget/color_picker.dart';

class TitleTextStyleArguments extends StatelessWidget {
  const TitleTextStyleArguments({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<DialogProvider>(
      builder: (_, dialog, child) {
        return Column(
          children: [
            CustomListTile<Switch, bool>(
              title: "Font Bold",
              value: dialog.titleTextStyle.fontWeight == FontWeight.bold,
              onChanged: (bool value) => dialog.titleTextStyle =
                  dialog.titleTextStyle.copyWith(
                      fontWeight: (value == false)
                          ? FontWeight.normal
                          : FontWeight.bold),
            ),
            CustomListTile<Slider, double>(
              title: "Font Size",
              min: 12,
              max: 30,
              divisions: 18,
              value: dialog.titleTextStyle.fontSize!,
              sliderLabel: dialog.titleTextStyle.fontSize?.toInt().toString(),
              onChanged: (value) => dialog.titleTextStyle =
                  dialog.titleTextStyle.copyWith(
                      fontSize: value, color: dialog.titleTextStyle.color),
            ),
            CustomListTile<ColorPicker, Color>(
              title: "Font Color",
              value: dialog.titleTextStyle.color!,
              onChanged: (Color color) => dialog.titleTextStyle =
                  dialog.titleTextStyle.copyWith(color: color),
            ),
          ],
        );
      },
    );
  }
}

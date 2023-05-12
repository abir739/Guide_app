import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../controller/dialog_provider.dart';
import '../../widget/custom_list_tile.dart';
import '../../widget/color_picker.dart';
import '../../translation.dart';

class SearchTileArguments extends StatelessWidget {
  const SearchTileArguments({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<DialogProvider>(
      builder: (_, dialog, child) {
        return Column(
          children: [
            CustomListTile<Switch, bool>(
              title: "Visible",
              value: dialog.searchTile,
              onChanged: (bool value) => dialog.searchTile = value,
            ),
            CustomListTile<TextFormField, String>(
              title: "Title String",
              value: dialog.searchTileTitle.tr,
              onChanged: (String value) => dialog.searchTileTitle = value,
            ),
            CustomListTile<TextFormField, String>(
              title: "Hint String",
              value: dialog.searchTileHintString,
              onChanged: (String value) => dialog.searchTileHintString = value,
            ),
            CustomListTile<Switch, bool>(
              title: "Font Bold",
              value:
                  dialog.searchTileHintTextStyle.fontWeight == FontWeight.bold,
              onChanged: (bool value) => dialog.searchTileHintTextStyle =
                  dialog.searchTileHintTextStyle.copyWith(
                      fontWeight: (value == false)
                          ? FontWeight.normal
                          : FontWeight.bold),
            ),
            CustomListTile<Slider, double>(
              title: "Font Size",
              min: 12,
              max: 30,
              divisions: 18,
              value: dialog.searchTileHintTextStyle.fontSize!,
              sliderLabel:
                  dialog.searchTileHintTextStyle.fontSize?.toInt().toString(),
              onChanged: (value) => dialog.searchTileHintTextStyle =
                  dialog.searchTileHintTextStyle.copyWith(
                      fontSize: value,
                      color: dialog.searchTileHintTextStyle.color),
            ),
            CustomListTile<ColorPicker, Color>(
              title: "Font Color",
              value: dialog.searchTileHintTextStyle.color!,
              onChanged: (Color color) => dialog.searchTileHintTextStyle =
                  dialog.searchTileHintTextStyle.copyWith(color: color),
            ),
          ],
        );
      },
    );
  }
}

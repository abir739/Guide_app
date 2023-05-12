import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../controller/dialog_provider.dart';
import '../../widget/custom_list_tile.dart';
import '../../widget/color_picker.dart';
import '../../translation.dart';

class GeneralDialogArguments extends StatelessWidget {
  const GeneralDialogArguments({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<DialogProvider>(
      builder: (_, dialog, child) {
        return Column(
          children: [
            CustomListTile<TextFormField, String>(
              title: "App Bar Title",
              value: dialog.appBarTitle.tr,
              onChanged: (String value) => dialog.appBarTitle = value,
            ),
            CustomListTile<Switch, bool>(
              title: "Country Flag",
              value: dialog.countryFlag,
              onChanged: (bool value) => dialog.countryFlag = value,
            ),
            CustomListTile<Switch, bool>(
              title: "Country dial code",
              value: dialog.countryDialCode,
              onChanged: (bool value) => dialog.countryDialCode = value,
            ),
            CustomListTile<Switch, bool>(
              title: "Up action button",
              value: dialog.upActionbutton,
              onChanged: (bool value) => dialog.upActionbutton = value,
            ),
            CustomListTile<Slider, double>(
              title: "Tile height",
              min: 50,
              max: 100,
              divisions: 5,
              value: dialog.tileHeight,
              sliderLabel: dialog.tileHeight.toInt().toString(),
              onChanged: (value) => dialog.tileHeight = value,
            ),
            CustomListTile<ColorPicker, Color>(
              title: "Background Color",
              value: dialog.backgroundColor,
              onChanged: (Color color) => dialog.backgroundColor = color,
            ),
            CustomListTile<ColorPicker, Color>(
              title: "Titles Background Color",
              value: dialog.titlesBackgroundColor,
              onChanged: (Color color) => dialog.titlesBackgroundColor = color,
            ),
          ],
        );
      },
    );
  }
}

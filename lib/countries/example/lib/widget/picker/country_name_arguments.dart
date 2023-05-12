import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../controller/picker_provider.dart';
import '../../widget/custom_list_tile.dart';
import '../../widget/color_picker.dart';

class CountryNameArguments extends StatelessWidget {
  const CountryNameArguments({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<PickerProvider>(
      builder: (context, picker, child) {
        return Column(
          children: [
            CustomListTile<Switch, bool>(
              title: "Visible",
              value: picker.isShowCountryName,
              onChanged: (bool value) => picker.isShowCountryName = value,
            ),
            CustomListTile<Switch, bool>(
              title: "Font Bold",
              enabled: picker.isShowCountryName,
              value: picker.countryNameTextStyle.fontWeight == FontWeight.bold,
              onChanged: (bool value) => picker.countryNameTextStyle =
                  picker.countryNameTextStyle.copyWith(
                      fontWeight: (value == false)
                          ? FontWeight.normal
                          : FontWeight.bold),
            ),
            CustomListTile<Slider, double>(
              title: "Font Size",
              enabled: picker.isShowCountryName,
              min: 12,
              max: 30,
              divisions: 18,
              value: picker.countryNameTextStyle.fontSize!,
              sliderLabel:
                  picker.countryNameTextStyle.fontSize?.toInt().toString(),
              onChanged: (value) => picker.countryNameTextStyle =
                  picker.countryNameTextStyle.copyWith(fontSize: value),
            ),
            CustomListTile<ColorPicker, Color>(
              title: "Font Color",
              enabled: picker.isShowCountryName,
              value: picker.countryNameTextStyle.color!,
              onChanged: (Color color) => picker.countryNameTextStyle =
                  picker.countryNameTextStyle.copyWith(color: color),
            ),
          ],
        );
      },
    );
  }
}

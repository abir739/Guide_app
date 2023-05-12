import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../controller/input_provider.dart';
import '../../widget/custom_list_tile.dart';
import '../../widget/color_picker.dart';
import '../../translation.dart';

class HintArguments extends StatelessWidget {
  const HintArguments({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<InputProvider>(
      builder: (context, input, child) {
        return Column(
          children: [
            CustomListTile<TextFormField, String>(
                title: "Input Hint",
                enabled: input.isShowTextField,
                value: input.hintString.tr,
                onChanged: (value) => input.hintString = value),
            CustomListTile<Switch, bool>(
              title: "Font Bold",
              enabled: input.isShowTextField,
              value: input.hintTextStyle.fontWeight == FontWeight.bold,
              onChanged: (bool value) => input.hintTextStyle =
                  input.hintTextStyle.copyWith(
                      fontWeight: (value == false)
                          ? FontWeight.normal
                          : FontWeight.bold),
            ),
            CustomListTile<Slider, double>(
              title: "Font Size",
              enabled: input.isShowTextField,
              min: 12,
              max: 30,
              divisions: 18,
              value: input.hintTextStyle.fontSize != null
                  ? input.hintTextStyle.fontSize!
                  : input.textStyle.fontSize!,
              sliderLabel: input.hintTextStyle.fontSize?.toInt().toString(),
              onChanged: (value) => input.hintTextStyle = input.hintTextStyle
                  .copyWith(fontSize: value, color: input.hintTextStyle.color),
            ),
            CustomListTile<ColorPicker, Color>(
              title: "Font Color",
              enabled: input.isShowTextField,
              value: input.hintTextStyle.color!,
              onChanged: (Color color) => input.hintTextStyle =
                  input.hintTextStyle.copyWith(color: color),
            ),
          ],
        );
      },
    );
  }
}

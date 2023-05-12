import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../controller/input_provider.dart';
import '../../widget/custom_list_tile.dart';
import '../../widget/color_picker.dart';
import '../../controller/settings_provider.dart';

class InputArguments extends StatelessWidget {
  const InputArguments({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer2<InputProvider, SettingsProvider>(
      builder: (context, input, settings, child) {
        return Column(
          children: [
            CustomListTile<Switch, bool>(
              title: "Visible",
              value: input.isShowTextField,
              onChanged: (bool value) => input.isShowTextField = value,
            ),
            CustomListTile<TextFormField, String>(
              title: "Mask format",
              textDirection: TextDirection.ltr,
              enabled: input.isShowTextField,
              value: input.mask,
              onChanged: (value) => input.mask = value,
            ),
            CustomListTile<Switch, bool>(
              title: "Obscure Text",
              value: input.isObscureText,
              onChanged: (bool value) => input.isObscureText = value,
            ),
            CustomListTile<TextFormField, String>(
              title: "Obscuring Character",
              min: 1,
              max: 1,
              enabled: input.isObscureText,
              value: input.obscuringCharacter,
              onChanged: (value) {
                if (value.isNotEmpty) input.obscuringCharacter = value;
              },
            ),
            CustomListTile<Switch, bool>(
              title: "Font Bold",
              enabled: input.isShowTextField,
              value: input.textStyle.fontWeight == FontWeight.bold,
              onChanged: (bool value) => input.textStyle = input.textStyle
                  .copyWith(
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
              value: input.textStyle.fontSize!,
              sliderLabel: input.textStyle.fontSize?.toInt().toString(),
              onChanged: (value) =>
                  input.textStyle = input.textStyle.copyWith(fontSize: value),
            ),
            CustomListTile<ColorPicker, Color>(
              title: "Font Color",
              enabled: input.isShowTextField,
              value: input.textStyle.color!,
              onChanged: (Color color) =>
                  input.textStyle = input.textStyle.copyWith(color: color),
            ),
          ],
        );
      },
    );
  }
}

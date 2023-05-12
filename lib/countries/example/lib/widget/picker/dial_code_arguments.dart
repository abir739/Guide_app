import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../controller/picker_provider.dart';
import '../../widget/custom_list_tile.dart';
import '../../widget/color_picker.dart';

class DialCodeArguments extends StatelessWidget {
  const DialCodeArguments({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<PickerProvider>(
      builder: (context, picker, child) {
        return Column(
          children: [
            CustomListTile<Switch, bool>(
              title: "Visible",
              value: picker.isShowDialCode,
              onChanged: (bool value) => picker.isShowDialCode = value,
            ),
            CustomListTile<Switch, bool>(
              title: "Font Bold",
              enabled: picker.isShowDialCode,
              value: picker.dialCodeTextStyle.fontWeight == FontWeight.bold,
              onChanged: (bool value) => picker.dialCodeTextStyle =
                  picker.dialCodeTextStyle.copyWith(
                      fontWeight: (value == false)
                          ? FontWeight.normal
                          : FontWeight.bold),
            ),
            CustomListTile<Slider, double>(
              title: "Font Size",
              enabled: picker.isShowDialCode,
              min: 12,
              max: 30,
              divisions: 18,
              value: picker.dialCodeTextStyle.fontSize!,
              sliderLabel:
                  picker.dialCodeTextStyle.fontSize?.toInt().toString(),
              onChanged: (value) => picker.dialCodeTextStyle =
                  picker.dialCodeTextStyle.copyWith(fontSize: value),
            ),
            CustomListTile<ColorPicker, Color>(
              title: "Font Color",
              enabled: picker.isShowDialCode,
              value: picker.dialCodeTextStyle.color!,
              onChanged: (Color color) {
                picker.dialCodeTextStyle =
                    picker.dialCodeTextStyle.copyWith(color: color);
              },
            ),
          ],
        );
      },
    );
  }
}

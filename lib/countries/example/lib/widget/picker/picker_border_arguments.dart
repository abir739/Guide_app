import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../controller/picker_provider.dart';
import '../../model/borders.dart';
import '../../widget/custom_list_tile.dart';
import '../../controller/input_provider.dart';

class PickerBorderArguments extends StatelessWidget {
  const PickerBorderArguments({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer2<PickerProvider, InputProvider>(
      builder: (context, picker, input, child) {
        return Column(
          children: [
            CustomListTile<DropdownButtonFormField, Borders>(
              title: "Type",
              enabled: input.border == Borders.none,
              value: picker.border,
              onStringChanged: (value) => picker.border = value,
            ),
            CustomListTile<Slider, double>(
              title: "Width",
              enabled:
                  picker.border != Borders.none && input.border == Borders.none,
              min: 1,
              max: 5,
              divisions: 4,
              value: picker.borderWidth,
              sliderLabel: picker.borderWidth.toInt().toString(),
              onChanged: (value) => picker.borderWidth = value,
            ),
            // CustomListTile<ColorPicker, Color>(
            //   title: "Color",
            //   enabled: picker.border != Borders.none,
            //   value: picker.borderColor,
            //   onChanged: (Color color) => picker.borderColor = color,
            // ),
          ],
        );
      },
    );
  }
}

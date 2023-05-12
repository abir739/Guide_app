import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../controller/picker_provider.dart';
import '../../widget/custom_list_tile.dart';

class FlagArguments extends StatelessWidget {
  const FlagArguments({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<PickerProvider>(
      builder: (context, picker, child) {
        return Column(
          children: [
            CustomListTile<Switch, bool>(
              title: "Visible",
              value: picker.isShowFlag,
              onChanged: (bool value) => picker.isShowFlag = value,
            ),
            CustomListTile<Slider, double>(
              title: "Width",
              enabled: picker.isShowFlag,
              min: 10,
              max: 100,
              divisions: 18,
              value: picker.flagSize.width,
              sliderLabel: picker.flagSize.width.toString(),
              onChanged: (value) =>
                  picker.flagSize = Size(value, picker.flagSize.height),
            ),
            CustomListTile<Slider, double>(
              title: "Height",
              enabled: picker.isShowFlag,
              min: 10,
              max: 50,
              divisions: 4,
              value: picker.flagSize.height,
              sliderLabel: picker.flagSize.height.toString(),
              onChanged: (value) =>
                  picker.flagSize = Size(picker.flagSize.width, value),
            ),
          ],
        );
      },
    );
  }
}

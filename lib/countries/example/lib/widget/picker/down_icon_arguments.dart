import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../controller/picker_provider.dart';
import '../../widget/custom_list_tile.dart';
import '../../widget/color_picker.dart';

class DownIconArguments extends StatelessWidget {
  const DownIconArguments({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<PickerProvider>(
      builder: (context, picker, child) {
        return Column(
          // mainAxisSize: MainAxisSize.min,
          children: [
            CustomListTile<Switch, bool>(
              title: "Visible",
              value: picker.isDownIcon,
              onChanged: (bool value) => picker.isDownIcon = value,
            ),
            CustomListTile<Slider, double>(
                title: "Icon Size",
                enabled: picker.isDownIcon,
                min: 20,
                max: 40,
                divisions: 5,
                value: picker.downIcon.size!,
                sliderLabel: picker.downIcon.size!.toInt().toString(),
                onChanged: (value) => picker.downIcon = picker.downIcon = Icon(
                    picker.downIcon.icon,
                    color: picker.downIcon.color,
                    size: value)),
            CustomListTile<ColorPicker, Color>(
              title: "Icon Color",
              enabled: picker.isDownIcon,
              value: picker.downIcon.color ??
                  Theme.of(context).colorScheme.primary,
              onChanged: (Color color) => picker.downIcon = Icon(
                picker.downIcon.icon,
                color: color,
                size: picker.downIcon.size,
              ),
            ),
          ],
        );
      },
    );
  }
}

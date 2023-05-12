import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../controller/input_provider.dart';
import '../../model/borders.dart';
import '../../widget/custom_list_tile.dart';

class InputBorderArguments extends StatelessWidget {
  const InputBorderArguments({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<InputProvider>(
      builder: (context, input, child) {
        return Column(
          children: [
            CustomListTile<DropdownButtonFormField, Borders>(
              title: "Type",
              value: input.border,
              onStringChanged: (value) {
                input.border = value;
              },
            ),
            CustomListTile<Slider, double>(
              title: "Width",
              enabled: input.border != Borders.none,
              min: 1,
              max: 5,
              divisions: 4,
              value: input.borderWidth,
              sliderLabel: input.borderWidth.toInt().toString(),
              onChanged: (value) => input.borderWidth = value,
            ),
          ],
        );
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:country_list_picker/country_list_picker.dart';
import '../../controller/dialog_provider.dart';
import '../../widget/custom_list_tile.dart';
import '../../translation.dart';

class CurrentLocationTileArguments extends StatelessWidget {
  const CurrentLocationTileArguments({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<DialogProvider>(
      builder: (_, dialog, child) {
        return Column(
          children: [
            CustomListTile<Switch, bool>(
              title: "Visible",
              value: dialog.currentLocationTile,
              onChanged: (bool value) => dialog.currentLocationTile = value,
            ),
            CustomListTile<TextFormField, String>(
              title: "Title String",
              enabled: dialog.currentLocationTile,
              value: dialog.currentLocationTileTitle.tr,
              onChanged: (String value) =>
                  dialog.currentLocationTileTitle = value,
            ),
            CustomListTile<DropdownButtonFormField, Countries>(
              title: "Local Country",
              enabled: dialog.currentLocationTile,
              value: dialog.localCountry,
              onCountiresChanged: (value) => dialog.localCountry = value,
            ),
            const SizedBox(
              height: 20,
            ),
          ],
        );
      },
    );
  }
}

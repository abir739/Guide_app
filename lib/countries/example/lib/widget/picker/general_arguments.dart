import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:country_list_picker/country_list_picker.dart';
import '../../controller/picker_provider.dart';
import '../../controller/settings_provider.dart';
import '../custom_list_tile.dart';

class GeneralPickerArguments extends StatelessWidget {
  const GeneralPickerArguments({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer2<PickerProvider, SettingsProvider>(
      builder: (_, picker, settings, child) {
        return Column(
          children: [
            CustomListTile<Switch, bool>(
              title: "Separated",
              value: picker.separated,
              onChanged: (bool value) => picker.separated = value,
            ),
            CustomListTile<DropdownButtonFormField, Languages>(
              title: "Language",
              enabled: picker.separated,
              value: picker.language,
              onLanguagesChanged: (value) => picker.language = value,
            ),
            CustomListTile<DropdownButtonFormField, TextDirection>(
              title: "Text Direction",
              enabled: picker.separated,
              value: picker.textDirection,
              ontextDirectionChanged: (value) => picker.textDirection = value,
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

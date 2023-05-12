import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:country_list_picker/country_list_picker.dart';
import '../color_picker.dart';
import '../../controller/settings_provider.dart';
import '../../translation.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<SettingsProvider>(
      builder: (context, settings, child) {
        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Text("General APP Settings".tr,
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold)),
            ),
            ListTile(
                title: Text("Language".tr,
                    style: const TextStyle(fontWeight: FontWeight.bold)),
                subtitle: DropdownButtonFormField<Languages>(
                  value: settings.language,
                  items: Languages.values
                      .map<DropdownMenuItem<Languages>>(
                        (e) => DropdownMenuItem<Languages>(
                          value: e,
                          child: SizedBox(
                              width: MediaQuery.of(context).size.width - 100,
                              child: Text(e.name,
                                  overflow: TextOverflow.ellipsis)),
                        ),
                      )
                      .toList(),
                  onChanged: ((value) => settings.language = value!),
                )),
            ListTile(
              title: Text("Light Primary Color".tr,
                  style: const TextStyle(fontWeight: FontWeight.bold)),
              subtitle: ColorPicker(
                colors: const [
                  Colors.red,
                  Colors.green,
                  Colors.blue,
                  Colors.yellow,
                  Colors.orange,
                  Colors.purple,
                  Colors.pink,
                  Colors.amber,
                  Colors.indigo,
                  Colors.cyan,
                  Colors.lime,
                  Colors.teal,
                  Colors.brown,
                ],
                value: settings.lightprimarySwatch,
                onColorChanged: (value) => settings.lightprimarySwatch = value,
              ),
            ),
            ListTile(
              title: Text("Dark Primary Color".tr,
                  style: const TextStyle(fontWeight: FontWeight.bold)),
              subtitle: ColorPicker(
                colors: const [
                  Colors.red,
                  Colors.green,
                  Colors.blue,
                  Colors.yellow,
                  Colors.orange,
                  Colors.purple,
                  Colors.pink,
                  Colors.amber,
                  Colors.indigo,
                  Colors.cyan,
                  Colors.lime,
                  Colors.teal,
                  Colors.brown,
                ],
                value: settings.darkprimarySwatch,
                onColorChanged: (value) => settings.darkprimarySwatch = value,
              ),
            )
          ],
        );
      },
    );
  }
}

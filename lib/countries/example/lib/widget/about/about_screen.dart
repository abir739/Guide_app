import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../controller/settings_provider.dart';
import '../../translation.dart';

import '../../model/screen.dart';

class AboutScreen extends StatelessWidget {
  final Screen? screen;
  const AboutScreen({this.screen, super.key});

  @override
  Widget build(BuildContext context) {
    Color color = Theme.of(context).colorScheme.primary;
    return Consumer<SettingsProvider>(
      builder: (context, value, child) {
        return Center(
          child: ListView(
            children: [
              ListTile(
                  title: Text(
                "Country List Picker".tr,
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              )),
              ListTile(
                title: Text("Version".tr,
                    style: const TextStyle(
                      fontSize: 19,
                      fontWeight: FontWeight.normal,
                    )),
                subtitle: Text("1.0.0".tr,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: color,
                    )),
              ),
              ListTile(
                title: Text("Last Update".tr,
                    style: const TextStyle(
                        fontSize: 19, fontWeight: FontWeight.normal)),
                subtitle: Text("January 2023".tr,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: color,
                    )),
              ),
              ListTile(
                title: Text("Description".tr,
                    style: const TextStyle(
                        fontSize: 19, fontWeight: FontWeight.normal)),
                subtitle: Text("Flutter Widget".tr,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: color,
                    )),
              ),
              ListTile(
                title: Text("Desinged by".tr,
                    style: const TextStyle(
                        fontSize: 19, fontWeight: FontWeight.normal)),
                subtitle: Text("Amr Emad Eldin Lotfy".tr,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: color,
                    )),
              ),
              ListTile(
                title: Text("Email".tr,
                    style: const TextStyle(
                        fontSize: 19, fontWeight: FontWeight.normal)),
                subtitle: Text("a.emad@outlook.com",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: color,
                    )),
              ),
              ListTile(
                title: Text("Phone".tr,
                    style: const TextStyle(
                        fontSize: 19, fontWeight: FontWeight.normal)),
                subtitle: Text("+20 111 1146 515",
                    textAlign: (Directionality.of(context) == TextDirection.rtl)
                        ? TextAlign.right
                        : TextAlign.left,
                    textDirection: TextDirection.ltr,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: color,
                    )),
              ),
            ],
          ),
        );
      },
    );
  }
}

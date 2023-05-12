import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../translation.dart';
import '../app_data.dart';
import '../bottom_part.dart';
import '../controller/settings_provider.dart';
import '../top_part.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<SettingsProvider>(
      builder: (context, settings, child) => Directionality(
        textDirection: settings.language.textDirection,
        child: Scaffold(
          appBar: AppBar(
            title: Text("Country List Picker".tr),
            actions: [
              IconButton(
                onPressed: () {
                  // show the dialog
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Country List Picker",
                              style: TextStyle(
                                  color: Theme.of(context).colorScheme.primary),
                            ),
                            const Text("1.0.0", style: TextStyle(fontSize: 15)),
                            const Text("© 2023 - Amr Emad",
                                style: TextStyle(fontSize: 15)),
                            const Text("a.emad@outlook.com / +201111146515",
                                style: TextStyle(fontSize: 15))
                          ],
                        ),
                        content: const Text(
                            "This example shows the features of the CountryListPicker"),
                        actions: [
                          TextButton(
                            child: const Text("OK"),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          ),
                        ],
                      );
                    },
                  );
                },
                icon: settings.isDarkMode
                    ? Icon(
                        Icons.info,
                        color: settings.darkprimarySwatch,
                      )
                    : const Icon(
                        Icons.info,
                        color: Colors.white,
                      ),
              ),
              // IconButton(
              //   onPressed: () {
              //     // Navigator.push(
              //     //   context,
              //     //   MaterialPageRoute(builder: (context) => const CodePage()),
              //     // );
              //   },
              //   icon: settings.isDarkMode
              //       ? Icon(
              //           Icons.code,
              //           color: settings.darkprimarySwatch,
              //         )
              //       : const Icon(
              //           Icons.code,
              //           color: Colors.white,
              //         ),
              // ),
              IconButton(
                onPressed: () => settings.isDarkMode = !settings.isDarkMode,
                icon: settings.isDarkMode
                    ? Icon(
                        Icons.sunny,
                        color: settings.darkprimarySwatch,
                      )
                    : const Icon(
                        Icons.dark_mode,
                        color: Colors.white,
                      ),
              ),
            ],
          ),
          bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            showUnselectedLabels: true,
            currentIndex: settings.selectedScreen,
            selectedLabelStyle:
                const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            unselectedLabelStyle: const TextStyle(fontSize: 14),
            items: screens
                .map((e) => BottomNavigationBarItem(
                      icon: Icon(e.inactiveIcon),
                      label: e.title.tr,
                      activeIcon: Icon(e.activeIcon),
                    ))
                .toList(),
            onTap: (index) => settings.selectedScreen = index,
          ),
          body: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Container(
                height: 140,
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: const Card(elevation: 2, child: TopPart()),
              ),
              Expanded(
                  child: Stack(
                children: screens
                    .asMap()
                    .map((index, screen) => MapEntry(
                        index,
                        Offstage(
                            offstage: settings.selectedScreen != index,
                            child: BottomPart(screen: screen))))
                    .values
                    .toList(),
              )),
            ],
          ),
        ),
      ),
    );
  }
}

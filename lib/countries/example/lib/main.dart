import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:country_list_picker/country_list_picker.dart';
import '../controller/settings_provider.dart';
import '../controller/dialog_provider.dart';
import '../controller/input_provider.dart';
import '../controller/picker_provider.dart';

import '../onboarding_page.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      // Settings Provider
      ChangeNotifierProvider<SettingsProvider>(create: (_) => SettingsProvider()),

      // Onborading Provider
      ChangeNotifierProvider<OnboardingProvider>(create: (_) => OnboardingProvider()),

      // Picker Provider
      ChangeNotifierProxyProvider<SettingsProvider, PickerProvider>(
          create: (_) => PickerProvider(),
          update: (_, settings, picker) => picker!..update(settings)),

      // Input Provider
      ChangeNotifierProxyProvider<SettingsProvider, InputProvider>(
          create: (_) => InputProvider(), update: (_, settings, input) => input!..update(settings)),

      // dialog Provider
      ChangeNotifierProxyProvider<SettingsProvider, DialogProvider>(
          create: (_) => DialogProvider(),
          update: (_, settings, dialog) => dialog!..update(settings)),
    ],
    child: const CountryListPickerExample(),
  ));
}

class CountryListPickerExample extends StatelessWidget {
  const CountryListPickerExample({super.key});
  @override
  Widget build(BuildContext context) {
    return Consumer<SettingsProvider>(
      builder: (_, settings, child) {
        return MaterialApp(
          title: 'Country List Picker',
          debugShowCheckedModeBanner: false,
          themeMode: settings.isDarkMode ? ThemeMode.dark : ThemeMode.light,
          darkTheme: ThemeData(
            brightness: Brightness.dark,
            fontFamily: (settings.language != Languages.Arabic) ? "Quicksand" : "Cairo",
            primarySwatch: settings.darkprimarySwatch as MaterialColor,
            bottomNavigationBarTheme: BottomNavigationBarThemeData(
              unselectedItemColor: Colors.white,
              selectedItemColor: settings.darkprimarySwatch,
            ),
          ),
          theme: ThemeData(
            brightness: Brightness.light,
            fontFamily: (settings.language != Languages.Arabic) ? "Quicksand" : "Cairo",
            primarySwatch: settings.lightprimarySwatch as MaterialColor,
            expansionTileTheme: ExpansionTileThemeData(
                backgroundColor: settings.lightprimarySwatch.withOpacity(.1),
                collapsedBackgroundColor: settings.lightprimarySwatch.withOpacity(.5)),
            bottomNavigationBarTheme: BottomNavigationBarThemeData(
              unselectedItemColor: Colors.black38,
              selectedItemColor: settings.lightprimarySwatch,
            ),
          ),
          home: const OnBoardingPage(),
        );
      },
    );
  }
}

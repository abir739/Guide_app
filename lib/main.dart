import 'package:flutter/material.dart';
import 'package:guide_app/login_page.dart';
import 'package:firebase_core/firebase_core.dart';

import 'themes/colors.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp(homeScreen: LoginPage()));
}

class MyApp extends StatefulWidget {
  final Widget? homeScreen;
  const MyApp({super.key, this.homeScreen});
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: widget.homeScreen,
        theme: ThemeData(
          fontFamily: 'Poppins',
          primaryColor: primary,
          scaffoldBackgroundColor: white,
          colorScheme: ThemeData().colorScheme.copyWith(primary: primary),
          bottomNavigationBarTheme: const BottomNavigationBarThemeData(
            elevation: 0.0,
            backgroundColor: white,
            selectedLabelStyle: TextStyle(color: primary),
            showSelectedLabels: true,
            selectedItemColor: primary,
          ),
          appBarTheme: const AppBarTheme(
              elevation: 0.0,
              backgroundColor: white,
              titleTextStyle: TextStyle(
                  color: primary,
                  fontFamily: 'Poppins',
                  fontSize: 20,
                  fontWeight: FontWeight.w600),
              toolbarTextStyle: TextStyle(color: primary)),
        ),
      ),
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
    );
  }
}

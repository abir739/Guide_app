import 'package:flutter/material.dart';
import 'package:guide_app/login_page.dart';

import 'themes/colors.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp(homeScreen: LoginPage()));
}

class MyApp extends StatefulWidget {
  final Widget? homeScreen;
  MyApp({this.homeScreen});
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: this.widget.homeScreen,
        theme: ThemeData(
          fontFamily: 'Poppins',
          primaryColor: primary,
          scaffoldBackgroundColor: white,
          colorScheme: ThemeData().colorScheme.copyWith(primary: primary),
          bottomNavigationBarTheme: BottomNavigationBarThemeData(
            elevation: 0.0,
            backgroundColor: white,
            selectedLabelStyle: TextStyle(color: primary),
            showSelectedLabels: true,
            selectedItemColor: primary,
          ),
          appBarTheme: AppBarTheme(
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

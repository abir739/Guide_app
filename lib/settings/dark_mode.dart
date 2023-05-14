import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DarkScreen extends StatefulWidget {
  @override
  _DarkScreenState createState() => _DarkScreenState();
}

class _DarkScreenState extends State<DarkScreen> {
  bool isDarkMode = false;

  void toggleDarkMode() {
    setState(() {
      isDarkMode = !isDarkMode;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('DarkScreen'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Change Theme',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 20),
            Switch(
              value: isDarkMode,
              onChanged: (value) {
                toggleDarkMode();
              },
            ),
          ],
        ),
      ),
    );
  }
}
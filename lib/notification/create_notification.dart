import 'package:flutter/material.dart';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_svg/svg.dart';

import '../components/custom_textfield.dart';

class AddNotification extends StatefulWidget {
  const AddNotification({Key? key}) : super(key: key);

  @override
  _AddNotificationState createState() => _AddNotificationState();
}

class _AddNotificationState extends State<AddNotification> {
  DateTime selectedTime = DateTime.now();

  List<String> passengerGroups = ['Group 1', 'Group 2', 'Group 3', 'Group 4'];
  String selectedGroup = 'Group 1';

  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  TextEditingController _titleController = TextEditingController();
  TextEditingController _bodyController = TextEditingController();

  @override
  void initState() {
    super.initState();
    initializeNotifications();
  }

  void _showConfirmationDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirmation'),
          content: const Text('Do you really want to send this notification?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
                showNotification(); // Send the notification
                _showSnackbar(selectedGroup); // Show the snackbar
              },
              child: const Text('Yes'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: const Text('No'),
            ),
          ],
        );
      },
    );
  }

  void _showSnackbar(String selectedGroup) {
    final snackBar = SnackBar(
      backgroundColor: Colors.green,
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            child: Row(
              children: [
                Icon(Icons.check_circle,
                    color: Colors.white), // Add the success icon
                SizedBox(width: 8),
                Text(
                  'Done successfully!',
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ],
            ),
          ),
          SizedBox(height: 4),
          Text(
            'A notification sent to $selectedGroup',
            style: TextStyle(fontSize: 18, color: Colors.white),
          ),
        ],
      ),
      behavior: SnackBarBehavior.floating,
      action: SnackBarAction(
        label: 'OK',
        onPressed: () {},
        textColor: Colors.white,
      ),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void _showSuccessDialog(String selectedGroup) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Success'),
          content: Text(
            'A notification sent to $selectedGroup',
            style: TextStyle(fontSize: 18, color: Colors.white),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  void initializeNotifications() {
    var initializationSettingsAndroid =
        const AndroidInitializationSettings('@mipmap/ic_launcher');
    var initializationSettingsIOS = IOSInitializationSettings();
    var initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
    );

    flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  Future<void> showNotification() async {
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
      'channel_id',
      'channel_name',
      'channel_description',
      importance: Importance.max,
      priority: Priority.high,
    );
    var iOSPlatformChannelSpecifics = IOSNotificationDetails();
    var platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
      iOS: iOSPlatformChannelSpecifics,
    );

    await flutterLocalNotificationsPlugin.show(
      0,
      _titleController.text,
      _bodyController.text,
      platformChannelSpecifics,
      payload: selectedGroup, // Use the selected group as the payload
    );

    _showSuccessDialog(selectedGroup); // Show the success dialog
  }

  @override
  void dispose() {
    _titleController.dispose();
    _bodyController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text('Create Notification'),
      // ),
      appBar: AppBar(
        title: Row(
          children: [
            SvgPicture.asset(
              'assets/images/Logo.svg',
              fit: BoxFit.cover,
              height: 36.0,
            ),
            const SizedBox(
                width: 30.0), // Add spacing between the logo and the text
            const Text('Create Notification'),
          ],
        ),
        backgroundColor: const Color.fromARGB(255, 207, 207, 219),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            CustomTextField(
              controller: _titleController,
              labelText: 'Title',
            ),
            const SizedBox(height: 16.0),

            CustomTextField(
              controller: _bodyController,
              labelText: 'Body',
            ),
            const SizedBox(height: 16.0),

            DropdownButtonFormField<String>(
              value: selectedGroup,
              onChanged: (String? newValue) {
                setState(() {
                  selectedGroup = newValue!;
                });
              },
              items:
                  passengerGroups.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              decoration: const InputDecoration(
                labelText: 'Passenger Group',
              ),
            ),

            // or CheckboxListTile for multiple selections
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: _showConfirmationDialog,
              child: const Text('Send Notification'),
            ),
          ],
        ),
      ),
    );
  }
}

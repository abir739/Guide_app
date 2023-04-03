import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import '../components/custom_textfield.dart';

//push notification

/*import 'package:firebase_messaging/firebase_messaging.dart';

final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

Future<void> _sendNotification() async {
  try {
    await _firebaseMessaging.requestPermission();
    String? token = await _firebaseMessaging.getToken();
    String title = "New Activity Notification";
    String message = "A new activity has been added";
    // Replace with the recipient's FCM token
    String recipientToken = "recipient_token_here";
    // Construct the message payload
    var payload = {
      "notification": {
        "title": title,
        "body": message,
      },
      "to": recipientToken,
    };
    // Send the message
    await http.post(
      Uri.parse("https://fcm.googleapis.com/fcm/send"),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "key=your_server_key_here",
      },
      body: json.encode(payload),
    );
  } catch (e) {
    print(e);
  }
}*/

class NewActivity extends StatefulWidget {
  const NewActivity({Key? key}) : super(key: key);

  @override
  _NewActivityState createState() => _NewActivityState();
}

class _NewActivityState extends State<NewActivity> {
  final _formKey = GlobalKey<FormState>();
  late String _activityName;
  late String _activityDescription;
  File? _imageFile;
  bool _pressed = false;
  bool _isNotificationPressed = false; // Define the variable here
  late FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin;

  @override
  void initState() {
    super.initState();
    _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    var initializationSettingsAndroid =
        AndroidInitializationSettings('app_icon');
    var initializationSettingsIOS = IOSInitializationSettings(
        onDidReceiveLocalNotification: (id, title, body, payload) async {});
    var initializationSettings = InitializationSettings(
        android: initializationSettingsAndroid, iOS: initializationSettingsIOS);
    _flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: (String? payload) async {});
  }

  Future<void> _pickImage(ImageSource source) async {
    final pickedFile = await ImagePicker().pickImage(source: source);
    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
    }
  }

  void _sendNotification() async {
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
      'channel_id',
      'channel_name',
      'channel_description',
      importance: Importance.max,
      priority: Priority.high,
      ticker: 'ticker',
      icon: 'app_icon',
    );
    var iOSPlatformChannelSpecifics = IOSNotificationDetails();
    var platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
      iOS: iOSPlatformChannelSpecifics,
    );
    await _flutterLocalNotificationsPlugin.show(
      0,
      'New Activity',
      'A new activity has been created!',
      platformChannelSpecifics,
      payload: 'item x',
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: SvgPicture.asset(
          'assets/images/Logo.svg',
          fit: BoxFit.cover,
          height: 36.0,
        ),
        backgroundColor: Color.fromARGB(255, 207, 207, 219),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'New Activity',
                  style: TextStyle(
                    fontSize: 27.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16.0),
                CustomTextField(
                  /*prefixIcon: Icon(
                    Icons.location_city,
                    size: 18,
                  ),*/
                  labelText: "Activity name",
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a name for the activity';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _activityName = value!;
                  },
                ),
                const SizedBox(height: 16.0),
                CustomTextField(
                  prefixIcon: Icon(
                    Icons.alarm_rounded,
                    size: 18,
                  ),
                  labelText: "Time",
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a time for the activity';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    // Save the time
                  },
                ),
                const SizedBox(height: 16.0),
                CustomTextField(
                  prefixIcon: Icon(
                    Icons.location_city,
                    size: 18,
                  ),
                  labelText: "Place",
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a place for the activity';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    // Save the place
                  },
                ),
                const SizedBox(height: 16.0),
                GestureDetector(
                  onTap: () {
                    // Open the image picker
                    _pickImage(ImageSource.gallery);
                    setState(() {
                      _isNotificationPressed = true;
                    });
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                    ),
                    padding: EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        Icon(Icons.cloud_upload),
                        const SizedBox(height: 8.0),
                        Text('Upload a File or an Image'),
                      ],
                    ),
                  ),
                ),
                if (_imageFile != null) ...[
                  const SizedBox(height: 16.0),
                  Image.file(
                    _imageFile!,
                    fit: BoxFit.cover,
                  ),
                ],
                const SizedBox(height: 16.0),
                Row(
                  children: [
                    Text(
                      'Notification',
                      style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(width: 8.0),
                    Switch(
                      value: _isNotificationPressed,
                      onChanged: (value) {
                        setState(() {
                          _isNotificationPressed = value;
                        });
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 16.0),
                CustomTextField(
                  prefixIcon: Icon(
                    Icons.attach_money_outlined,
                    size: 18,
                  ),
                  labelText: "Price",
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a price for the activity';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    // Save the time
                  },
                ),
                const SizedBox(height: 16.0),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      // Save the new work
                      if (_isNotificationPressed) {
                        // Send a notification
                      }
                      Navigator.of(context).pop();
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Color.fromARGB(255, 180, 58, 105),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  child: Text(
                    'Créer',
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 252, 250, 250),
                    ),
                  ),
                ),
                const SizedBox(height: 16.0),
                ElevatedButton(
                  onPressed: () {
                    //annuler la création de new activity
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.grey[300],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  child: Text(
                    'Annuler',
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

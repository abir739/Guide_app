import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:url_launcher/url_launcher.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
  String _place = '';
  late String _activityName;
  late String _activityDescription;
  File? _imageFile;
  final bool _pressed = false;
  bool _isNotificationPressed = false; // Define the variable here
  late FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin;

  TextEditingController placeController = TextEditingController();

  void launchMaps(String query) async {
    String mapsQuery = Uri.encodeFull(query);
    String mapsUrl =
        "https://www.google.com/maps/search/?api=1&query=$mapsQuery";
    if (await canLaunch(mapsUrl)) {
      await launch(mapsUrl);
    } else {
      throw 'Could not launch $mapsUrl';
    }
  }

  @override
  void initState() {
    super.initState();
    _getSavedPlace();
    _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    var initializationSettingsAndroid =
        const AndroidInitializationSettings('app_icon');
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
    var androidPlatformChannelSpecifics = const AndroidNotificationDetails(
      'channel_id',
      'channel_name',
      'channel_description',
      importance: Importance.max,
      priority: Priority.high,
      ticker: 'ticker',
      icon: 'app_icon',
    );
    var iOSPlatformChannelSpecifics = const IOSNotificationDetails();
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

  void _getSavedPlace() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? savedPlace = prefs.getString('selectedPlace');
    if (savedPlace != null) {
      setState(() {
        _place = savedPlace;
        placeController.text = savedPlace;
      });
    }
  }

  void _saveSelectedPlace(String place) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('selectedPlace', place);
  }

  void _launchMaps() async {
    final String mapsUrl =
        'https://www.google.com/maps/search/?api=1&query=$_place';
    if (await canLaunch(mapsUrl)) {
      await launch(mapsUrl);
    } else {
      Fluttertoast.showToast(msg: 'Could not open the map.');
    }
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
        backgroundColor: const Color.fromARGB(255, 207, 207, 219),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Text(
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
                  prefixIcon: const Icon(
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
                TextFormField(
                  controller: placeController,
                  decoration: InputDecoration(
                    labelText: 'Place',
                    hintText: 'Search for a place',
                    suffixIcon: IconButton(
                      icon: const Icon(Icons.search),
                      onPressed: () async {
                        final String mapsUrl =
                            'https://www.google.com/maps/search/?api=1&query=${placeController.text}';
                        if (await canLaunch(mapsUrl)) {
                          await launch(mapsUrl);
                          setState(() {
                            _place = placeController.text;
                          });
                          _saveSelectedPlace(_place);
                        } else {
                          Fluttertoast.showToast(
                              msg: 'Could not open the map.');
                        }
                      },
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a place for the activity';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16.0),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      // submit form
                    }
                  },
                  child: const Text('Save'),
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
                    padding: const EdgeInsets.all(16.0),
                    child: const Column(
                      children: [
                        Icon(Icons.cloud_upload),
                        SizedBox(height: 8.0),
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
                    const Text(
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
                  prefixIcon: const Icon(
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
                    backgroundColor: const Color.fromARGB(255, 180, 58, 105),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  child: const Text(
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
                    backgroundColor: Colors.grey[300],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  child: const Text(
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

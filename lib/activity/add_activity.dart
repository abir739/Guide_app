import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'dart:io';
import 'package:url_launcher/url_launcher.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';


import '../components/custom_textfield.dart';


class NewActivity extends StatefulWidget {
  final Function(Map<String, dynamic>) onActivityAdded; // Add this line

  const NewActivity({Key? key, required this.onActivityAdded}) : super(key: key); // Modify the constructor

  @override
  _NewActivityState createState() => _NewActivityState();
}

class _NewActivityState extends State<NewActivity> {
  final _formKey = GlobalKey<FormState>();
  DateTime _dateTime = DateTime.now();

  String _place = '';
  late String _activityName;
  File? _imageFile;

  bool _isNotificationPressed = false;
  bool _isExtraPressed = false; // Define the variable here

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
  }

  Future<void> _pickImage(ImageSource source) async {
    final pickedFile = await ImagePicker().pickImage(source: source);
    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
    }
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

  Future<void> _selectDateTime(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != _dateTime) {
      setState(() {
        _dateTime = picked;
      });
    }

    final TimeOfDay? timePicked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (timePicked != null) {
      final DateTime combinedDateTime = DateTime(_dateTime.year,
          _dateTime.month, _dateTime.day, timePicked.hour, timePicked.minute);

      setState(() {
        _dateTime = combinedDateTime;
      });
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
                    if (_dateTime == null) {
                      return 'Please enter a time for the activity';
                    }
                    return null;
                  },
                  onTap: () => _selectDateTime(context),
                  controller: TextEditingController(
                    text: _dateTime != null
                        ? DateFormat('MM/dd/yyyy hh:mm a').format(_dateTime)
                        : '',
                  ),
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
                const SizedBox(height: 8.0),
                const Text(
                  'Get notified when someones posts a comment on a posting.',
                  style: TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 100, 99, 99),
                  ),
                ),
                const SizedBox(height: 16.0),
                Row(
                  children: [
                    const Text(
                      'Extra',
                      style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(width: 8.0),
                    Switch(
                      value: _isExtraPressed,
                      onChanged: (value) {
                        setState(() {
                          _isExtraPressed = value;
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
                      // Save the new activity
                      _formKey.currentState!.save();

                      // Do something with the form data, e.g. send to a server
                      print(_activityName);
                      print(_dateTime.toString());
                      print(_place);

                      // Navigate back to the previous screen
                      Navigator.of(context).pop();

                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text("New activity created"),
                            actions: <Widget>[
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: const Text("OK"),
                              ),
                            ],
                          );
                        },
                      );
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
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text("Are you sure you want to cancel?"),
                          actions: <Widget>[
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: const Text("No"),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                                Navigator.of(context).pop();
                              },
                              child: const Text("Yes"),
                            ),
                          ],
                        );
                      },
                    );
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

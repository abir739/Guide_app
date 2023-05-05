import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:url_launcher/url_launcher.dart';

import '../components/custom_textfield.dart';

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

  Future<void> _pickImage(ImageSource source) async {
    final pickedFile = await ImagePicker().pickImage(source: source);
    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
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
                CustomTextField(
                  prefixIcon: const Icon(
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
                const Text(
                  'Place',
                  style: TextStyle(fontSize: 18.0),
                ),
                const SizedBox(height: 8.0),
                TextFormField(
                  controller: placeController,
                  decoration: const InputDecoration(
                    hintText: 'Enter a place',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 16.0),
                ElevatedButton(
                  onPressed: () {
                    launchMaps(placeController.text);
                  },
                  child: const Text('Open Maps to search for a place'),
                ),
                const SizedBox(height: 16.0),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      // Save the new work

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

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

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
        title: Text('New Activity'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Activity Name',
                ),
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
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Time',
                ),
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
                decoration: InputDecoration(
                  labelText: 'Place',
                ),
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
                  //padding: const EdgeInsets.symmetric(
                  //vertical: 16.0, horizontal: 8.0),
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
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    // Save the new work
                    Navigator.of(context).pop();
                  }
                },
                child: Text('Save Activity'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

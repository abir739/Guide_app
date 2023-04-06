import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../NetworkHandler.dart';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:guide_app/models/activity_http_handler.dart';

class AddClientScreen extends StatefulWidget {
  @override
  _AddClientScreenState createState() => _AddClientScreenState();
}

class _AddClientScreenState extends State<AddClientScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _prenameController = TextEditingController();
  final _telephoneController = TextEditingController();
  final _passportController = TextEditingController();
  final storage = FlutterSecureStorage();
  NetworkHandler networkHandler = NetworkHandler();

  late String clientName;
  late String clientPrename;
  late String clientTelephone;
  late String clientPassport;

  @override
  void dispose() {
    _nameController.dispose();
    _prenameController.dispose();
    _telephoneController.dispose();
    _passportController.dispose();
    super.dispose();
  }

  void _submitForm() async {
    String? token = await storage.read(key: "access_token");
    final name = _nameController.text;
    final prename = _prenameController.text;
    final tele = _telephoneController.text;
    final passport = _passportController.text;

    // TODO: Send the form data to a server using a POST request
    // You can use a package like http or dio to make the request
    // Here's an example using the http package:
    http.post(
      Uri.parse('https://example.com/api/clients'),
      headers: {
        "Content-type": "application/json",
        "Authorization": "Bearer $token"
      },
      body: {
        'name': name,
        'prename': prename,
        'tele': tele,
        'passport': passport,
      },
    ).then((response) {
      if (response.statusCode == 200) {
        // Handle success
      } else {
        // Handle error
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [],
        backgroundColor: Color.fromRGBO(212, 5, 5, 0.976),
        title: Text("Add Client "),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(
                  labelText: 'Name',
                  hintText: 'Enter your name',
                  prefixIcon: Icon(Icons.person),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter your name';
                  }
                  return null;
                },
                onSaved: (value) {
                  clientName = value!;
                },
              ),
              SizedBox(height: 30),
              TextFormField(
                controller: _prenameController,
                decoration: InputDecoration(
                  labelText: 'Prename',
                  hintText: 'Enter your prename',
                  prefixIcon: Icon(Icons.person),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter your prename';
                  }
                  return null;
                },
                onSaved: (value) {
                  clientPrename = value!;
                },
              ),
              SizedBox(height: 30),
              TextFormField(
                controller: _telephoneController,
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  labelText: 'Telephone',
                  hintText: 'Enter your telephone number',
                  prefixIcon: Icon(Icons.phone),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter your telephone number';
                  }
                  return null;
                },
                onSaved: (value) {
                  clientTelephone = value!;
                },
              ),
              SizedBox(height: 30),
              TextFormField(
                controller: _passportController,
                decoration: InputDecoration(
                  labelText: 'Passport',
                  hintText: 'Enter your passport number',
                  prefixIcon: Icon(Icons.credit_card),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter your passport number';
                  }
                  return null;
                },
                onSaved: (value) {
                  clientPassport = value!;
                },
              ),
              SizedBox(height: 30),
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(Colors.red),
                  textStyle: MaterialStateProperty.all<TextStyle>(
                    TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                      side: BorderSide(color: Colors.blue),
                    ),
                  ),
                ),
                child: Text('Save'),
                onPressed: () async {
                  /*
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();

                    // we will send the data to rest server
                    Map<String, String> data = {
                      "name": _nameController.text,
                      "prename": _prenameController.text,
                      "tele": _telephoneController.text,
                      "passport": _passportController.text,
                    };
                    print(data);
                    var responseRegister = await networkHandler.post(
                        "/api/v1/users/addclient", data);
                    if (responseRegister.statusCode != 200 ||
                        responseRegister.statusCode != 201) {
                      final snackBar = SnackBar(
                        /// need to set following properties for best effect of awesome_snackbar_content
                        elevation: 0,
                        behavior: SnackBarBehavior.floating,
                        backgroundColor: Colors.transparent,
                        content: AwesomeSnackbarContent(
                          title:
                              'check user api url',
                          message: '/api/v1/users/addclient", $data',

                          /// change contentType to ContentType.success, ContentType.warning or ContentType.help for variants
                          contentType: ContentType.warning,
                        ),
                      );
                      ScaffoldMessenger.of(context)
                        ..hideCurrentSnackBar()
                        ..showSnackBar(snackBar);
                      _nameController.clear();
         _prenameController.clear();
              _telephoneController.clear();
                   _passportController.clear();
}
                    // TODO: save client data to database
                    // Navigator.of(context).pop();
                  }
                */
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

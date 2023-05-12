import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // Import the intl package for date formatting

import '../models/users_model.dart';
import 'package:http/http.dart' as http;

class AddUserScreen extends StatefulWidget {
  final List<User> usersList;
  final Function(User) onUserAdded; // New callback function

  const AddUserScreen({
    required Key key,
    required this.usersList,
    required this.onUserAdded,
  }) : super(key: key);

  @override
  _AddUserScreenState createState() => _AddUserScreenState();
}

class _AddUserScreenState extends State<AddUserScreen> {
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _birthDateController = TextEditingController();
  final TextEditingController _countryController = TextEditingController();
  late DateTime _selectedDate = DateTime.now(); // Initialize with current date
  
  void _addUser() {
    // Get the user input from the text fields
    String firstName = _firstNameController.text;
    String lastName = _lastNameController.text;
    String phone = _phoneController.text;
    String email = _emailController.text;
    String birthDate = _birthDateController.text;
    String country = _countryController.text;

    // Create a new User object with the input values
    User newUser = User(
      // User properties...
      id: '',
      role: '',
      username: '',
      password: '',
      salt: '',
      phone: _phoneController.text,
      email: _emailController.text,
      gender: '',
      firstName: _firstNameController.text,
      lastName: _lastNameController.text,
      birthDate: _birthDateController.text,
      picture: '',
      address: '',
      zipCode: '',
      countryId: _countryController.text,
      stateId: '',
      cityId: '',
      languageId: '',
      secondLanguageId: '',
      facebookKey: '',
      profile: '',
      enableOauth: false,
      sessionTimeout: 0,
      multipleSession: false,
      phoneValidated: false,
      phoneValidationCode: '',
      emailValidated: false,
      emailValidationCode: '',
      authenticationMode: '',
      enabled: true,
      confirmationToken: '',
      passwordRequestedAt: {},
      locked: false,
      expired: false,
      expiresAt: {},
      credentialsExpired: false,
      credentialsExpireAt: {},
      lastLogin: {},
      lastFailedLogin: {},
      loginCount: 0,
      failedLoginCount: 0,
      lastFailedLoginCount: 0,
      createdAt: {},
      creatorUserId: '',
      updatedAt: {},
      updaterUserId: '',
      isSelected: false,
    );

    // Add the new user to the _users list in the ClientScreen
    widget.onUserAdded(newUser); // Invoke the onUserAdded callback

    // Navigate back to the ClientScreen
    Navigator.pop(context);
  }

  Future<void> _selectDate() async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );

    if (pickedDate != null) {
      setState(() {
        _selectedDate = pickedDate;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add User'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextField(
                controller: _firstNameController,
                decoration: InputDecoration(labelText: 'First Name'),
              ),
              TextField(
                controller: _lastNameController,
                decoration: InputDecoration(labelText: 'Last Name'),
              ),
              TextField(
                controller: _phoneController,
                decoration: InputDecoration(labelText: 'Phone'),
              ),
              TextField(
                controller: _emailController,
                decoration: InputDecoration(labelText: 'Email'),
              ),
              GestureDetector(
                onTap: _selectDate, // Open the date picker on tap
                child: AbsorbPointer(
                  child: TextField(
                    controller: _birthDateController
                      ..text = _selectedDate != null
                          ? DateFormat('yyyy-MM-dd').format(_selectedDate)
                          : '',
                    decoration: InputDecoration(labelText: 'BirthDate'),
                    readOnly: true, // Make the text field read-only
                    onTap: () {
                      _birthDateController
                          .clear(); // Clear the text field when tapped
                      _selectDate(); // Open the date picker on tap
                    },
                    scrollPhysics:
                        NeverScrollableScrollPhysics(), // Prevent the text field from scrolling
                  ),
                ),
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: _addUser,
                child: Text('Add'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

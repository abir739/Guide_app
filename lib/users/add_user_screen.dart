import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // Import the intl package for date formatting

import '../models/users_model.dart';
import 'package:http/http.dart' as http;

class Country {
  final String name;
  final String flagUrl;

  Country({
    required this.name,
    required this.flagUrl,
  });
}

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
  late DateTime _selectedDate = DateTime.now(); // Initialize with current date
  late Country _selectedCountry = Country(name: '', flagUrl: '');
  List<Country> _countriesList = [];

  @override
  void initState() {
    super.initState();
    fetchCountries(); // Fetch the list of countries when the screen initializes
  }

  Future<void> fetchCountries() async {
    final response =
        await http.get(Uri.parse('https://api.example.com/countries'));

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      setState(() {
        _countriesList = data
            .map((countryData) => Country(
                  name: countryData['name'],
                  flagUrl: countryData['flag_url'],
                ))
            .toList();
        _selectedCountry =
            _countriesList[0]; // Select the first country by default
      });
    } else {
      throw Exception('Failed to fetch countries');
    }
  }

  void _addUser() {
    String firstName = _firstNameController.text;
    String lastName = _lastNameController.text;
    String phone = _phoneController.text;
    String email = _emailController.text;
    String birthDate = _birthDateController.text;

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
      countryId: _selectedCountry.name,
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
              DropdownButtonFormField<Country>(
                value: _selectedCountry,
                items: _countriesList.map((Country country) {
                  return DropdownMenuItem<Country>(
                    value: country,
                    child: Row(
                      children: [
                        Image.network(
                          country.flagUrl,
                          width: 24,
                          height: 24,
                        ),
                        SizedBox(width: 8.0),
                        Text(country.name),
                      ],
                    ),
                  );
                }).toList(),
                onChanged: (Country? selectedCountry) {
                  setState(() {
                    _selectedCountry = selectedCountry!;
                  });
                },
                decoration: InputDecoration(labelText: 'Country'),
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

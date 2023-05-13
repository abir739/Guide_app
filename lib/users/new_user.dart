import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart'; // Import the intl package for date formatting

import '../models/users_model.dart';
import 'package:circle_flags/circle_flags.dart'; // Import the flag package for flag icons

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

  //List<String> languages = ['English', 'Spanish', 'French', 'German'];
  List<Map<String, String>> languages = [
    {'name': 'Arabic', 'code': 'SA'},
    {'name': 'English', 'code': 'US'},
    {'name': 'Spanish', 'code': 'ES'},
    {'name': 'French', 'code': 'FR'},
    {'name': 'German', 'code': 'DE'},
    {'name': 'Chinese', 'code': 'CN'},
    {'name': 'Japanese', 'code': 'JP'},
    {'name': 'Russian', 'code': 'RU'},
  ];
  List<Map<String, String>> secondLanguages = [
    {'name': 'Arabic', 'code': 'SA'},
    {'name': 'English', 'code': 'US'},
    {'name': 'Spanish', 'code': 'ES'},
    {'name': 'French', 'code': 'FR'},
    {'name': 'German', 'code': 'DE'},
    {'name': 'Chinese', 'code': 'CN'},
    {'name': 'Japanese', 'code': 'JP'},
    {'name': 'Russian', 'code': 'RU'},
  ];
  List<Map<String, String>> contries = [
    {'name': 'Palestine', 'code': 'ps'},
    {'name': 'Bahrain', 'code': 'bh'},
    {'name': 'Belgium', 'code': 'be'},
    {'name': 'Canada', 'code': 'ca'},
    {'name': 'China ', 'code': 'cn'},
    {'name': 'Germany', 'code': 'DE'},
    {'name': 'Denmark', 'code': 'dk'},
    {'name': 'Algeria', 'code': 'dz'},
    {'name': 'Spain', 'code': 'ES'},
    {'name': 'France', 'code': 'fr'},
    {'name': 'United Kingdom', 'code': 'gb'},
    {'name': 'Iraq', 'code': 'iq'},
    {'name': 'Italy', 'code': 'it'},
    {'name': 'Japan', 'code': 'jp'},
    {'name': 'South Korea', 'code': 'kr'},
    {'name': 'Kuwait', 'code': 'kw'},
    {'name': 'Lebanon', 'code': 'lb'},
    {'name': 'Morocco', 'code': 'ma'},
    {'name': 'Malaysia', 'code': 'my'},
    {'name': 'New Zealand', 'code': 'nz'},
    {'name': 'Oman', 'code': 'om'},
    {'name': 'Pakistan', 'code': 'pk'},
    {'name': 'United States of America', 'code': 'us'},
    {'name': 'Turkey', 'code': 'tr'},
    {'name': 'Tunisia', 'code': 'tn'},
    {'name': 'Syria', 'code': 'sy'},
    {'name': 'Sudan', 'code': 'sd'},
    {'name': 'Saudi Arabia', 'code': 'sa'},
    {'name': 'Russia', 'code': 'ru'},
    {'name': 'Qatar', 'code': 'qa'},
  ];
  String selectedLanguage = 'Arabic';
  String selectedsecondLanguage = 'English';
  String selectedCountry = 'Palestine';

  @override
  void initState() {
    super.initState();
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
      countryId: selectedCountry,
      stateId: '',
      cityId: '',
      languageId: selectedLanguage,
      secondLanguageId: selectedsecondLanguage,
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
      // appBar: AppBar(
      //   title: const Text('Add User'),
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
                width: 50.0), // Add spacing between the logo and the text
            const Text('New Client'),
          ],
        ),
        backgroundColor: const Color.fromARGB(255, 207, 207, 219),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextField(
                controller: _firstNameController,
                decoration: const InputDecoration(labelText: 'First Name'),
              ),
              TextField(
                controller: _lastNameController,
                decoration: const InputDecoration(labelText: 'Last Name'),
              ),
              TextField(
                controller: _phoneController,
                decoration: const InputDecoration(labelText: 'Phone'),
              ),
              TextField(
                controller: _emailController,
                decoration: const InputDecoration(labelText: 'Email'),
              ),
              GestureDetector(
                onTap: _selectDate, // Open the date picker on tap
                child: AbsorbPointer(
                  child: TextField(
                    controller: _birthDateController
                      ..text = _selectedDate != null
                          ? DateFormat('yyyy-MM-dd').format(_selectedDate)
                          : '',
                    decoration: const InputDecoration(labelText: 'BirthDate'),
                    readOnly: true, // Make the text field read-only
                    onTap: () {
                      _birthDateController
                          .clear(); // Clear the text field when tapped
                      _selectDate(); // Open the date picker on tap
                    },
                    scrollPhysics:
                        const NeverScrollableScrollPhysics(), // Prevent the text field from scrolling
                  ),
                ),
              ),
              DropdownButtonFormField<String>(
                value: selectedCountry,
                decoration: const InputDecoration(labelText: 'Country Name'),
                items: contries.map((Map<String, String> country) {
                  return DropdownMenuItem<String>(
                    value: country['name']!,
                    child: Row(
                      children: [
                        CircleFlag(
                          country['code']!,
                          size: 28,
                        ),
                        const SizedBox(width: 8),
                        Text(country['name']!),
                      ],
                    ),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    selectedCountry = newValue!;
                  });
                },
              ),
              DropdownButtonFormField<String>(
                value: selectedLanguage,
                decoration: const InputDecoration(labelText: 'Language'),
                items: languages.map((Map<String, String> language) {
                  return DropdownMenuItem<String>(
                    value: language['name']!,
                    child: Row(
                      children: [
                        CircleFlag(
                          language['code']!,
                          size: 28,
                        ),
                        const SizedBox(width: 8),
                        Text(language['name']!),
                      ],
                    ),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    selectedLanguage = newValue!;
                  });
                },
              ),
              DropdownButtonFormField<String>(
                value: selectedsecondLanguage,
                decoration: const InputDecoration(labelText: 'Second Language'),
                items: secondLanguages.map((Map<String, String> language) {
                  return DropdownMenuItem<String>(
                    value: language['name']!,
                    child: Row(
                      children: [
                        CircleFlag(
                          language['code']!,
                          size: 28,
                        ),
                        const SizedBox(width: 8),
                        Text(language['name']!),
                      ],
                    ),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    selectedsecondLanguage = newValue!;
                  });
                },
              ),
              const SizedBox(height: 16.0),
              // ElevatedButton(
              //   onPressed: _addUser,
              //   child: const Text('Add'),
              // ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: const Color(0xFFEB5F52),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                onPressed: _addUser,
                child: const Center(
                  child: Text(
                    'Add User',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

import '../models/users_model.dart';

class AddUserScreen extends StatefulWidget {
  final List<User> usersList;
  final Function(User) onUserAdded;

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

  String? _selectedLanguage;
  List<Language> _languages = []; // Initialize an empty list

  late DateTime _selectedDate = DateTime.now();

  @override
  void initState() {
    super.initState();
    _fetchLanguages(); // Fetch the languages when the screen initializes
  }

  Future<void> _fetchLanguages() async {
    final url =
        Uri.parse('https://api.zenify-trip.continuousnet.com/api/languages');

    final response = await http.get(
      url,
      headers: {
        'Authorization':
            'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjFlY2I1ZjJiLTZiNWMtNDk4OS1hNzQ3LWIyOWUzODgyMTZlOSIsInN1YiI6IjFlY2I1ZjJiLTZiNWMtNDk4OS1hNzQ3LWIyOWUzODgyMTZlOSIsInVzZXJuYW1lIjoic2E3Ym9vY2giLCJlbWFpbCI6InNhN2Jvb2NoQGdtYWlsLmNvbSIsInJvbGUiOiJBZG1pbmlzdHJhdG9yIiwiZmlyc3ROYW1lIjoiU2FoYmkiLCJsYXN0TmFtZSI6IktoYWxmYWxsYWgiLCJleHBpcmVzIjoxNjg0MDU2NTQ5LCJjcmVhdGVkIjoxNjgzOTcwMTQ5LCJpYXQiOjE2ODM5NzAxNDksImV4cCI6MTY4NDA1NjU0OX0.ZkrhJ1aQ7YZgoBLz8CQVJAF6Mudvs62vMT2WmcDdH_0'
      },
    );

    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      final List<dynamic> languageData = jsonData['data'];

      setState(() {
        _languages =
            languageData.map((data) => Language.fromJson(data)).toList();
      });
    } else {
      // Handle the API request error
      print('Failed to fetch languages');
    }
  }

  void _addUser() {
    String firstName = _firstNameController.text;
    String lastName = _lastNameController.text;
    String phone = _phoneController.text;
    String email = _emailController.text;
    String birthDate = _birthDateController.text;

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
      countryId: '',
      stateId: '',
      cityId: '',
      languageId: _selectedLanguage ?? '',
      secondLanguageId: _selectedLanguage ?? '',
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
      facebookKey: '',
    );

    widget.onUserAdded(newUser);

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
        title: const Text('Add User'),
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
                onTap: _selectDate,
                child: AbsorbPointer(
                  child: TextField(
                    controller: _birthDateController
                      ..text = _selectedDate != null
                          ? DateFormat('yyyy-MM-dd').format(_selectedDate)
                          : '',
                    decoration: const InputDecoration(labelText: 'BirthDate'),
                    readOnly: true,
                    onTap: () {
                      _birthDateController.clear();
                      _selectDate();
                    },
                    scrollPhysics: const NeverScrollableScrollPhysics(),
                  ),
                ),
              ),
              DropdownButtonFormField<String>(
                value: _selectedLanguage,
                items: _languages.map((Language language) {
                  return DropdownMenuItem<String>(
                    value: language.name,
                    child: Row(
                      children: [
                        Image.network(
                          language.flagUrl,
                          width: 24,
                          height: 24,
                          fit: BoxFit.cover,
                        ),
                        const SizedBox(width: 8.0),
                        Text(language.name),
                      ],
                    ),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedLanguage = value;
                  });
                },
                decoration: const InputDecoration(labelText: 'Language'),
              ),
              const SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: _addUser,
                child: const Text('Add'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Language {
  final String name;
  final String flagUrl;

  Language({required this.name, required this.flagUrl});

  factory Language.fromJson(Map<String, dynamic> json) {
    return Language(
      name: json['name'],
      flagUrl: json['flagUrl'],
    );
  }
}

import 'package:flutter/material.dart';

import '../models/users_model.dart';



class AddUserScreen extends StatefulWidget {
  final List<User> usersList;

  const AddUserScreen({required Key key, required this.usersList}) : super(key: key);

  @override
  _AddUserScreenState createState() => _AddUserScreenState();
}

class _AddUserScreenState extends State<AddUserScreen> {
  TextEditingController _firstNameController = TextEditingController();
  TextEditingController _lastNameController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
void _addUser() {
  // Get the user input from the text fields
  String firstName = _firstNameController.text;
  String lastName = _lastNameController.text;
  String phone = _phoneController.text;

  // Create a new User object with the input values
  User newUser = User(
    firstName: firstName,
    lastName: lastName,
    phone: phone,
  );

  // Add the new user to the _users list in the ClientScreen
  setState(() {
    widget.usersList.add(newUser);
  });

  // Navigate back to the ClientScreen
  Navigator.pop(context);
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add User'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
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
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: _addUser,
              child: Text('Add'),
            ),
          ],
        ),
      ),
    );
  }
}

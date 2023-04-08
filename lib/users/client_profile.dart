import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'dart:convert';

import '../models/users_model.dart';
import '../notification/notification.dart';
import 'client_list.dart';

class ProfileScreen extends StatelessWidget {
  final User user;

  ProfileScreen({required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: SvgPicture.asset(
          'assets/images/Logo.svg',
          fit: BoxFit.cover,
          height: 36.0,
        ),
        backgroundColor: Color.fromARGB(255, 207, 207, 219),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.notifications),
            onPressed: () {
              // Navigate to notifications screen when button is pressed
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => NotificationsScreen()),
              );
            },
          ),
          IconButton(
            icon: Icon(Icons.menu),
            onPressed: () {
              // Show menu options when button is pressed
              _showMenu(context);
            },
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 0.5),
            Text(
              'Client Profile',
              style: TextStyle(
                fontSize: 27.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 14.0),
            CircleAvatar(
              backgroundImage: NetworkImage(user.picture),
              radius: 63.0,
            ),
            SizedBox(height: 10.0),
            Text(
              '${user.firstName} ${user.lastName}',
              style: TextStyle(fontSize: 24.0),
            ),
            SizedBox(height: 5.0),
            Text.rich(
              TextSpan(
                text: 'ID: ',
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
                children: [
                  TextSpan(
                    text: '${user.id}',
                    style: TextStyle(fontSize: 12.0),
                  ),
                ],
              ),
            ),
            SizedBox(height: 10.0),
            Row(
              children: [
                Expanded(
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 10.0),
                    height: 2.0,
                    color: Colors.grey[300],
                  ),
                ),
              ],
            ),
            SizedBox(height: 10.0),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(width: 10.0),
                Expanded(
                  child: Text(
                    'Email: ${user.email}',
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 15.0),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(width: 10.0),
                Expanded(
                  child: Text(
                    'Phone: ${user.phone}',
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 15.0),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(width: 10.0),
                Expanded(
                  child: Text(
                    'BirthDate: ${user.birthDate}',
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 15.0),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(width: 10.0),
                Expanded(
                  child: Text(
                    'Address: ${user.address}',
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 15.0),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(width: 10.0),
                Expanded(
                  child: Text(
                    'ZipCode: ${user.zipCode}',
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 15.0),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(width: 10.0),
                Expanded(
                  child: Text(
                    'Country: ${user.countryId}',
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 15.0),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(width: 10.0),
                Expanded(
                  child: Text(
                    'language: ${user.languageId}',
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 15.0),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(width: 10.0),
                Expanded(
                  child: Text(
                    'Second Language: ${user.secondLanguageId}',
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 65.0),
            /* ElevatedButton(
              child: Text('View Profile'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ProfileScreen(user: user),
                  ),
                );
              },
            ),*/
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                GestureDetector(
                  child: Container(
                    padding: EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      color: Colors.blue[400],
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    child: Icon(
                      Icons.phone,
                      color: Colors.white,
                    ),
                  ),
                  onTap: () {
                    // TODO: Call the user
                  },
                ),
                GestureDetector(
                  child: Container(
                    padding: EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      color: Colors.red[400],
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    child: Icon(
                      Icons.mail,
                      color: Colors.white,
                    ),
                  ),
                  onTap: () {
                    // TODO: Send email to the user
                  },
                ),
                GestureDetector(
                  child: Container(
                    padding: EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      color: Colors.green[400],
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    child: Icon(
                      Icons.messenger,
                      color: Colors.white,
                    ),
                  ),
                  onTap: () {
                    // TODO: Send message to the user
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

void _showMenu(BuildContext context) {
  showModalBottomSheet(
    context: context,
    backgroundColor: Colors.transparent,
    builder: (BuildContext context) {
      return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.0),
            topRight: Radius.circular(20.0),
          ),
          color: Color.fromARGB(255, 255, 255, 255),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: Icon(Icons.home),
              title: Text('Home'),
              onTap: () {
                // Navigate to home screen
                Navigator.pop(context);
                Navigator.pushReplacementNamed(context, '/home');
              },
            ),
            ListTile(
              leading: Icon(Icons.person),
              title: Text('Profile'),
              onTap: () {
                // Navigate to settings screen
                Navigator.pop(context);
                Navigator.pushNamed(context, '/profile');
              },
            ),
            ListTile(
              leading: Icon(Icons.calendar_month),
              title: Text('Schedule'),
              onTap: () {
                // Navigate to settings screen
                Navigator.pop(context);
                Navigator.pushNamed(context, '/Schedule');
              },
            ),
            ListTile(
              leading: Icon(Icons.groups),
              title: Text('Clients'),
              onTap: () {
                // Navigate to activites screen when pressed
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ClientScreen()),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.feedback),
              title: Text('Feedbacks'),
              onTap: () {
                // Navigate to settings screen
                Navigator.pop(context);
                Navigator.pushNamed(context, '/Feedbacks');
              },
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text('Settings'),
              onTap: () {
                // Navigate to settings screen
                Navigator.pop(context);
                Navigator.pushNamed(context, '/settings');
              },
            ),
            ListTile(
              leading: Icon(Icons.info),
              title: Text('About'),
              onTap: () {
                // Navigate to about screen
                Navigator.pop(context);
                Navigator.pushNamed(context, '/about');
              },
            ),
          ],
        ),
      );
    },
  );
}

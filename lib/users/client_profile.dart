import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../destination/destination_test.dart';
import '../models/users_model.dart';
import '../notification/notification.dart';
import '../planning/guide_plan.dart';
import '../planning/planing_list.dart';
import 'client_list.dart';
import 'package:url_launcher/url_launcher.dart';

class ProfileScreen extends StatelessWidget {
  final User user;

  const ProfileScreen({super.key, required this.user});

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
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.notifications),
            onPressed: () {
              // Navigate to notifications screen when button is pressed
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const NotificationsScreen()),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.menu),
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
            const SizedBox(height: 0.5),
            const Text(
              'Client Profile',
              style: TextStyle(
                fontSize: 27.0,
                fontWeight: FontWeight.bold,
                color: Color(0xFF3A3557),
              ),
            ),
            const SizedBox(height: 14.0),
            CircleAvatar(
              backgroundImage: user.picture.isNotEmpty
                  ? NetworkImage(user.picture) as ImageProvider<Object>?
                  : AssetImage('path_to_default_image')
                      as ImageProvider<Object>,
              radius: 63.0,
            ),

            const SizedBox(height: 10.0),
            Text(
              '${user.firstName} ${user.lastName}',
              style: const TextStyle(fontSize: 24.0),
            ),
            const SizedBox(height: 5.0),
            // Text.rich(
            //   TextSpan(
            //     text: 'ID: ',
            //     style: const TextStyle(
            //       fontSize: 18.0,
            //       fontWeight: FontWeight.bold,
            //     ),
            //     children: [
            //       TextSpan(
            //         text: user.id,
            //         style: const TextStyle(fontSize: 12.0),
            //       ),
            //     ],
            //   ),
            // ),
            const SizedBox(height: 10.0),
            Row(
              children: [
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 10.0),
                    height: 2.0,
                    color: Colors.grey[300],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10.0),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(width: 10.0),
                Expanded(
                  child: Text(
                    'Email: ${user.email}',
                    style: const TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 15.0),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(width: 10.0),
                Expanded(
                  child: Text(
                    'Phone: ${user.phone}',
                    style: const TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 15.0),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(width: 10.0),
                Expanded(
                  child: Text(
                    'BirthDate: ${user.birthDate}',
                    style: const TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 15.0),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(width: 10.0),
                Expanded(
                  child: Text(
                    'Address: ${user.address}',
                    style: const TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 15.0),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(width: 10.0),
                Expanded(
                  child: Text(
                    'ZipCode: ${user.zipCode}',
                    style: const TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 15.0),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(width: 10.0),
                Expanded(
                  child: Text(
                    'Country: ${user.countryId}',
                    style: const TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 15.0),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(width: 10.0),
                Expanded(
                  child: Text(
                    'language: ${user.languageId}',
                    style: const TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 15.0),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(width: 10.0),
                Expanded(
                  child: Text(
                    'Second Language: ${user.secondLanguageId}',
                    style: const TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 65.0),
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
                    padding: const EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      color: Colors.blue[400],
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    child: const Icon(
                      Icons.phone,
                      color: Colors.white,
                    ),
                  ),
                  onTap: () async {
                    // TODO: Call the user
                    Uri phoneno = Uri.parse('tel:${user.phone}');
                    if (await launchUrl(phoneno)) {
                      //dialer opened
                    } else {
                      //dailer is not opened
                    }
                  },
                ),
                GestureDetector(
                  child: Container(
                    padding: const EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      color: Colors.red[400],
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    child: const Icon(
                      Icons.mail,
                      color: Colors.white,
                    ),
                  ),
                  onTap: () async {
                    // TODO: Send email to the user
                    String email = Uri.encodeComponent(user.email);
                    String subject =
                        Uri.encodeComponent("Hello ${user.firstName}");
                    String body = Uri.encodeComponent(
                        "Hi! I'm Abir your Guide for the Trip");
                    print(subject); //output: Hello%20Flutter
                    Uri mail =
                        Uri.parse("mailto:$email?subject=$subject&body=$body");
                    if (await launchUrl(mail)) {
                      //email app opened
                    } else {
                      //email app is not opened
                    }
                  },
                ),
                GestureDetector(
                  child: Container(
                    padding: const EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      color: Colors.green[400],
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    child: const Icon(
                      Icons.messenger,
                      color: Colors.white,
                    ),
                  ),
                  onTap: () async {
                    // TODO: Send message to the user
                    Uri sms =
                        Uri.parse('sms:${user.phone}?body=your text here');
                    if (await launchUrl(sms)) {
                      //app opened
                    } else {
                      //app is not opened
                    }
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
        decoration: const BoxDecoration(
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
              leading: const Icon(Icons.home),
              title: const Text('Home'),
              onTap: () {
                // Navigate to home screen
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const PlanningListPage()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.playlist_add_circle_outlined),
              title: const Text('Destination'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const DestinationScreen()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.calendar_month),
              title: const Text('Schedule'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const ScheduleScreen()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.groups),
              title: const Text('Clients'),
              onTap: () {
                // Navigate to activites screen when pressed
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ClientScreen()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.feedback),
              title: const Text('Feedbacks'),
              onTap: () {
                // Navigate to settings screen
                Navigator.pop(context);
                Navigator.pushNamed(context, '/Feedbacks');
              },
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('Settings'),
              onTap: () {
                // Navigate to settings screen
                Navigator.pop(context);
                Navigator.pushNamed(context, '/settings');
              },
            ),
            ListTile(
              leading: const Icon(Icons.info),
              title: const Text('About'),
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

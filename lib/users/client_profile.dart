import 'dart:io';

import 'package:circle_flags/circle_flags.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:guide_app/about_page.dart';
import 'package:guide_app/menu.dart';

import '../destination/destination_test.dart';
import '../models/users_model.dart';
import '../notification/notification.dart';
// import '../planning/guide_plan.dart';
import '../planning/planing_list.dart';
import 'client_list.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:guide_app/planning/guide_plan_test.dart';
import 'package:guide_app/planning/guide_plan_test.dart';

import '../notification/create_notification.dart';

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
                  : const AssetImage('path_to_default_image'),
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
            // Row(
            //   crossAxisAlignment: CrossAxisAlignment.start,
            //   children: [
            //     const SizedBox(width: 10.0),
            //     Expanded(
            //       child: Text(
            //         'Country: ${user.countryId}',
            //         style: const TextStyle(
            //           fontSize: 16.0,
            //           fontWeight: FontWeight.w500,
            //         ),
            //       ),
            //     ),
            //   ],
            // ),

            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(width: 10.0),
                Expanded(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      //const SizedBox(width: 10.0),
                      Text(
                        'Country: ${user.countryId}',
                        style: const TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(width: 10.0),
                      CircleFlag(
                        '${user.countryId}',
                        size: 20,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            // const SizedBox(height: 15.0),
            // Row(
            //   crossAxisAlignment: CrossAxisAlignment.start,
            //   children: [
            //     const SizedBox(width: 10.0),
            //     Expanded(
            //       child: Text(
            //         'Language: ${user.languageId}',
            //         style: const TextStyle(
            //           fontSize: 16.0,
            //           fontWeight: FontWeight.w500,
            //         ),
            //       ),
            //     ),
            //   ],
            // ),
            const SizedBox(height: 15.0),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(width: 10.0),
                Expanded(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      //const SizedBox(width: 10.0),
                      Text(
                        'Language: ${user.languageId}',
                        style: const TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(width: 10.0),
                      CircleFlag(
                        '${user.languageId}',
                        size: 20,
                      ),
                    ],
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
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      //const SizedBox(width: 10.0),
                      Text(
                        'Second Language: ${user.secondLanguageId}',
                        style: const TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(width: 10.0),
                      CircleFlag(
                        '${user.secondLanguageId}',
                        size: 20,
                      ),
                    ],
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
  final Color primary = Colors.white;
  final Color active = Colors.black;

  double screenHeight = MediaQuery.of(context).size.height;

  showModalBottomSheet(
    context: context,
    backgroundColor: Colors.transparent,
    isScrollControlled: true,
    builder: (BuildContext context) {
      return SizedBox(
        width: MediaQuery.of(context).size.width * 0.8, // Set the desired width
        child: Container(
          height: MediaQuery.of(context).size.height - 77,
          child: ClipPath(
            clipper: OvalRightBorderClipper(),
            child: Drawer(
              child: Container(
                padding: const EdgeInsets.only(left: 26.0, right: 140),
                decoration: BoxDecoration(
                  color: primary,
                  boxShadow: [BoxShadow(color: Colors.black45)],
                ),
                width: 300,
                child: SafeArea(
                  /// ---------------------------
                  /// Building scrolling  content for drawer .
                  /// ---------------------------

                  child: SingleChildScrollView(
                    child: Column(
                      children: <Widget>[
                        // Container(
                        //   alignment: Alignment.centerRight,
                        //   child: IconButton(
                        //     icon: Icon(
                        //       Icons.power_settings_new,
                        //       color: active,
                        //     ),
                        //     onPressed: () {},
                        //   ),
                        // ),

                        /// ---------------------------
                        /// Building header for drawer .
                        /// ---------------------------
                        SizedBox(height: 28.0),
                        Container(
                          height: 90,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              gradient: LinearGradient(
                                  colors: [Colors.orange, Colors.deepOrange])),
                          child: CircleAvatar(
                            radius: 40,
                            backgroundImage: AssetImage(
                              'assets/images/abir.jpeg',
                            ),
                          ),
                        ),
                        SizedBox(height: 5.0),

                        /// ---------------------------
                        /// Building header title for drawer .
                        /// ---------------------------

                        Text(
                          "Abir Cherif",
                          style: TextStyle(
                              color: Colors.purple.withOpacity(0.6),
                              fontSize: 18.0,
                              fontWeight: FontWeight.w600),
                        ),
                        Text(
                          "@Abir.ch",
                          style: TextStyle(color: active, fontSize: 16.0),
                        ),

                        /// ---------------------------
                        /// Building items list  for drawer .
                        /// ---------------------------
                        SizedBox(height: 16.0),
                        ListTile(
                          leading: Icon(Icons.home, color: active),
                          title: Text('Home', style: TextStyle(color: active)),
                          onTap: () {
                            // Navigate to home screen
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => PlanningListPage()),
                            );
                          },
                        ),
                        _buildDivider(),
                        ListTile(
                          leading: Icon(Icons.playlist_add_circle_outlined,
                              color: active),
                          title: Text('Destination',
                              style: TextStyle(color: active)),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => DestinationScreen()),
                            );
                          },
                        ),
                        _buildDivider(),
                        ListTile(
                          leading: Icon(Icons.calendar_month, color: active),
                          title:
                              Text('Schedule', style: TextStyle(color: active)),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ScheduleScreen()),
                            );
                          },
                        ),
                        _buildDivider(),
                        ListTile(
                          leading: Icon(Icons.groups, color: active),
                          title:
                              Text('Clients', style: TextStyle(color: active)),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ClientScreen()),
                            );
                          },
                        ),
                        _buildDivider(),
                        ListTile(
                          leading: Icon(Icons.notification_add, color: active),
                          title: Text('Create Notification',
                              style: TextStyle(color: active)),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => AddNotification()),
                            );
                          },
                        ),
                        _buildDivider(),
                         ListTile(
                          leading: Icon(Icons.info, color: active),
                          title: Text('About', style: TextStyle(color: active)),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => AboutPage()),
                            );
                          },
                        ),

                        /// ---------------------------
                        /// last Item for drawer
                        /// ---------------------------

                        _buildDivider(),
                        SizedBox(height: 28.0),
                        Column(
                          children: <Widget>[
                            ListTile(
                              title: Text(
                                   'Log out',
                                style: TextStyle(
                                  fontFamily: 'Bahij Janna',
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16,
                                  color: Colors.purple.withOpacity(0.6),
                                ),
                                textAlign: TextAlign.left,
                              ),
                              trailing: Icon(Icons.login, color: Colors.red),
                              onTap: () {
                                // Log out and quit the app
                                // You can add your own code here for logging out

                                // Exit the app
                                exit(0);
                              },
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).padding.bottom,
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      );
    },
  );
}

Divider _buildDivider() {
  final Color divider = Colors.deepOrange;
  return Divider(
    color: divider,
  );
}

class OvalRightBorderClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, 0);
    path.lineTo(size.width * (2 / 3) - 20, 0);
    path.quadraticBezierTo(size.width * (2.2 / 3), size.height / 4,
        size.width * (2.2 / 3), size.height / 2);
    path.quadraticBezierTo(
        size.width * (2.2 / 3),
        size.height - (size.height / 4),
        size.width * (2 / 3) - 20,
        size.height);
    path.lineTo(0, size.height);
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}

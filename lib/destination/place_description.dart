import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../notification/create_notification.dart';
import '../notification/notification.dart';
import '../planning/guide_plan_test.dart';
import '../planning/home_tasks.dart';
import '../planning/planing_list.dart';
import '../users/client_list.dart';
import 'comment.dart';
//import 'reaction.dart';
import 'reaction_test.dart';
import 'destination_test.dart';
import 'package:url_launcher/url_launcher.dart';

class PlaceDescriptionScreen extends StatelessWidget {
  final Map<String, dynamic> place;

  const PlaceDescriptionScreen({super.key, required this.place});

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
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 120,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 10,
                itemBuilder: (context, index) => Container(
                  margin: const EdgeInsets.all(8),
                  width: 80,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Center(
                    child: Text('Voyageur $index'),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 200,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(place['image']!),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          color: Colors.black.withOpacity(0.5),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 8,
                          ),
                          child: Text(
                            place['name']!,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        /* SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            TextButton.icon(
                              onPressed: () {},
                              icon: Icon(Icons.remove_red_eye),
                              label: Text('Aperçu'),
                              style: TextButton.styleFrom(
                                primary: Colors.white,
                              ),
                            ),
                            TextButton.icon(
                              onPressed: () {},
                              icon: Icon(Icons.map),
                              label: Text('Map'),
                              style: TextButton.styleFrom(
                                primary: Colors.white,
                              ),
                            ),
                            TextButton.icon(
                              onPressed: () {},
                              icon: Icon(Icons.comment),
                              label: Text('Commentaire'),
                              style: TextButton.styleFrom(
                                primary: Colors.white,
                              ),
                            ),
                          ],
                        ),*/
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextButton.icon(
                          onPressed: () {
                            // Navigate to the reactions screen for the current place
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    ReactionsScreen(placeName: place['name']),
                              ),
                            );
                          },
                          icon: const Icon(Icons.list),
                          label: const Text('Add'),
                          style: TextButton.styleFrom(
                            foregroundColor:
                                const Color.fromARGB(255, 27, 27, 27),
                          ),
                        ),
                        TextButton.icon(
                          onPressed: () {
                            // Launch the map application with a search query for the place's name
                            launch(
                                'https://www.google.com/maps/search/?api=1&query=${place['name']}');
                          },
                          icon: const Icon(Icons.map),
                          label: const Text('Map'),
                          style: TextButton.styleFrom(
                            foregroundColor:
                                const Color.fromARGB(255, 24, 23, 23),
                          ),
                        ),
                        TextButton.icon(
                          onPressed: () {
                            // Navigate to the comment section for the current place
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    CommentSection(placeName: place['name']),
                              ),
                            );
                          },
                          icon: const Icon(Icons.comment),
                          label: const Text('Commentaire'),
                          style: TextButton.styleFrom(
                            foregroundColor:
                                const Color.fromARGB(255, 12, 12, 12),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Text(
                      'Description:',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Text(
                      place['description']!,
                      style: const TextStyle(
                        fontSize: 16,
                        height: 1.5,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// void _showMenu(BuildContext context) {
//   showModalBottomSheet(
//     context: context,
//     backgroundColor: Colors.transparent,
//     builder: (BuildContext context) {
//       return Container(
//         decoration: const BoxDecoration(
//           borderRadius: BorderRadius.only(
//             topLeft: Radius.circular(20.0),
//             topRight: Radius.circular(20.0),
//           ),
//           color: Color.fromARGB(255, 255, 255, 255),
//         ),
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             ListTile(
//               leading: const Icon(Icons.home),
//               title: const Text('Home'),
//               onTap: () {
//                 // Navigate to home screen
//                 Navigator.pop(context);
//                 Navigator.pushReplacementNamed(context, '/home');
//               },
//             ),
//             ListTile(
//               leading: const Icon(Icons.playlist_add_circle_outlined),
//               title: const Text('Destination'),
//               onTap: () {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                       builder: (context) => const DestinationScreen()),
//                 );
//               },
//             ),
//             ListTile(
//               leading: const Icon(Icons.calendar_month),
//               title: const Text('Schedule'),
//               onTap: () {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                       builder: (context) => const ScheduleScreen()),
//                 );
//               },
//             ),
//             ListTile(
//               leading: const Icon(Icons.groups),
//               title: const Text('Clients'),
//               onTap: () {
//                 // Navigate to activites screen when pressed
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(builder: (context) => const ClientScreen()),
//                 );
//               },
//             ),
//             ListTile(
//               leading: const Icon(Icons.feedback),
//               title: const Text('Feedbacks'),
//               onTap: () {
//                 // Navigate to settings screen
//                 Navigator.pop(context);
//                 Navigator.pushNamed(context, '/Feedbacks');
//               },
//             ),
//             ListTile(
//               leading: const Icon(Icons.settings),
//               title: const Text('Settings'),
//               onTap: () {
//                 // Navigate to settings screen
//                 Navigator.pop(context);
//                 Navigator.pushNamed(context, '/settings');
//               },
//             ),
//             ListTile(
//               leading: const Icon(Icons.info),
//               title: const Text('About'),
//               onTap: () {
//                 // Navigate to about screen
//                 Navigator.pop(context);
//                 Navigator.pushNamed(context, '/about');
//               },
//             ),
//           ],
//         ),
//       );
//     },
//   );
// }

//

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
                                  builder: (context) => HomePage()),
                            );
                          },
                        ),
                        _buildDivider(),
                        ListTile(
                          leading: const Icon(Icons.done_sharp),
                          title: const Text('My Tasks'),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const HomePage(),
                              ),
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
                                'Log In',
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
                                Navigator.of(context).pop();
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

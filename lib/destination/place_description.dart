import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../notification/notification.dart';
import '../planning/guide_plan.dart';
import '../users/client_list.dart';
import 'destination.dart';

class PlaceDescriptionScreen extends StatelessWidget {
  final Map<String, dynamic> place;

  const PlaceDescriptionScreen({required this.place});

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
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 120,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 10,
                itemBuilder: (context, index) => Container(
                  margin: EdgeInsets.all(8),
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
            SizedBox(height: 16),
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
                          padding: EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 8,
                          ),
                          child: Text(
                            place['name']!,
                            style: TextStyle(
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
                  SizedBox(height: 16),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextButton.icon(
                          onPressed: () {},
                          icon: Icon(Icons.remove_red_eye),
                          label: Text('Aperçu'),
                          style: TextButton.styleFrom(
                            primary: const Color.fromARGB(255, 27, 27, 27),
                          ),
                        ),
                        TextButton.icon(
                          onPressed: () {},
                          icon: Icon(Icons.map),
                          label: Text('Map'),
                          style: TextButton.styleFrom(
                            primary: const Color.fromARGB(255, 24, 23, 23),
                          ),
                        ),
                        TextButton.icon(
                          onPressed: () {},
                          icon: Icon(Icons.comment),
                          label: Text('Commentaire'),
                          style: TextButton.styleFrom(
                            primary: const Color.fromARGB(255, 12, 12, 12),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 16),
                  Padding(
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
                    padding: EdgeInsets.all(16),
                    child: Text(
                      place['description']!,
                      style: TextStyle(
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
              leading: Icon(Icons.playlist_add_circle_outlined),
              title: Text('Destination'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => DestinationScreen()),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.calendar_month),
              title: Text('Schedule'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ScheduleScreen()),
                );
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

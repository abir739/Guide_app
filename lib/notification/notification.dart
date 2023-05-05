import 'dart:convert';
import 'package:guide_app/models/notification_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  _NotificationsScreenState createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  late List<NotificationModel> notifications;
//final formattedTimestamp = formatTimestamp(timestamp).toString();
  final timestamp = DateTime.now().subtract(const Duration(minutes: 30));

  String formatTimestamp(DateTime dateTime) {
    final now = DateTime.now();
    final difference = now.difference(dateTime);

    if (difference.inSeconds < 60) {
      return 'Just now';
    } else if (difference.inMinutes < 60) {
      final minutes = difference.inMinutes;
      return '$minutes ${minutes == 1 ? 'minute' : 'minutes'} ago';
    } else if (difference.inHours < 24) {
      final hours = difference.inHours;
      return '$hours ${hours == 1 ? 'hour' : 'hours'} ago';
    } else if (difference.inDays < 7) {
      final days = difference.inDays;
      return '$days ${days == 1 ? 'day' : 'days'} ago';
    } else {
      final formatter = DateFormat('yyyy-MM-dd');
      return formatter.format(dateTime);
    }
  }

  @override
  void initState() {
    super.initState();
    loadNotifications();
  }

  void loadNotifications() async {
    String data = await rootBundle.loadString('assets/data/notification.json');
    final jsonResult = json.decode(data);

    setState(() {
      notifications = List<NotificationModel>.from(
          jsonResult.map((data) => NotificationModel.fromJson(data)));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Notifications',
          style: TextStyle(
            color: Color.fromARGB(255, 38, 6, 39),
          ),
        ),
        backgroundColor: const Color.fromARGB(
            255, 207, 207, 219), // Set the background color to #4F46E5

        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.notifications),
            onPressed: () {
              // Navigate to notifications screen when button is pressed
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const NotificationsScreen()),
              );
            },
          ),
          /*IconButton(
            icon: Icon(Icons.menu),
            onPressed: () {
              // Show menu options when button is pressed
              _showMenu(context);
            },
          ),*/
        ],
      ),
      body: notifications != null
          ? ListView.builder(
              itemCount: notifications.length,
              itemBuilder: (context, index) {
                return Container(
                  decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  margin: const EdgeInsets.all(10),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundImage:
                          NetworkImage(notifications[index].senderPhotoUrl),
                    ),
                    title: Row(
                      children: [
                        Text('${notifications[index].senderName} - '),
                        Container(
                          padding:
                              const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 163, 97, 175)
                                .withOpacity(0.2),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(
                            notifications[index].senderType,
                            style: const TextStyle(
                              color: Colors.purple,
                            ),
                          ),
                        ),
                      ],
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 8),
                        Text(notifications[index].time),
                        const SizedBox(height: 16),
                        Row(
                          children: [
                            CircleAvatar(
                              backgroundImage: NetworkImage(
                                  notifications[index].messagePhotoUrl),
                              radius:
                                  40, // set the radius to half of the width and height
                            ),
                            const SizedBox(height: 10),
                            Text(
                              ' ${notifications[index].messageType}',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Text(
                          notifications[index].address,
                          style: const TextStyle(
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(notifications[index].activityTime),
                            const SizedBox(
                                width:
                                    100), // Add some space between the buttons
                            TextButton(
                              onPressed: () {
                                // Handle the "Accept" button press
                              },
                              style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                        const Color.fromARGB(255, 190, 39, 102)),
                              ),
                              child: const Text('Rejouer',
                                  style: TextStyle(color: Colors.white)),
                            )
                          ],
                        ),
                        /*SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            TextButton(
                              onPressed: () {
                                // Handle the "Decline" button press
                              },
                              child: Text('Decline',
                                  style: TextStyle(color: Colors.black)),
                              style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                        Color.fromARGB(255, 214, 208, 208)),
                              ),
                            ),*/

                        /*SizedBox(
                            width: 10), // Add some space between the buttons
                        TextButton(
                          onPressed: () {
                            // Handle the "Accept" button press
                          },
                          child: Text('Rejouer',
                              style: TextStyle(color: Colors.white)),
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                                Color.fromARGB(255, 243, 53, 218)),
                          ),
                        )
                        //],
                        // ),*/
                      ],
                    ),
                  ),
                );
              },
            )
          : const Center(
              child: CircularProgressIndicator(),
            ),
    );
  }
}

// Define a function to show the menu options
/*void _showMenu(BuildContext context) {
  showModalBottomSheet(
    context: context,
    builder: (BuildContext context) {
      return Container(
        child: Wrap(
          children: <Widget>[
            ListTile(
              leading: const Icon(Icons.local_hotel_outlined),
              title: const Text('Hotels'),
              onTap: () {
                // Navigate to hotels screen when pressed
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => HotelListScreen(
                            hotels: [
                              {
                                'name': 'Hotel A',
                                'image': 'assets/images/hotel-img.png',
                                'time': '15:00-16:00',
                                'fullName': 'Hotel Carlton',
                                'rating': 4,
                                'address': '123 Main St, Anytown USA',
                              },
                              {
                                'name': 'Hotel B',
                                'image': 'hotel_b.jpg',
                                'time': '45 minutes',
                                'fullName': 'Hotel B Full Name',
                                'rating': 3,
                                'address': '456 Oak St, Anycity USA',
                              },
                              // Add more hotels here...
                            ],
                          )),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.category),
              title: const Text('Restaurants'),
              onTap: () {
                // Navigate to restaurants screen when pressed
                Navigator.pushNamed(context, '/restaurants');
              },
            ),
            ListTile(
              leading: const Icon(Icons.map_sharp),
              title: const Text('Activié/Visite'),
              onTap: () {
                // Navigate to activites screen when pressed
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => VisitesScreen()),
                );
              },
            ),
          ],
        ),
      );
    },
  );
}
*/
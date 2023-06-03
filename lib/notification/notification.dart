import 'dart:convert';
import 'package:guide_app/models/notification_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import '../destination/destination_test.dart';

import '../notification/create_notification.dart';
import '../users/client_list.dart';
import 'package:guide_app/planning/planing_list.dart';
// import '../planning/guide_plan.dart';
import '../planning/home_tasks.dart';
import 'package:guide_app/planning/guide_plan_test.dart';

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

  void _showReplyDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Compose Reply'),
          content: TextFormField(
            decoration: const InputDecoration(
              labelText: 'Reply',
            ),
            maxLines: 3,
            // Handle user input
            onChanged: (value) {
              // You can store the reply message in a variable or update the notification model with the reply message
            },
          ),
          actions: [
            TextButton(
              onPressed: () {
                // Send the reply message and handle the reply action
                _sendReply();
                Navigator.pop(context);
              },
              child: const Text('Send'),
            ),
            TextButton(
              onPressed: () {
                // Cancel the reply action
                Navigator.pop(context);
              },
              child: const Text('Cancel'),
            ),
          ],
        );
      },
    );
  }

  void _sendReply() {
    // Get the reply message and handle the send action
    // You can access the reply message using a variable or update the notification model with the reply message
  }

 void _showNotificationDetails(NotificationModel notification) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Notification Details'),
        content: Text(notification.description),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // Close the dialog
            },
            child: Text('Close'),
          ),
        ],
      );
    },
  );
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
                MaterialPageRoute(
                    builder: (context) => const NotificationsScreen()),
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
                    onTap: () {
                      _showNotificationDetails(notifications[index]);
                    },
                    leading: CircleAvatar(
                      backgroundImage:
                          NetworkImage(notifications[index].senderPhotoUrl),
                    ),
                    title: Row(
                      children: [
                        Text('${notifications[index].senderName} - '),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 4),
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
                        // Text(
                        //   notifications[index].address,
                        //   style: const TextStyle(
                        //     color: Colors.black,
                        //   ),
                        // ),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            // Text(notifications[index].activityTime),
                            const SizedBox(
                                width:
                                    100), // Add some space between the buttons
                            TextButton(
                              onPressed: () {
                                // Handle the "Reply" button press
                                _showReplyDialog();
                              },
                              style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all<
                                        Color>(
                                    const Color.fromARGB(255, 190, 39, 102)),
                              ),
                              child: const Text('Reply',
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

class NotificationDetailsScreen extends StatelessWidget {
  final NotificationModel notification;

  const NotificationDetailsScreen({required this.notification});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notification Details'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text('Sender: ${notification.senderName}'),
          Text('Type: ${notification.messageType}'),
          Text('Time: ${notification.time}'),
          Text('Description: ${notification.description}'),
          Text('Address: ${notification.address}'),
          Text('Activity Time: ${notification.activityTime}'),
          // Add more details as needed
        ],
      ),
    );
  }
}

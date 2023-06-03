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
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            NotificationDetailsScreen(notification: notification),
      ),
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
      ),
      body: notifications != null
          ? ListView.builder(
              itemCount: notifications.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(
                      notifications[index].senderPhotoUrl,
                    ),
                  ),
                  title: Text(notifications[index].senderName),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        notifications[index].time,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        notifications[index].messageType,
                        style: TextStyle(
                          color: Colors.grey,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        notifications[index].address,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                  onTap: () {
                    _showNotificationDetails(notifications[index]);
                  },
                );
              },
            )
          : const Center(
              child: CircularProgressIndicator(),
            ),
    );
  }
}

class NotificationDetailsScreen extends StatelessWidget {
  final NotificationModel notification;

  const NotificationDetailsScreen({Key? key, required this.notification})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notification Details'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            leading: CircleAvatar(
              backgroundImage: NetworkImage(notification.senderPhotoUrl),
            ),
            title: Text(notification.senderName),
            subtitle: Text(notification.time),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Message Type: ${notification.messageType}',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Text('Address: ${notification.address}'),
                const SizedBox(height: 8),
                Text('Activity Time: ${notification.activityTime}'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

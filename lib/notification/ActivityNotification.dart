import 'package:flutter/material.dart';

class ActivityNotificationPage extends StatelessWidget {
  final Activity activity;

  const ActivityNotificationPage({super.key, required this.activity});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Activity Notifications'),
      ),
      body: ListView.builder(
        itemCount: activity.notifications.length,
        itemBuilder: (context, index) {
          final notification = activity.notifications[index];
          return ListTile(
            leading: Icon(Icons.notification_important),
            title: Text(notification.title),
            subtitle: Text(notification.message),
          );
        },
      ),
    );
  }
}

class Activity {
  final String id;
  final String name;
  final String time;
  final String logoPath;
  final String symbolName;
  final String photoPath;
  final String place;
  final String comment;
  final String description;
  final String price;
  final List<Notification> notifications;

  Activity({
    required this.id,
    required this.name,
    required this.time,
    required this.price,
    required this.logoPath,
    required this.symbolName,
    required this.photoPath,
    required this.place,
    this.comment = "",
    required this.description,
    required this.notifications,
  });
}

class Notification {
  final String title;
  final String message;

  Notification({required this.title, required this.message});
}

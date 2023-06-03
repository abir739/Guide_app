import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class ActivityNotificationPage extends StatefulWidget {
  @override
  _ActivityNotificationPageState createState() =>
      _ActivityNotificationPageState();
}

class _ActivityNotificationPageState extends State<ActivityNotificationPage> {
  // Define your state variables and other necessary code here
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Text(
          "Activity's Notifications",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: false,
      ),
      body: ListView.builder(
        itemCount: notifications.length,
        itemBuilder: (context, index) {
          return Slidable(
            startActionPane: ActionPane(
              motion: const DrawerMotion(),
              extentRatio: 0.25,
              children: [
                SlidableAction(
                  label: 'Info',
                  backgroundColor: Colors.grey.shade500,
                  icon: Icons.info_outline,
                  onPressed: (context) async {
                    // Handle the info action
                  },
                ),
              ],
            ),
            endActionPane: ActionPane(
              motion: const DrawerMotion(),
              extentRatio: 0.25,
              children: [
                SlidableAction(
                  label: 'Delete',
                  backgroundColor: Colors.red,
                  icon: Icons.delete,
                  onPressed: (context) {
                    // Handle the delete action
                    setState(() {
                      // Refresh interface after deleting element from list
                    });
                  },
                ),
              ],
            ),
            child: notificationItem(notifications[index]),
          );
        },
      ),
    );
  }

  Widget notificationItem(Notification notification) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Row(
              children: [
                notification.hasStory
                    ? Container(
                        width: 50,
                        height: 50,
                        padding: EdgeInsets.all(2),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [Colors.red, Colors.orangeAccent],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomLeft,
                          ),
                          shape: BoxShape.circle,
                        ),
                        child: Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.white, width: 3),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(50),
                            child: Image.network(notification.profilePic),
                          ),
                        ),
                      )
                    : Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border:
                              Border.all(color: Colors.grey.shade300, width: 1),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(50),
                          child: Image.network(notification.profilePic),
                        ),
                      ),
                SizedBox(width: 10),
                Flexible(
                  child: RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: notification.name,
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        TextSpan(
                          text: notification.content,
                          style: TextStyle(color: Colors.black),
                        ),
                        TextSpan(
                          text: notification.timeAgo,
                          style: TextStyle(color: Colors.grey.shade500),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
          notification.postImage != ''
              ? Container(
                  width: 50,
                  height: 50,
                  child: ClipRRect(
                    child: Image.network(notification.postImage),
                  ),
                )
              : Container(
                  height: 35,
                  width: 110,
                  decoration: BoxDecoration(
                    color: Colors.blue[700],
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Center(
                    child:
                        Text('Follow', style: TextStyle(color: Colors.white)),
                  ),
                ),
        ],
      ),
    );
  }
}

class Notification {
  final String profilePic;
  final String name;
  final String content;
  final String timeAgo;
  final String postImage;
  final bool hasStory;

  Notification({
    required this.profilePic,
    required this.name,
    required this.content,
    required this.timeAgo,
    required this.postImage,
    required this.hasStory,
  });
}

final List<Notification> notifications = [
  Notification(
    profilePic: 'https://example.com/profile1.jpg',
    name: 'John Doe',
    content: 'You have a new message',
    timeAgo: '2 hours ago',
    postImage: '',
    hasStory: true,
  ),
  Notification(
    profilePic: 'https://example.com/profile2.jpg',
    name: 'Jane Smith',
    content: 'Liked your post',
    timeAgo: '3 hours ago',
    postImage: 'https://example.com/post1.jpg',
    hasStory: false,
  ),
  Notification(
    profilePic: 'https://example.com/profile3.jpg',
    name: 'David Johnson',
    content: 'Commented on your photo',
    timeAgo: '5 hours ago',
    postImage: 'https://example.com/photo1.jpg',
    hasStory: true,
  ),
];

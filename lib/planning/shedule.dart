import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';

import '../notification/notification.dart';
import '../users/client_list.dart';

class ScheduleScreen extends StatefulWidget {
  @override
  _ScheduleScreenState createState() => _ScheduleScreenState();
}

class _ScheduleScreenState extends State<ScheduleScreen> {
  DateTime startDate = DateTime.now().subtract(Duration(days: 3));
  DateTime endDate = DateTime.now().add(Duration(days: 20));
  List<DateTime> _days = [];
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    // Generate a list of days between the start and end dates
    int daysDifference = endDate.difference(startDate).inDays;
    for (int i = 0; i <= daysDifference; i++) {
      _days.add(startDate.add(Duration(days: i)));
    }
  }

  @override
  Widget build(BuildContext context) {
    // Remove redundant lines that declare startDate and endDate again
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
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Bonjour John',
                  style: TextStyle(
                    fontSize: 27.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                CircleAvatar(
                  radius: 40.0,
                  backgroundImage: NetworkImage(
                      'https://randomuser.me/api/portraits/men/1.jpg'),
                ),
              ],
            ),
          ),
          SizedBox(height: 16.0),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                for (var day
                    in _days) // use _days list instead of recalculating the dates
                  DayCard(
                    day: day,
                    isSelected: _currentIndex == _days.indexOf(day),
                    schedule: [], // temporary empty schedule
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class DayCard extends StatefulWidget {
  final DateTime day;
  final bool isSelected;
  final List<Activity> schedule;

  DayCard({
    required this.day,
    this.isSelected = false,
    required this.schedule,
  });

  @override
  _DayCardState createState() => _DayCardState();
}

class _DayCardState extends State<DayCard> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Navigate to the schedule screen for this day
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ScheduleDay(selectedDay: widget.day),
          ),
        );
      },
      child: Container(
        margin: EdgeInsets.all(8.0),
        padding: EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: widget.isSelected ? Colors.blue : Colors.white,
          borderRadius: BorderRadius.circular(16.0),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              blurRadius: 4.0,
              offset: Offset(2.0, 2.0),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              DateFormat('EEE').format(widget.day),
              style: TextStyle(
                fontSize: 18.0,
                fontWeight:
                    widget.isSelected ? FontWeight.bold : FontWeight.normal,
              ),
            ),
            SizedBox(height: 8.0),
            Text(
              DateFormat('d').format(widget.day),
              style: TextStyle(
                fontSize: 24.0,
                fontWeight:
                    widget.isSelected ? FontWeight.bold : FontWeight.normal,
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

class ScheduleDay extends StatelessWidget {
  final DateTime selectedDay;
  ScheduleDay({required this.selectedDay});

  @override
  Widget build(BuildContext context) {
    // Get the activities for the selected day
    List<Activity> activities = getActivitiesForDay(selectedDay);

    // Sort the activities by start time
    activities.sort((a, b) => a.time.compareTo(b.time));

    return Scaffold(
      appBar: AppBar(
        title: Text(
            'Schedule for ${DateFormat('EEE, MMM d').format(selectedDay)}'),
      ),
      body: ListView.builder(
        itemCount: activities.length,
        itemBuilder: (context, index) {
          Activity activity = activities[index];

          // Calculate the duration of the activity in minutes
          int minutes = 90;
          Duration duration = Duration(minutes: minutes);
          int durationInMinutes = duration.inMinutes;

          // Calculate the height of the activity box based on its duration
          double height = durationInMinutes / 60.0 * 50.0;

          return Column(
            children: [
              SizedBox(height: 8.0),
              Row(
                children: [
                  SizedBox(width: 8.0),
                  Text(
                    DateFormat('h:mm a').format(activity.time),
                    style: TextStyle(fontSize: 16.0),
                  ),
                  SizedBox(width: 8.0),
                  Expanded(
                    child: Container(
                      height: height,
                      decoration: BoxDecoration(
                        color: Colors.blue.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          activity.description,
                          style: TextStyle(fontSize: 16.0),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 8.0),
                ],
              ),
            ],
          );
        },
      ),
    );
  }

  // TODO: Implement a function to get the activities for a specific day
  List<Activity> getActivitiesForDay(DateTime day) {
    return [];
  }
}

class Activity {
  String id;
  String name;
  final DateTime time;
  final String description;
  final Duration duration;
  String location;

  Activity({
    required this.id,
    required this.name,
    required this.time,
    required this.description,
    required this.duration,
    required this.location,
  });
}

// exemple for list of activiies to test the activity list view
List<Activity> exampleActivities = [
  Activity(
    id: '1',
    name: 'Yoga',
    time: DateTime(2023, 4, 11, 9, 0),
    duration: Duration(hours: 1),
    description: 'A relaxing yoga class',
    location: 'Yoga Studio',
  ),
  Activity(
    id: '2',
    name: 'Lunch',
    time: DateTime(2023, 4, 11, 12, 0),
    duration: Duration(minutes: 30),
    description: 'A quick lunch break',
    location: 'Cafeteria',
  ),
  Activity(
    id: '3',
    name: 'Meeting',
    time: DateTime(2023, 4, 11, 14, 0),
    duration: Duration(hours: 2),
    description: 'A team meeting to discuss project updates',
    location: 'Conference Room',
  ),
  Activity(
    id: '4',
    name: 'Gym',
    time: DateTime(2023, 4, 11, 18, 0),
    duration: Duration(hours: 1, minutes: 30),
    description: 'A workout session at the gym',
    location: 'Gym',
  ),
  Activity(
    id: '5',
    name: 'Dinner',
    time: DateTime(2023, 4, 11, 20, 0),
    duration: Duration(hours: 1),
    description: 'A nice dinner at a restaurant',
    location: 'Restaurant',
  ),
];

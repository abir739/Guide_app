import 'package:flutter/material.dart';

class ScheduleScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Schedule'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CircleAvatar(
                  radius: 30.0,
                  backgroundImage: NetworkImage(
                      'https://randomuser.me/api/portraits/men/1.jpg'),
                ),
                Text(
                  'John Doe',
                  style: TextStyle(fontSize: 20.0),
                ),
              ],
            ),
          ),
          SizedBox(height: 16.0),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                DayCard(day: 'Mon'),
                DayCard(day: 'Tue'),
                DayCard(day: 'Wed'),
                DayCard(day: 'Thu'),
                DayCard(day: 'Fri'),
                DayCard(day: 'Sat'),
                DayCard(day: 'Sun'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class DayCard extends StatelessWidget {
  final String day;

  DayCard({required this.day});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Navigate to the schedule for this day
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ScheduleDayScreen()),
        );
      },
      child: Container(
        margin: EdgeInsets.all(8.0),
        padding: EdgeInsets.all(16.0),
        width: 80.0,
        decoration: BoxDecoration(
          color: Colors.white,
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
              day,
              style: TextStyle(fontSize: 18.0),
            ),
            SizedBox(height: 8.0),
            Text(
              '10',
              style: TextStyle(fontSize: 24.0),
            ),
            Text(
              'tasks',
              style: TextStyle(fontSize: 18.0),
            ),
          ],
        ),
      ),
    );
  }
}

class ScheduleDayScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Schedule - Mon'),
      ),
      body: ListView(
        children: [
          ActivityCard(
            startTime: '8:00 AM',
            endTime: '10:00 AM',
            title: 'Meeting with client',
            description:
                'Discuss project requirements and agree on deliverables',
          ),
          ActivityCard(
            startTime: '10:00 AM',
            endTime: '12:00 PM',
            title: 'Development work',
            description:
                'Implement new feature for app, fix bugs in existing code',
          ),
          ActivityCard(
            startTime: '1:00 PM',
            endTime: '2:00 PM',
            title: 'Lunch break',
            description: 'Grab a quick bite to eat',
          ),
          ActivityCard(
            startTime: '2:00 PM',
            endTime: '4:00 PM',
            title: 'Team meeting',
            description:
                'Discuss progress on project and assign tasks for next sprint',
          ),
        ],
      ),
    );
  }
}

class ActivityCard extends StatelessWidget {
  final String startTime;
  final String endTime;
  final String title;
  final String description;

  ActivityCard({
    required this.startTime,
    required this.endTime,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    final startHour = int.parse(startTime.split(':')[0]);
    final startMinute = int.parse(startTime.split(':')[1].split(' ')[0]);
    final endHour = int.parse(endTime.split(':')[0]);
    final endMinute = int.parse(endTime.split(':')[1].split(' ')[0]);

    final startFraction = (startHour + startMinute / 60) / 24;
    final endFraction = (endHour + endMinute / 60) / 24;

    final durationFraction = endFraction - startFraction;

    return Container(
      margin: EdgeInsets.all(16.0),
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            blurRadius: 4.0,
            offset: Offset(2.0, 2.0),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                startTime,
                style: TextStyle(fontSize: 20.0),
              ),
              SizedBox(height: 8.0),
              Text(
                endTime,
                style: TextStyle(fontSize: 20.0),
              ),
            ],
          ),
          SizedBox(width: 16.0),
          Expanded(
            child: Container(
              height: MediaQuery.of(context).size.width * durationFraction,
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: 24.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 8.0),
                    Text(
                      description,
                      style: TextStyle(
                        fontSize: 20.0,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

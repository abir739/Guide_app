import 'package:flutter/material.dart';

class ScheduleScreen extends StatefulWidget {
  const ScheduleScreen({super.key});

  @override
  _ScheduleScreenState createState() => _ScheduleScreenState();
}

class _ScheduleScreenState extends State<ScheduleScreen> {
  List<String> days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
  DateTime startDate = DateTime.now();
  DateTime endDate = DateTime.now().add(const Duration(days: 7)); // 1 week from now

  // A sample schedule for testing
  Map<DateTime, List<Map<String, dynamic>>> schedule = {
    DateTime.now().subtract(const Duration(days: 1)): [
      {'time': '08:00', 'activity': 'Breakfast', 'duration': 60},
      {'time': '10:00', 'activity': 'Meeting', 'duration': 120},
      {'time': '13:00', 'activity': 'Lunch', 'duration': 60},
      {'time': '15:00', 'activity': 'Gym', 'duration': 90},
      {'time': '19:00', 'activity': 'Dinner', 'duration': 60},
    ],
    DateTime.now(): [
      {'time': '09:00', 'activity': 'Work', 'duration': 180},
      {'time': '13:00', 'activity': 'Lunch', 'duration': 60},
      {'time': '14:00', 'activity': 'Meeting', 'duration': 120},
      {'time': '18:00', 'activity': 'End Work', 'duration': 60},
      {'time': '20:00', 'activity': 'Movie Night', 'duration': 120},
    ],
    DateTime.now().add(const Duration(days: 1)): [
      {'time': '10:00', 'activity': 'Work', 'duration': 120},
      {'time': '13:00', 'activity': 'Lunch', 'duration': 60},
      {'time': '15:00', 'activity': 'Meeting', 'duration': 120},
      {'time': '18:00', 'activity': 'End Work', 'duration': 60},
    ],
  };

  late DateTime selectedDay;

  @override
  void initState() {
    super.initState();
    selectedDay = DateTime.now();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Schedule'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
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
          const SizedBox(height: 16.0),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: _buildDays(),
            ),
          ),

          const SizedBox(height: 16),
          // Schedule for Selected Day
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: _buildSchedule(selectedDay),
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _buildDays() {
    List<Widget> daysWidgets = [];
    // Generate widgets for each day between start and end date
    for (DateTime day = startDate;
        day.isBefore(endDate) || day.isAtSameMomentAs(endDate);
        day = day.add(const Duration(days: 1))) {
      bool isSelected = selectedDay.isAtSameMomentAs(day);
      daysWidgets.add(
        GestureDetector(
          onTap: () {
            setState(() {
              selectedDay = day;
            });
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: isSelected ? Colors.blue : Colors.transparent,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Text(
              days[day.weekday - 1], // Weekday starts from 1 to 7
              style: TextStyle(
                  color: isSelected ? Colors.white : Colors.black,
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                  fontSize: isSelected ? 24 : 18),
            ),
          ),
        ),
      );
      daysWidgets.add(const SizedBox(width: 8));
      // Check if this day is selected and add the schedule widgets
      if (isSelected) {
        daysWidgets.addAll(_buildSchedule(selectedDay));
      }
    }
    return daysWidgets;
  }

  List<Widget> _buildSchedule(DateTime day) {
    List<Map<String, dynamic>> daySchedule = schedule[day] ?? [];
    List<Widget> scheduleWidgets = [];
// Generate widgets for each activity in the day's schedule
    for (var activity in daySchedule) {
      String time = activity['time'];
      String name = activity['activity'];
      int duration = activity['duration'] ?? 0;
      scheduleWidgets.add(
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Activity Time
            SizedBox(
              width: 80,
              child: Text(time),
            ),
            const SizedBox(width: 16),
            // Activity Name and Duration
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: duration.toDouble(),
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(name, style: const TextStyle(color: Colors.white)),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text('$duration mins'),
                ],
              ),
            ),
          ],
        ),
      );
      scheduleWidgets.add(const SizedBox(height: 16));
    }
    return scheduleWidgets;
  }
}

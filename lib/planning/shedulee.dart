import 'package:flutter/material.dart';

class ScheduleScreen extends StatelessWidget {
  final String userName;
  final String userPhotoUrl;
  final DateTime startDate;
  final DateTime endDate;

  const ScheduleScreen({super.key, 
    required this.userName,
    required this.userPhotoUrl,
    required this.startDate,
    required this.endDate,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Schedule Screen'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CircleAvatar(
                backgroundImage: NetworkImage(userPhotoUrl),
                radius: 30,
              ),
              Text(
                userName,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          const Text(
            'Planning days:',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          Row(
            children: _buildPlanningDays(),
          ),
        ],
      ),
    );
  }

  List<Widget> _buildPlanningDays() {
    List<Widget> days = [];
    for (var i = 0; i <= endDate.difference(startDate).inDays; i++) {
      DateTime day = startDate.add(Duration(days: i));
      String dayString = '${day.day}/${day.month}';
      days.add(
        Container(
          margin: const EdgeInsets.only(right: 10),
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.blueAccent,
          ),
          child: Text(
            dayString,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
            ),
          ),
        ),
      );
    }
    return days;
  }
}

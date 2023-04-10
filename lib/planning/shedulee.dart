import 'package:flutter/material.dart';

class ScheduleScreen extends StatelessWidget {
  final String userName;
  final String userPhotoUrl;
  final DateTime startDate;
  final DateTime endDate;

  ScheduleScreen({
    required this.userName,
    required this.userPhotoUrl,
    required this.startDate,
    required this.endDate,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Schedule Screen'),
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
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          SizedBox(height: 20),
          Text(
            'Planning days:',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 10),
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
          margin: EdgeInsets.only(right: 10),
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.blueAccent,
          ),
          child: Text(
            dayString,
            style: TextStyle(
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

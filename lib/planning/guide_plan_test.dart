import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:guide_app/planning/home_tasks.dart';
import 'package:guide_app/planning/planing_list.dart';
import 'package:guide_app/planning/Add_tasks.dart';

//import '../destination/destination.dart';
import '../destination/destination_test.dart';
import '../notification/notification.dart';
import '../users/client_list.dart';

class ScheduleScreen extends StatefulWidget {
  const ScheduleScreen({super.key});

  @override
  _ScheduleScreenState createState() => _ScheduleScreenState();
}

class _ScheduleScreenState extends State<ScheduleScreen> {
  // Define your variables here
  List<DateTime> days = [];
  late DateTime selectedDay;
  final DateTime _startDate = DateTime.now().subtract(const Duration(days: 3));
  final DateTime _endDate = DateTime.now().add(const Duration(days: 20));
  final List<DateTime> _days = [];
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    // Initialize your variables here
    selectedDay = DateTime.now();
    days =
        List.generate(10, (index) => DateTime.now().add(Duration(days: index)));
    // Generate a list of days between the start and end dates
    int daysDifference = _endDate.difference(_startDate).inDays;
    for (int i = 0; i <= daysDifference; i++) {
      _days.add(_startDate.add(Duration(days: i)));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.all(8.0),
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
                const SizedBox(height: 10.0),
                SizedBox(
                  height: 40.0,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: _days.length,
                    itemBuilder: (BuildContext context, int index) {
                      final day = _days[index];
                      // final isSelected = day.day == selectedDay.day;
                      String dayOfWeek = "";
                      switch (day.weekday) {
                        case 1:
                          dayOfWeek = "MON";
                          break;
                        case 2:
                          dayOfWeek = "TUE";
                          break;
                        case 3:
                          dayOfWeek = "WED";
                          break;
                        case 4:
                          dayOfWeek = "THU";
                          break;
                        case 5:
                          dayOfWeek = "FRI";
                          break;
                        case 6:
                          dayOfWeek = "SAT";
                          break;
                        case 7:
                          dayOfWeek = "SUN";
                          break;
                      }
                      bool isSelected = _currentIndex == _days.indexOf(day);
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            _currentIndex = _days.indexOf(day);
                          });
                        },
                        child: Container(
                          margin: const EdgeInsets.symmetric(horizontal: 3.0),
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(18.0),
                            color: isSelected
                                ? const Color.fromARGB(255, 248, 177, 170)
                                : Colors.transparent,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                dayOfWeek,
                                style: const TextStyle(
                                  color: Color(0xFFEB5F52),
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.bold,
                                  //fontWeight: FontWeight.w500,
                                ),
                              ),
                              Text(
                                '${day.day}',
                                style: TextStyle(
                                  fontSize: 17.0,
                                  fontWeight: FontWeight.bold,
                                  //fontWeight: FontWeight.w500,
                                  color: (day == _currentIndex)
                                      ? const Color(0xFFEB5F52)
                                      : Colors.black,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 2,
            child: ListView.builder(
              itemCount: 10,
              itemBuilder: (BuildContext context, int index) {
                final startTime = TimeOfDay(hour: 9 + index, minute: 0);
                final endTime = TimeOfDay(hour: 10 + index, minute: 0);
                return InkWell(
                  onTap: () {
                    // Navigate to activity details page
                  },
                  child: Container(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Text(
                          '${startTime.format(context)} - ${endTime.format(context)}',
                          style: const TextStyle(fontSize: 18.0),
                        ),
                        const SizedBox(width: 16.0),
                        Expanded(
                          child: Container(
                            height: 100.0,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              color: const Color(0xFFEB5F52),
                            ),
                            child: const Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  tasks['name'],
                                  style: TextStyle(
                                      fontSize: 16.0, color: Colors.white),
                                ),
                                SizedBox(height: 4.0),
                                Text(
                                  tasks['Description'],
                                  style: TextStyle(
                                      fontSize: 14.0, color: Colors.white),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    'Reminders',
                    style: TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 8.0),
                Expanded(
                  child: ListView.builder(
                    itemCount: 5,
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                        height: 50.0,
                        margin: const EdgeInsets.symmetric(
                            horizontal: 16.0, vertical: 8.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12.0),
                          color: Colors.grey[200],
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 16.0),
                              child: Text(
                                Reminder ['time'],
                                style: TextStyle(
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            const Expanded(
                              child: Padding(
                                padding: EdgeInsets.symmetric(horizontal: 16.0),
                                child: Text(
                                  Reminder ['description'],
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontSize: 16.0,
                                  ),
                                ),
                              ),
                            ),
                            IconButton(
                              icon: const Icon(
                                Icons.delete_outline,
                                color: Colors.red,
                              ),
                              onPressed: () {
// Delete reminder
                              },
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

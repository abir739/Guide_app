import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:guide_app/planning/edit_task.dart';
import 'package:guide_app/planning/new_task.dart';

import '../models/task.dart';

class ScheduleScreen extends StatefulWidget {
  const ScheduleScreen({Key? key}) : super(key: key);

  @override
  _ScheduleScreenState createState() => _ScheduleScreenState();
}

class _ScheduleScreenState extends State<ScheduleScreen> {
  List<DateTime> days = [];
  late DateTime selectedDay;
  final DateTime _startDate = DateTime.now().subtract(const Duration(days: 3));
  final DateTime _endDate = DateTime.now().add(const Duration(days: 20));
  final List<DateTime> _days = [];
  int _currentIndex = 0;

  List<Task> tasks = [];

  @override
  void initState() {
    super.initState();
    selectedDay = DateTime.now();
    days =
        List.generate(10, (index) => DateTime.now().add(Duration(days: index)));
    int daysDifference = _endDate.difference(_startDate).inDays;
    for (int i = 0; i <= daysDifference; i++) {
      _days.add(_startDate.add(Duration(days: i)));
    }

    loadTasks();
  }

  void updateTask(int index) {
    Task task = tasks[index];

    // Navigate to the task editing screen and pass the task data
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => TaskEditScreen(task: task)),
    ).then((updatedTask) {
      if (updatedTask != null) {
        setState(() {
          tasks[index] = updatedTask;
        });
      }
    });
  }

  void addTask() {
    // Navigate to the task creation screen
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => TaskCreateScreen()),
    ).then((newTask) {
      if (newTask != null) {
        setState(() {
          tasks.add(newTask);
        });
      }
    });
  }

  Future<void> loadTasks() async {
    String tasksData = await rootBundle.loadString('assets/data/tasks.json');
    List<dynamic> tasksJson = jsonDecode(tasksData);
    setState(() {
      tasks = tasksJson.map((task) => Task.fromJson(task)).toList();
    });
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

                // Check if index is within the bounds of tasks list
                if (index < tasks.length) {
                  final task =
                      tasks[index]; // Access the task at the specified index

                  return InkWell(
                    onTap: () {
                      // Navigate to activity details page
                    },
                    child: Stack(
                      children: [
                        Container(
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
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        task.name,
                                        style: const TextStyle(
                                          fontSize: 16.0,
                                          color: Colors.white,
                                        ),
                                      ),
                                      SizedBox(height: 4.0),
                                      Text(
                                        task.description,
                                        style: const TextStyle(
                                          fontSize: 14.0,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Positioned(
                          top: 8.0,
                          right: 8.0,
                          child: SpeedDial(
                            icon: Icons.more_vert,
                            activeIcon: Icons.close,
                            backgroundColor: Colors.deepOrangeAccent,
                            foregroundColor: Colors.white,
                            activeBackgroundColor: Colors.deepPurpleAccent,
                            activeForegroundColor: Colors.white,
                            visible: true,
                            closeManually: false,
                            curve: Curves.bounceIn,
                            overlayColor: Colors.black,
                            overlayOpacity: 0.5,
                            onOpen: () => print('OPENING DIAL'),
                            onClose: () => print('DIAL CLOSED'),
                            elevation: 5.0,
                            shape: const CircleBorder(),
                            children: [
                              SpeedDialChild(
                                child: const Icon(Icons.edit),
                                backgroundColor: Colors.blue,
                                foregroundColor: Colors.white,
                                label: 'Update Task',
                                labelStyle: const TextStyle(fontSize: 18.0),
                                onTap: () => updateTask(index),
                                onLongPress: () =>
                                    print('Update Task Long Press'),
                              ),
                              SpeedDialChild(
                                child: const Icon(Icons.delete_forever),
                                backgroundColor: Colors.red,
                                foregroundColor: Colors.white,
                                label: 'Delete Task',
                                labelStyle: const TextStyle(fontSize: 18.0),
                                onTap: () {
                                  // Delete the task
                                  setState(() {
                                    tasks.removeAt(index);
                                  });
                                },
                                onLongPress: () =>
                                    print('Delete Task Long Press'),
                              ),
                              SpeedDialChild(
                                child: const Icon(Icons.calendar_today),
                                foregroundColor: Colors.white,
                                backgroundColor: Colors.green,
                                label: 'New Task',
                                labelStyle: const TextStyle(fontSize: 18.0),
                                onTap: () => addTask(),
                                onLongPress: () => print('New Task Long Press'),
                              ),

                              // Add more menu item children here
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                } else {
                  return const SizedBox(); // Return an empty SizedBox if index is out of bounds
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}

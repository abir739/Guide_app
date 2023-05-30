import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:flutter_svg/svg.dart';
import 'package:guide_app/notification/notification.dart';
import 'package:guide_app/planning/Add_tasks.dart';
import 'package:guide_app/planning/planing_list.dart';
//import 'package:guide_app/planning/TaskDetailsPage.dart';
import 'package:guide_app/planning/update_reminder.dart';
import 'package:guide_app/planning/edit_task.dart';
import 'package:guide_app/planning/new_task.dart';

import '../destination/destination_test.dart';
import '../models/reminder.dart';
import '../models/task.dart';
import '../notification/create_notification.dart';
import '../users/client_list.dart';
import 'home_tasks.dart';

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
  List<Reminder> reminders = [];

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
    loadReminders();
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
      MaterialPageRoute(builder: (context) => const TaskCreateScreen()),
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

  Future<void> loadReminders() async {
    String remindersData =
        await rootBundle.loadString('assets/data/reminders.json');
    List<dynamic> remindersJson = jsonDecode(remindersData);
    setState(() {
      reminders =
          remindersJson.map((reminder) => Reminder.fromJson(reminder)).toList();
    });
  }

  // void editTask(Task task) {
  //   Navigator.push(
  //     context,
  //     MaterialPageRoute(builder: (context) => TaskDetailsPage(task: task)),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: SvgPicture.asset(
          'assets/images/Logo.svg',
          fit: BoxFit.cover,
          height: 36.0,
        ),
        backgroundColor: const Color.fromARGB(255, 207, 207, 219),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.notifications),
            onPressed: () {
              // Navigate to notifications screen when button is pressed
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const NotificationsScreen()),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () {
              // Show menu options when button is pressed
              _showMenu(context);
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.center,
              // crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // const Padding(
                //   padding: EdgeInsets.all(8.0),
                //   child: Row(
                //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //     children: [
                //       Text(
                //         'Bonjour John',
                //         style: TextStyle(
                //           fontSize: 27.0,
                //           fontWeight: FontWeight.bold,
                //         ),
                //       ),
                //       CircleAvatar(
                //         radius: 40.0,
                //         backgroundImage: NetworkImage(
                //             'https://randomuser.me/api/portraits/men/1.jpg'),
                //       ),
                //     ],
                //   ),
                // ),
                const SizedBox(height: 16.0),
                // const Text(
                //   'Liste de passagers',
                //   style: TextStyle(
                //     fontSize: 27.0,
                //     fontWeight: FontWeight.bold,
                //   ),
                // ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    const SizedBox(width: 5.0),
                    const Text(
                      'Daily tasks',
                      style: TextStyle(
                        fontSize: 27.0,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF3A3557),
                      ),
                    ),
                    const SizedBox(width: 84.5),
                    Container(
                      height: 40.0,
                      width: 100,
                      decoration: BoxDecoration(
                        color: const Color(0xFFEB5F52),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor: const Color(0xFFEB5F52),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                        onPressed: () {
                          addTask();
                        },
                        child: const Center(
                          child: Text(
                            'Add Task',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 35.0),
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
                          height: 20,
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
          const SizedBox(height: 0.05),
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
                                      const SizedBox(height: 4.0),
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
                        // Positioned(
                        //   top: 8.0,
                        //   right: 8.0,
                        //   child: SpeedDial(
                        //     icon: Icons.more_vert,
                        //     activeIcon: Icons.close,
                        //     backgroundColor: Colors.deepOrangeAccent,
                        //     foregroundColor: Colors.white,
                        //     activeBackgroundColor: Colors.deepPurpleAccent,
                        //     activeForegroundColor: Colors.white,
                        //     visible: true,
                        //     closeManually: false,
                        //     curve: Curves.bounceIn,
                        //     overlayColor: Colors.black,
                        //     overlayOpacity: 0.5,
                        //     onOpen: () => print('OPENING DIAL'),
                        //     onClose: () => print('DIAL CLOSED'),
                        //     elevation: 5.0,
                        //     shape: const CircleBorder(),
                        //     children: [
                        //       SpeedDialChild(
                        //         child: const Icon(Icons.edit),
                        //         backgroundColor: Colors.blue,
                        //         foregroundColor: Colors.white,
                        //         label: 'Update Task',
                        //         labelStyle: const TextStyle(fontSize: 18.0),
                        //         onTap: () => updateTask(index),
                        //         onLongPress: () =>
                        //             print('Update Task Long Press'),
                        //       ),
                        //       SpeedDialChild(
                        //         child: const Icon(Icons.delete_forever),
                        //         backgroundColor: Colors.red,
                        //         foregroundColor: Colors.white,
                        //         label: 'Delete Task',
                        //         labelStyle: const TextStyle(fontSize: 18.0),
                        //         onTap: () {
                        //           // Delete the task
                        //           setState(() {
                        //             tasks.removeAt(index);
                        //           });
                        //         },
                        //         onLongPress: () =>
                        //             print('Delete Task Long Press'),
                        //       ),
                        //       SpeedDialChild(
                        //         child: const Icon(Icons.calendar_today),
                        //         foregroundColor: Colors.white,
                        //         backgroundColor: Colors.green,
                        //         label: 'New Task',
                        //         labelStyle: const TextStyle(fontSize: 18.0),
                        //         onTap: () => addTask(),
                        //         onLongPress: () => print('New Task Long Press'),
                        //       ),

                        //       // Add more menu item children here
                        //     ],
                        //   ),
                        // ),
                        Positioned(
                          top: 8.0,
                          right: 4.0,
                          child: PopupMenuButton<String>(
                            itemBuilder: (BuildContext context) =>
                                <PopupMenuEntry<String>>[
                              PopupMenuItem<String>(
                                value: 'update',
                                child: ListTile(
                                  leading: const Icon(Icons.edit),
                                  title: const Text('Update Task'),
                                ),
                              ),
                              PopupMenuItem<String>(
                                value: 'delete',
                                child: ListTile(
                                  leading: const Icon(Icons.delete_forever),
                                  title: const Text('Delete Task'),
                                ),
                              ),
                              // PopupMenuItem<String>(
                              //   value: 'new',
                              //   child: ListTile(
                              //     leading: const Icon(Icons.calendar_today),
                              //     title: const Text('New Task'),
                              //   ),
                              // ),
                            ],
                            onSelected: (String value) {
                              if (value == 'update') {
                                updateTask(index);
                              } else if (value == 'delete') {
                                setState(() {
                                  tasks.removeAt(index);
                                });
                              } else if (value == 'new') {
                                addTask();
                              }
                            },
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
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              // crossAxisAlignment: CrossAxisAlignment.center,

              children: [
                const Padding(
                  padding: EdgeInsets.all(0.8),
                  child: Text(
                    'Reminders',
                    style: TextStyle(
                      fontSize: 27.0,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF3A3557),
                    ),
                  ),
                ),
                const SizedBox(height: 0.5),
                Expanded(
                  child: ListView.builder(
                    itemCount: reminders.length,
                    itemBuilder: (BuildContext context, int index) {
                      final reminder = reminders[index];

                      return Dismissible(
                        key: Key(reminder.id
                            .toString()), // Use a unique key for each reminder
                        direction: DismissDirection.endToStart,
                        background: Container(
                          color: Colors.red,
                          alignment: Alignment.centerRight,
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: const Icon(
                            Icons.delete,
                            color: Colors.white,
                          ),
                        ),
                        onDismissed: (direction) {
                          // Remove the reminder from the list when dismissed
                          setState(() {
                            reminders.removeAt(index);
                          });
                        },
                        child: Container(
                          height: 50.0,
                          margin: const EdgeInsets.symmetric(
                            horizontal: 16.0,
                            vertical: 14.0,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12.0),
                            color: Colors.grey[200],
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16.0),
                                child: Text(
                                  reminder.time,
                                  style: const TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16.0),
                                  child: Text(
                                    reminder.description,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
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
                                  // Remove the reminder when the delete button is pressed
                                  setState(() {
                                    reminders.removeAt(index);
                                  });
                                },
                              ),
                              IconButton(
                                icon: const Icon(
                                  Icons.edit,
                                  color: Colors.blue,
                                ),
                                onPressed: () async {
                                  final updatedReminder = await Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          UpdateReminderScreen(
                                              reminder: reminder),
                                    ),
                                  );

                                  if (updatedReminder != null) {
                                    // Update the reminder in the list
                                    setState(() {
                                      reminders[index] = updatedReminder;
                                    });
                                  }
                                },
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
        ],
      ),
    );
  }
}

// void _showMenu(BuildContext context) {
//   showModalBottomSheet(
//     context: context,
//     backgroundColor: Colors.transparent,
//     builder: (BuildContext context) {
//       return Container(
//         decoration: const BoxDecoration(
//           borderRadius: BorderRadius.only(
//             topLeft: Radius.circular(20.0),
//             topRight: Radius.circular(20.0),
//           ),
//           color: Color.fromARGB(255, 255, 255, 255),
//         ),
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             ListTile(
//               leading: const Icon(Icons.home),
//               title: const Text('Home'),
//               onTap: () {
//                 // Navigate to home screen
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(builder: (context) => const HomePage()),
//                 );
//               },
//             ),
//             ListTile(
//               leading: const Icon(Icons.playlist_add_circle_outlined),
//               title: const Text('Destination'),
//               onTap: () {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                       builder: (context) => const DestinationScreen()),
//                 );
//               },
//             ),
//             ListTile(
//               leading: const Icon(Icons.done_sharp),
//               title: const Text('My Tasks'),
//               onTap: () {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                     builder: (context) => const HomePage(),
//                   ),
//                 );
//               },
//             ),
//             ListTile(
//               leading: const Icon(Icons.calendar_month),
//               title: const Text('Tasks'),
//               onTap: () {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                       builder: (context) => const ScheduleScreen()),
//                 );
//               },
//             ),
//             ListTile(
//               leading: const Icon(Icons.add_task_outlined),
//               title: const Text('Add Tasks'),
//               onTap: () {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                     builder: (context) => const CreateNewTaskPage(),
//                   ),
//                 );
//               },
//             ),
//             ListTile(
//               leading: const Icon(Icons.groups),
//               title: const Text('Clients'),
//               onTap: () {
//                 // Navigate to activites screen when pressed
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(builder: (context) => const ClientScreen()),
//                 );
//               },
//             ),
//             ListTile(
//               leading: const Icon(Icons.settings),
//               title: const Text('Settings'),
//               onTap: () {
//                 // Navigate to settings screen
//                 Navigator.pop(context);
//                 Navigator.pushNamed(context, '/settings');
//               },
//             ),
//             ListTile(
//               leading: const Icon(Icons.info),
//               title: const Text('About'),
//               onTap: () {
//                 // Navigate to about screen
//                 Navigator.pop(context);
//                 Navigator.pushNamed(context, '/about');
//               },
//             ),
//           ],
//         ),
//       );
//     },
//   );
// }

// 

void _showMenu(BuildContext context) {
  final Color primary = Colors.white;
  final Color active = Colors.black;

  double screenHeight = MediaQuery.of(context).size.height;

  showModalBottomSheet(
    context: context,
    backgroundColor: Colors.transparent,
    isScrollControlled: true,
    builder: (BuildContext context) {
      return SizedBox(
        width: MediaQuery.of(context).size.width * 0.8, // Set the desired width
        child: Container(
          height: MediaQuery.of(context).size.height - 77,
          child: ClipPath(
            clipper: OvalRightBorderClipper(),
            child: Drawer(
              child: Container(
                padding: const EdgeInsets.only(left: 26.0, right: 140),
                decoration: BoxDecoration(
                  color: primary,
                  boxShadow: [BoxShadow(color: Colors.black45)],
                ),
                width: 300,
                child: SafeArea(
                  /// ---------------------------
                  /// Building scrolling  content for drawer .
                  /// ---------------------------

                  child: SingleChildScrollView(
                    child: Column(
                      children: <Widget>[
                        // Container(
                        //   alignment: Alignment.centerRight,
                        //   child: IconButton(
                        //     icon: Icon(
                        //       Icons.power_settings_new,
                        //       color: active,
                        //     ),
                        //     onPressed: () {},
                        //   ),
                        // ),

                        /// ---------------------------
                        /// Building header for drawer .
                        /// ---------------------------
                        SizedBox(height: 28.0),
                        Container(
                          height: 90,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              gradient: LinearGradient(
                                  colors: [Colors.orange, Colors.deepOrange])),
                          child: CircleAvatar(
                            radius: 40,
                            backgroundImage: AssetImage(
                              'assets/images/abir.jpeg',
                            ),
                          ),
                        ),
                        SizedBox(height: 5.0),

                        /// ---------------------------
                        /// Building header title for drawer .
                        /// ---------------------------

                        Text(
                          "Abir Cherif",
                          style: TextStyle(
                              color: Colors.purple.withOpacity(0.6),
                              fontSize: 18.0,
                              fontWeight: FontWeight.w600),
                        ),
                        Text(
                          "@Abir.ch",
                          style: TextStyle(color: active, fontSize: 16.0),
                        ),

                        /// ---------------------------
                        /// Building items list  for drawer .
                        /// ---------------------------
                        SizedBox(height: 16.0),
                        ListTile(
                          leading: Icon(Icons.home, color: active),
                          title: Text('Home', style: TextStyle(color: active)),
                          onTap: () {
                            // Navigate to home screen
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => PlanningListPage()),
                            );
                          },
                        ),
                        _buildDivider(),
                        ListTile(
                          leading: Icon(Icons.playlist_add_circle_outlined,
                              color: active),
                          title: Text('Destination',
                              style: TextStyle(color: active)),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => DestinationScreen()),
                            );
                          },
                        ),
                        _buildDivider(),
                        ListTile(
                          leading: Icon(Icons.calendar_month, color: active),
                          title:
                              Text('Schedule', style: TextStyle(color: active)),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ScheduleScreen()),
                            );
                          },
                        ),
                        _buildDivider(),
                        ListTile(
                          leading: Icon(Icons.groups, color: active),
                          title:
                              Text('Clients', style: TextStyle(color: active)),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ClientScreen()),
                            );
                          },
                        ),
                        _buildDivider(),
                        ListTile(
                          leading: Icon(Icons.notification_add, color: active),
                          title: Text('Create Notification',
                              style: TextStyle(color: active)),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => AddNotification()),
                            );
                          },
                        ),
                        _buildDivider(),
                        ListTile(
                          leading: Icon(Icons.info, color: active),
                          title: Text('About', style: TextStyle(color: active)),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => HomePage()),
                            );
                          },
                        ),

                        /// ---------------------------
                        /// last Item for drawer
                        /// ---------------------------

                        _buildDivider(),
                        SizedBox(height: 28.0),
                        Column(
                          children: <Widget>[
                            ListTile(
                              title: Text(
                                'Log In',
                                style: TextStyle(
                                  fontFamily: 'Bahij Janna',
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16,
                                  color: Colors.purple.withOpacity(0.6),
                                ),
                                textAlign: TextAlign.left,
                              ),
                              trailing: Icon(Icons.login, color: Colors.red),
                              onTap: () {
                                Navigator.of(context).pop();
                              },
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).padding.bottom,
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      );
    },
  );
}

Divider _buildDivider() {
  final Color divider = Colors.deepOrange;
  return Divider(
    color: divider,
  );
}

class OvalRightBorderClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, 0);
    path.lineTo(size.width * (2 / 3) - 20, 0);
    path.quadraticBezierTo(size.width * (2.2 / 3), size.height / 4,
        size.width * (2.2 / 3), size.height / 2);
    path.quadraticBezierTo(
        size.width * (2.2 / 3),
        size.height - (size.height / 4),
        size.width * (2 / 3) - 20,
        size.height);
    path.lineTo(0, size.height);
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}

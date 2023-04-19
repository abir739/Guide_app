import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:guide_app/planning/planing_list.dart';

//import '../destination/destination.dart';
import '../destination/destination_test.dart';
import '../notification/notification.dart';
import '../users/client_list.dart';

class ScheduleScreen extends StatefulWidget {
  @override
  _ScheduleScreenState createState() => _ScheduleScreenState();
}

class _ScheduleScreenState extends State<ScheduleScreen> {
  // Define your variables here
  List<DateTime> days = [];
  late DateTime selectedDay;
  DateTime _startDate = DateTime.now().subtract(Duration(days: 3));
  DateTime _endDate = DateTime.now().add(Duration(days: 20));
  List<DateTime> _days = [];
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
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
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
                SizedBox(height: 10.0),
                Container(
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
                        /*onTap: () {
                          setState(() {
                            selectedDay = day;
                          });
                        },*/
                        onTap: () {
                          setState(() {
                            _currentIndex = _days.indexOf(day);
                          });
                        },
                        child: Container(
                          margin: EdgeInsets.symmetric(horizontal: 3.0),
                          padding: EdgeInsets.symmetric(horizontal: 16.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(18.0),
                            color: isSelected
                                ? Color.fromARGB(255, 248, 177, 170)
                                : Colors.transparent,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "$dayOfWeek",
                                style: TextStyle(
                                  color: const Color(0xFFEB5F52),
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
                    padding: EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Text(
                          '${startTime.format(context)} - ${endTime.format(context)}',
                          style: TextStyle(fontSize: 18.0),
                        ),
                        SizedBox(width: 16.0),
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
                                  'Activity',
                                  style: TextStyle(
                                      fontSize: 16.0, color: Colors.white),
                                ),
                                SizedBox(height: 4.0),
                                Text(
                                  'Description',
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
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    'Reminders',
                    style: TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: 8.0),
                Expanded(
                  child: ListView.builder(
                    itemCount: 5,
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                        height: 50.0,
                        margin: EdgeInsets.symmetric(
                            horizontal: 16.0, vertical: 8.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12.0),
                          color: Colors.grey[200],
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16.0),
                              child: Text(
                                '12:00 PM',
                                style: TextStyle(
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
                                  'Reminder description',
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontSize: 16.0,
                                  ),
                                ),
                              ),
                            ),
                            IconButton(
                              icon: Icon(
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
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => PlanningListPage()),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.playlist_add_circle_outlined),
              title: Text('Destination'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => DestinationScreen()),
                );
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

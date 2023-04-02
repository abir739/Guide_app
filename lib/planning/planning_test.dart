import 'dart:math';

import 'package:flutter/material.dart';

import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';

class PlanningScreen extends StatefulWidget {
  @override
  _PlanningScreenState createState() => _PlanningScreenState();
}

class _PlanningScreenState extends State<PlanningScreen> {
  DateTime _startDate = DateTime.now().subtract(Duration(days: 3));
  DateTime _endDate = DateTime.now().add(Duration(days: 20));
  List<DateTime> _days = [];
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    // Generate a list of days between the start and end dates
    int daysDifference = _endDate.difference(_startDate).inDays;
    for (int i = 0; i <= daysDifference; i++) {
      _days.add(_startDate.add(Duration(days: i)));
    }
  }

  Widget _buildDay(DateTime day) {
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
        margin: EdgeInsets.symmetric(horizontal: 5.0),
        decoration: BoxDecoration(
          color: isSelected
              ? Color.fromARGB(255, 241, 210, 231)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Center(
          child: Text(
            "$dayOfWeek ${day.day}",
            style: TextStyle(
              fontSize: 14.0,
              fontWeight: FontWeight.w500,
              color: (day == _currentIndex) ? Colors.blue : Colors.black,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDaysList() {
    return Container(
      height: 50.0,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: _days.length,
        itemBuilder: (BuildContext context, int index) {
          return _buildDay(_days[index]);
        },
      ),
    );
  }

  Widget _buildBox() {
    return Container(
      height: 240.0,
      decoration: BoxDecoration(
        color: Color.fromRGBO(
          Random().nextInt(255),
          Random().nextInt(255),
          Random().nextInt(255),
          0.5,
        ),
        borderRadius: BorderRadius.circular(8.0),
      ),
    );
  }

  Widget _buildBoxesList() {
    final int numOfBoxes = Random().nextInt(8) + 3;
    final List<Widget> boxes = [];
    for (int i = 0; i < numOfBoxes; i++) {
      boxes.add(_buildBox());
    }
    return Column(
      children: boxes,
    );
  }

  @override
  Widget build(BuildContext context) {
    final start = DateFormat("MMM dd, yyyy").format(_startDate);
    final end = DateFormat("MMM dd, yyyy").format(_endDate);

    return Scaffold(
      appBar: AppBar(
        title: SvgPicture.asset(
          'assets/images/Logo.svg',
          fit: BoxFit.cover,
          height: 36.0,
        ),
        backgroundColor: Color.fromARGB(255, 207, 207, 219),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.all(10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Planning 1',
                  style: TextStyle(
                    fontSize: 27.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                InkWell(
                  onTap: () {
                    // Handle the button press
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      color: Colors.grey[300],
                    ),
                    padding:
                        EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
                    child: Row(
                      children: [
                        Icon(
                          Icons.edit,
                          size: 20.0,
                        ),
                        SizedBox(width: 5.0),
                        Text(
                          'Modifier',
                          style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            child: Text(
              '${DateFormat('MMM d, y').format(_startDate)} ~ ${DateFormat('MMM d, y').format(_endDate)}',
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          _buildDaysList(),
          Expanded(
            child: ListView.builder(
              itemCount: _days.length,
              itemBuilder: (BuildContext context, int index) {
                if (_currentIndex != index) {
                  return SizedBox.shrink();
                }
                final random = Random();
                final numberOfBoxes = random.nextInt(8) + 3;
                final boxes = List.generate(
                  numberOfBoxes,
                  (int index) {
                    final color = Color.fromRGBO(
                      random.nextInt(256),
                      random.nextInt(256),
                      random.nextInt(256),
                      0.5,
                    );
                    return Container(
                      height: 240.0,
                      margin: EdgeInsets.all(16.0),
                      decoration: BoxDecoration(
                        color: color,
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    );
                  },
                );
                return Column(
                  children: boxes,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

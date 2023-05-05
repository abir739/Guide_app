import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;

class PlanningScreen extends StatefulWidget {
  final String planningId;

  const PlanningScreen({super.key, required this.planningId});

  @override
  _PlanningScreenState createState() => _PlanningScreenState();
}

class _PlanningScreenState extends State<PlanningScreen> {
  //late List<DateTime> days;
  late List<DateTime> days = [];

  late Planning planning;
  late List<Map<String, dynamic>> activities = [];

  @override
  void initState() {
    super.initState();

    // Retrieve the planning data from the API using widget.planningId
    Future<Planning> fetchPlanning(String planningId) async {
      final response = await http.get(Uri.parse(
          'https://api.zenify-trip.continuousnet.com/api/plannings/$planningId'));
      if (response.statusCode == 200) {
        return Planning.fromJson(jsonDecode(response.body));
      } else {
        throw Exception('Failed to load planning');
      }
    }

    fetchPlanning(widget.planningId).then((planning) {
      // Assign the planning result to the planning field
      setState(() {
        this.planning = planning;
      });

      // Retrieve the activities data from the API
      Future<List<Activity>> fetchActivities() async {
        final response = await http.get(Uri.parse(
            'https://api.zenify-trip.continuousnet.com/api/activities'));
        if (response.statusCode == 200) {
          final List<dynamic> activitiesJson = jsonDecode(response.body);
          return activitiesJson
              .map((activityJson) => Activity.fromJson(activityJson))
              .toList();
        } else {
          throw Exception('Failed to load activities');
        }
      }

      fetchActivities().then((activities) {
        // Generate the list of days from the start day to the end day of the planning
        days = [];
        DateTime currentDay = planning.startDate;
        while (currentDay.isBefore(planning.endDate)) {
          days.add(currentDay);
          currentDay = currentDay.add(const Duration(days: 1));
        }

        // Generate the list of activities for each day
        this.activities = [];
        for (DateTime day in days) {
          List<Activity> activitiesForDay = activities.where((activity) {
            DateTime activityDate =
                DateTime.parse(activity.departureDate.toString());
            return activityDate.year == day.year &&
                activityDate.month == day.month &&
                activityDate.day == day.day;
          }).toList();
          this.activities.add({'date': day, 'activities': activitiesForDay});
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Planning'),
      ),
      body: Column(
        children: [
          // Horizontal list of days
          SizedBox(
            height: 50,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: days.length,
              itemBuilder: (BuildContext context, int index) {
                return InkWell(
                  onTap: () {
                    // Show the vertical list of activities for the selected day
                    // ...
                  },
                  child: Container(
                    width: 100,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      color: Colors.white,
                    ),
                    child: Center(
                      child: Text(
                        DateFormat('EEE, d MMM').format(days[index]),
                        style: const TextStyle(fontSize: 16),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          // Vertical list of activities
          Expanded(
            child: ListView.builder(
              itemCount: activities.length,
              itemBuilder: (BuildContext context, int index) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: Text(
                        DateFormat('EEE, d MMM')
                            .format(activities[index]['date']),
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),
                    const Divider(),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: activities[index]['activities'].length,
                      itemBuilder: (BuildContext context, int index2) {
                        Map<String, dynamic> activity =
                            activities[index]['activities'][index2];
                        return ListTile(
                          title: Text(activity['reference']),
                          subtitle: Text(activity['departureNote']),
                          trailing: Text(
                              '${activity['adultPrice']} ${activity['currency']}'),
                        );
                      },
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

// Define the Planning and Activity models
class Planning {
  final String id;
  final DateTime startDate;
  final DateTime endDate;

  Planning({required this.id, required this.startDate, required this.endDate});

  factory Planning.fromJson(Map<String, dynamic> json) {
    return Planning(
      id: json['id'],
      startDate: DateTime.parse(json['startDate']),
      endDate: DateTime.parse(json['endDate']),
    );
  }
}

class Activity {
  final String id;
  final String reference;
  final String departureNote;
  final int adultPrice;
  final String currency;
  final DateTime departureDate;

  Activity({
    required this.id,
    required this.reference,
    required this.departureNote,
    required this.adultPrice,
    required this.currency,
    required this.departureDate,
  });

  factory Activity.fromJson(Map<String, dynamic> json) {
    return Activity(
      id: json['id'],
      reference: json['reference'],
      departureNote: json['departureNote'],
      adultPrice: json['adultPrice'],
      currency: json['currency'],
      departureDate: DateTime.parse(json['departureDate']),
    );
  }
}

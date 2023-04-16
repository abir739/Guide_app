import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class PlanningScreen extends StatefulWidget {
  final int planningId;

  const PlanningScreen({Key? key, required this.planningId}) : super(key: key);

  @override
  _PlanningScreenState createState() => _PlanningScreenState();
}

class _PlanningScreenState extends State<PlanningScreen> {
  List<dynamic> _planningList = [];
  List<dynamic> _activityList = [];
  List<dynamic> _activityTemplateList = [];
  List<dynamic> _activityCategoryList = [];

  Future<List<dynamic>> _fetchPlanningData() async {
    var response = await http.get(
        Uri.parse('https://api.zenify-trip.continuousnet.com/api/plannings'));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load planning data');
    }
  }

  Future<List<dynamic>> _fetchActivityData() async {
    var response = await http.get(Uri.parse(
        'https://api.zenify-trip.continuousnet.com/api/activities/${widget.planningId}'));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load activity data');
    }
  }

  Future<List<dynamic>> _fetchActivityTemplateData(
      String activityTemplateId) async {
    var response = await http.get(Uri.parse(
        'https://api.zenify-trip.continuousnet.com/api/activities/$activityTemplateId'));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load activity template data');
    }
  }

  Future<List<dynamic>> _fetchActivityCategoryData(
      String activityCategoryId) async {
    var response = await http.get(Uri.parse(
        'https://api.zenify-trip.continuousnet.com/api/activity-templates/$activityCategoryId'));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load activity category data');
    }
  }

  Future<List<dynamic>> getActivityCategories(
      List<dynamic> activityCategoryIds) async {
    List<Future<dynamic>> futures = [];
    for (var activityCategoryId in activityCategoryIds) {
      futures.add(_fetchActivityCategoryData(activityCategoryId));
    }
    return Future.wait(futures);
  }

  @override
  void initState() {
    super.initState();
    Future.wait([_fetchPlanningData(), _fetchActivityData()]).then((data) {
      setState(() {
        _planningList = data[0];
        _activityList = data[1];
      });
      _activityList.forEach((activity) {
        _fetchActivityTemplateData(activity['activityTemplateId'])
            .then((activityTemplate) {
          setState(() {
            _activityTemplateList.add(activityTemplate);
          });
        });
        activity['activityCategories'].forEach((activityCategoryId) {
          _fetchActivityCategoryData(activityCategoryId)
              .then((activityCategory) {
            setState(() {
              _activityCategoryList.add(activityCategory);
            });
          });
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Planning Screen'),
      ),
      body: ListView.builder(
        itemCount: _activityList.length,
        itemBuilder: (BuildContext context, int index) {
          Map<String, dynamic> activity = _activityList[index];
          Map<String, dynamic> activityTemplate = _activityTemplateList[index];
          List<dynamic> activityCategories = activity['activityCategories']
              .map((activityCategoryId) => _activityCategoryList.firstWhere(
                  (activityCategory) =>
                      activityCategory['id'] == activityCategoryId))
              .toList();
          return Card(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.network(activityTemplate['picture']),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        activityTemplate['name'],
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 5.0),
                      Text(
                        activityTemplate['shortDescription'],
                        style: TextStyle(
                          fontSize: 16.0,
                        ),
                      ),
                      SizedBox(height: 10.0),
                      Text(
                        'Duration: ${activityTemplate['durationHours']} hours',
                        style: TextStyle(
                          fontSize: 16.0,
                        ),
                      ),
                      SizedBox(height: 10.0),
                      Text(
                        'Activity Categories:',
                        style: TextStyle(
                          fontSize: 16.0,
                        ),
                      ),
                      SizedBox(height: 5.0),
                      FutureBuilder<List<dynamic>>(
                        future: getActivityCategories(
                            activityTemplate['activityCategories']),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return CircularProgressIndicator();
                          } else if (snapshot.hasError) {
                            return Text('Error: ${snapshot.error}');
                          } else {
                            return Wrap(
                              spacing: 5.0,
                              runSpacing: 5.0,
                              children: snapshot.data!
                                  .map((category) => Chip(
                                        label: Text(category['name']),
                                        backgroundColor: Colors.grey[200],
                                      ))
                                  .toList(),
                            );
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

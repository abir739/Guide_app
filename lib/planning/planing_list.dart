import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';

import 'package:flutter_svg/flutter_svg.dart';

import 'package:guide_app/planning/guide_plan.dart';
import 'package:guide_app/planning/planing_detail.dart';
import 'package:guide_app/planning/planning.dart';

import 'package:intl/intl.dart';
import 'package:guide_app/activity/newactivityyy.dart';
import 'package:guide_app/planning/Add_Client.dart';
import 'package:guide_app/notification/notification.dart';

import '../HelpScreen.dart';
import '../SettingsScreen.dart';
import '../destination/destination.dart';
import '../models/planing_model.dart';
import '../users/client_list.dart';

class PlanningListPage extends StatefulWidget {
  @override
  _PlanningListPageState createState() => _PlanningListPageState();
}

class _PlanningListPageState extends State<PlanningListPage> {
  List<Planning> _planningList = [];

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  void _loadData() async {
    String jsonData = await DefaultAssetBundle.of(context)
        .loadString('assets/data/planning_data.json');
    List<dynamic> jsonList = json.decode(jsonData);
    setState(() {
      _planningList = jsonList.map((e) => Planning.fromJson(e)).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Planning List'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(
                labelText: 'Search',
                hintText: 'Enter keywords',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 120,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: _planningList.length,
              itemBuilder: (context, index) {
                Planning planning = _planningList[index];
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: InkWell(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => PlanningScreen(planning)));
                    },
                    child: Container(
                      width: 200,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.grey[200],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('ID: ${planning.id}'),
                            Text(
                                'Tourist Group ID: ${planning.touristGroupId}'),
                            Text('Name: ${planning.name}'),
                            Text('Start Date: ${planning.startDate}'),
                            Text('End Date: ${planning.endDate}'),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

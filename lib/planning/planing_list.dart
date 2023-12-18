import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:guide_app/planning/activity_category.dart';
import '../models/planing_model.dart';

class PlanningListPage extends StatefulWidget {
  const PlanningListPage({super.key});

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
        title: const Text('Planning List'),
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
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 520,
            child: ListView.builder(
              scrollDirection: Axis.vertical,
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

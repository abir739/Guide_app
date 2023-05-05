import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:guide_app/ViewModel/planning_M.dart';

class PlanningScreen extends StatefulWidget {
  const PlanningScreen({Key? key}) : super(key: key);

  @override
  _PlanningScreenState createState() => _PlanningScreenState();
}

class _PlanningScreenState extends State<PlanningScreen> {
  late List<Planning> plannings = [];
  late DateTime _selectedDate;

  @override
  void initState() {
    super.initState();
    _selectedDate = DateTime.now();
    fetchPlannings();
  }

  Future<List<Planning>> fetchPlannings() async {
    final response = await http.get(
        Uri.parse('https://api.zenify-trip.continuousnet.com/api/plannings'));

    if (response.statusCode == 200) {
      final List<dynamic> responseData = json.decode(response.body);
      final List<Planning> plannings =
          responseData.map((data) => Planning.fromJson(data)).toList();

      // Filter plannings by ID
      const String planningId = '3aa7fdfe-1902-4f93-8669-d1b384903b39';
      final Planning selectedPlanning =
          plannings.firstWhere((planning) => planning.id == planningId);

      return [selectedPlanning];
    } else {
      throw Exception('Failed to load plannings');
    }
  }

  @override
  Widget build(BuildContext context) {
    if (plannings == null) {
      return const Center(child: CircularProgressIndicator());
    }

    final startDate = plannings[0].startDate;
    final endDate = plannings[0].endDate;
    final daysCount = endDate.difference(startDate).inDays;

    return Column(
      children: [
        SizedBox(
          height: 48,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: daysCount,
            itemBuilder: (BuildContext context, int index) {
              final date = startDate.add(Duration(days: index));
              final isSelected = date == _selectedDate;
              return GestureDetector(
                onTap: () => setState(() => _selectedDate = date),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Chip(
                    label: Text(
                      '${date.day}/${date.month}',
                      style: TextStyle(
                          color: isSelected ? Colors.white : Colors.black),
                    ),
                    backgroundColor:
                        isSelected ? Colors.blue : Colors.grey[300],
                  ),
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 16),
        Text(
            'Selected date: ${_selectedDate.day}/${_selectedDate.month}/${_selectedDate.year}'),
      ],
    );
  }
}

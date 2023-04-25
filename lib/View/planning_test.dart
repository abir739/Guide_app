import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class PlanningScreen extends StatefulWidget {
  final String planningId;

  PlanningScreen({required this.planningId});

  @override
  _PlanningScreenState createState() => _PlanningScreenState();
}

class _PlanningScreenState extends State<PlanningScreen> {
  late List<DateTime> days = [];

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  Future<void> _fetchData() async {
    final response = await http.get(
      Uri.parse(
          'https://api.zenify-trip.continuousnet.com/api/plannings/${widget.planningId}'),
    );
    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      final startDate = DateTime.parse(data['startDate']);
      final endDate = DateTime.parse(data['endDate']);
      days = List<DateTime>.generate(
        endDate.difference(startDate).inDays + 1,
        (index) => startDate.add(Duration(days: index)),
      );
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Planning'),
      ),
      // ignore: unnecessary_null_comparison
      body: days == null
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: days.length,
              itemBuilder: (context, index) {
                final day = days[index];
                return GestureDetector(
                  onTap: () {
                    // Navigate to the day's page
                  },
                  child: Container(
                    width: 100,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '${day.day}',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          '${day.month}',
                          style: TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}

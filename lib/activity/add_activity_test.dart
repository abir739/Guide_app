import 'package:flutter/material.dart';

class Activity {
  final String name;
  final String time;

  Activity({required this.name, required this.time});
}

class YourScreen extends StatefulWidget {
  @override
  _YourScreenState createState() => _YourScreenState();
}

class _YourScreenState extends State<YourScreen> {
  List<Activity> activities = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Screen'),
      ),
      body: ListView.builder(
        itemCount: activities.length,
        itemBuilder: (context, index) {
          return Container(
            padding: const EdgeInsets.all(8.0),
            margin: const EdgeInsets.symmetric(vertical: 4.0),
            color: Colors.grey[200],
            child: Text(
              activities[index].name,
              style: const TextStyle(fontSize: 18.0),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: NewActivity,
        child: const Icon(Icons.add),
      ),
    );
  }

  void NewActivity() {
    showDialog(
      context: context,
      builder: (context) {
        // Variables to store the input values
        String activityName = '';
        String activityTime = '';

        return AlertDialog(
          title: const Text('New Activity'),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                decoration: const InputDecoration(labelText: 'Name'),
                onChanged: (value) {
                  activityName = value;
                },
              ),
              TextField(
                decoration: const InputDecoration(labelText: 'Time'),
                onChanged: (value) {
                  activityTime = value;
                },
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                // Create a new Activity object with the input values
                Activity newActivity = Activity(
                  name: activityName,
                  time: activityTime,
                );

                // Add the new activity to the activities list
                activities.add(newActivity);

                setState(() {
                  // Refresh the UI to display the new activity
                });

                Navigator.pop(context); // Close the dialog
              },
              child: const Text('Add'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Close the dialog
              },
              child: const Text('Cancel'),
            ),
          ],
        );
      },
    );
  }
}

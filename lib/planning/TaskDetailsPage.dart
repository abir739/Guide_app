import 'package:flutter/material.dart';

import '../models/task.dart';

class TaskDetailsPage extends StatefulWidget {
  final Task task;

  TaskDetailsPage({required this.task});

  @override
  _TaskDetailsPageState createState() => _TaskDetailsPageState();
}

class _TaskDetailsPageState extends State<TaskDetailsPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Initialize the text controllers with the current task details
    _nameController.text = widget.task.name;
    _descriptionController.text = widget.task.description;
  }

  @override
  void dispose() {
    // Dispose the text controllers when the widget is disposed
    _nameController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Task'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextFormField(
              controller: _nameController,
              decoration: InputDecoration(labelText: 'Task Name'),
            ),
            SizedBox(height: 16.0),
            TextFormField(
              controller: _descriptionController,
              decoration: InputDecoration(labelText: 'Task Description'),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Save the updated task
          final updatedTask = Task(
            name: _nameController.text,
            description: _descriptionController.text,
          );
          // Update the original task object
          widget.task.name = updatedTask.name;
          widget.task.description = updatedTask.description;

          Navigator.pop(context); // Navigate back to the task list
        },
        child: Icon(Icons.save),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../models/task.dart';

class TaskEditScreen extends StatefulWidget {
  final Task task;

  const TaskEditScreen({Key? key, required this.task}) : super(key: key);

  @override
  _TaskEditScreenState createState() => _TaskEditScreenState();
}

class _TaskEditScreenState extends State<TaskEditScreen> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _nameController.text = widget.task.name;
    _descriptionController.text = widget.task.description;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            SvgPicture.asset(
              'assets/images/Logo.svg',
              fit: BoxFit.cover,
              height: 36.0,
            ),
            const SizedBox(
                width: 30.0), // Add spacing between the logo and the text
            const Text('Edit Task'),
          ],
        ),
        backgroundColor: const Color.fromARGB(255, 207, 207, 219),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            TextFormField(
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: 'Task Name',
              ),
            ),
            TextFormField(
              controller: _descriptionController,
              decoration: const InputDecoration(
                labelText: 'Description',
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Task updatedTask = Task(
                  name: _nameController.text,
                  description: _descriptionController.text,
                );
                Navigator.pop(context, updatedTask);
              },
              child: const Text('Update Task'),
            ),
          ],
        ),
      ),
    );
  }
}

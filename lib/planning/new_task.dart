import 'package:flutter/material.dart';
import '../components/custom_textfield.dart';
import '../models/task.dart';
import 'package:flutter_svg/svg.dart';

class TaskCreateScreen extends StatefulWidget {
  const TaskCreateScreen({super.key});

  @override
  _TaskCreateScreenState createState() => _TaskCreateScreenState();
}

class _TaskCreateScreenState extends State<TaskCreateScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

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
            const SizedBox(width: 30.0),
            const Text('New Task'),
          ],
        ),
        backgroundColor: const Color.fromARGB(255, 207, 207, 219),
      ),
      body: Padding(
        padding: const EdgeInsets.all(26.0),
        child: Column(
          children: [
            Container(
              height: 410,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(
                      "https://static.displate.com/857x1200/displate/2021-06-14/15d4f5417f4745fdd701117c91adc0be_a1b8c544f1a3fb8ad0ccf3b856f10b51.jpg"),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 16.0),
            CustomTextField(
              controller: _nameController,
              labelText: 'Task Name',
            ),
            const SizedBox(height: 16.0),
            CustomTextField(
              controller: _descriptionController,
              labelText: 'Description',
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                Task newTask = Task(
                  name: _nameController.text,
                  description: _descriptionController.text,
                );
                Navigator.pop(context, newTask);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor:
                    const Color(0xFF3A3557), // Use the specified color
              ),
              child: const Text('Add Task'),
            ),
          ],
        ),
      ),
    );
  }
}

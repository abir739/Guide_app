import 'package:flutter/material.dart';
import '../models/reminder.dart';

class UpdateReminderScreen extends StatefulWidget {
  final Reminder reminder;

  const UpdateReminderScreen({Key? key, required this.reminder}) : super(key: key);

  @override
  _UpdateReminderScreenState createState() => _UpdateReminderScreenState();
}

class _UpdateReminderScreenState extends State<UpdateReminderScreen> {
  late TextEditingController _descriptionController;
  late TextEditingController _timeController;

  @override
  void initState() {
    super.initState();
    _descriptionController = TextEditingController(text: widget.reminder.description);
    _timeController = TextEditingController(text: widget.reminder.time);
  }

  @override
  void dispose() {
    _descriptionController.dispose();
    _timeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Update Reminder'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _descriptionController,
              decoration: const InputDecoration(
                labelText: 'Description',
              ),
            ),
            const SizedBox(height: 16.0),
            TextField(
              controller: _timeController,
              decoration: const InputDecoration(
                labelText: 'Time',
              ),
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                // Save the updated reminder
                final updatedReminder = Reminder(
                  id: widget.reminder.id,
                  description: _descriptionController.text,
                  time: _timeController.text,
                );

                Navigator.pop(context, updatedReminder);
              },
              child: const Text('Save'),
            ),
          ],
        ),
      ),
    );
  }
}

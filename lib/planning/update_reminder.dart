import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/reminder.dart';
import 'package:flutter_svg/svg.dart';

class UpdateReminderScreen extends StatefulWidget {
  final Reminder reminder;

  const UpdateReminderScreen({Key? key, required this.reminder})
      : super(key: key);

  @override
  _UpdateReminderScreenState createState() => _UpdateReminderScreenState();
}

class _UpdateReminderScreenState extends State<UpdateReminderScreen> {
  late TextEditingController _descriptionController;
  late DateTime _selectedDate;
  late TimeOfDay _selectedTime;

  @override
  void initState() {
    super.initState();
    _descriptionController =
        TextEditingController(text: widget.reminder.description);
    _selectedDate = DateTime.now();
    _selectedTime = TimeOfDay.now();
  }

  @override
  void dispose() {
    _descriptionController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime.now().subtract(const Duration(days: 365)),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );

    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: _selectedTime,
    );

    if (picked != null && picked != _selectedTime) {
      setState(() {
        _selectedTime = picked;
      });
    }
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
            const Text('Update Reminder'),
          ],
        ),
        backgroundColor: const Color.fromARGB(255, 207, 207, 219),
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
            const SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () => _selectDate(context),
              child: Text(
                  'Select Date: ${DateFormat('yyyy-MM-dd').format(_selectedDate)}'),
              style: ElevatedButton.styleFrom(
                primary: Color(0xFF3A3557), // Use the specified color
              ),
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () => _selectTime(context),
              child: Text('Select Time: ${_selectedTime.format(context)}'),
              style: ElevatedButton.styleFrom(
                primary: Color(0xFF3A3557), // Use the specified color
              ),
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                final updatedReminder = Reminder(
                  id: widget.reminder.id,
                  description: _descriptionController.text,
                  time:
                      '${_selectedTime.format(context)}\n${DateFormat('yyyy-MM-dd').format(_selectedDate)}',
                );

                Navigator.pop(context, updatedReminder);
              },
              style: ElevatedButton.styleFrom(
                primary: Color(0xFF3A3557), // Use the specified color
              ),
              child: const Text('Save'),
            ),
          ],
        ),
      ),
    );
  }
}

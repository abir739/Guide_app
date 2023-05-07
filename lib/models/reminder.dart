class Reminder {
  final String time;
  final String description;

  Reminder({required this.time, required this.description});

  factory Reminder.fromJson(Map<String, dynamic> json) {
    return Reminder(
      time: json['time'],
      description: json['description'],
    );
  }
}

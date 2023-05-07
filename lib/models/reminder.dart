class Reminder {
  final String id;
  final String time;
  final String description;

  Reminder({required this.id,required this.time, required this.description});

  factory Reminder.fromJson(Map<String, dynamic> json) {
    return Reminder(
      id: json['id'],
      time: json['time'],
      description: json['description'],
    );
  }
}

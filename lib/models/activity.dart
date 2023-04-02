class Activity {
  final DateTime date;
  final String time;
  final String activityIcon;
  final String activityName;
  final String activityDescription;
  final String activityStatus;
  final String activityLocation;

  Activity({
    required this.date,
    required this.time,
    required this.activityIcon,
    required this.activityName,
    required this.activityDescription,
    required this.activityStatus,
    required this.activityLocation,
  });

  factory Activity.fromJson(Map<String, dynamic> json) {
    return Activity(
      date: DateTime.parse(json['date']),
      time: json['time'],
      activityIcon: json['activityIcon'],
      activityName: json['activityName'],
      activityDescription: json['activityDescription'],
      activityStatus: json['activityStatus'],
      activityLocation: json['activityLocation'],
    );
  }
}

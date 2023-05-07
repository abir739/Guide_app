class Task {
  final String id;
  final String agencyId;
  final String touristGuideId;
  final DateTime todoDate;
  final DateTime checkedDate;
  final String description;
  final List<String> feedback;

  Task({
    required this.id,
    required this.agencyId,
    required this.touristGuideId,
    required this.todoDate,
    required this.checkedDate,
    required this.description,
    required this.feedback,
  });

  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      id: json['id'],
      agencyId: json['agencyId'],
      touristGuideId: json['touristGuideId'],
      todoDate: DateTime.parse(json['todoDate']),
      checkedDate: DateTime.parse(json['checkedDate']),
      description: json['description'],
      feedback: List<String>.from(json['feedback']),
    );
  }
}

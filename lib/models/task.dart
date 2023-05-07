class Task {
  late final String name;
  late final String description;

  Task({required this.name, required this.description});

  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      name: json['name'],
      description: json['description'],
    );
  }
}

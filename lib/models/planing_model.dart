class Planning {
  final int id;
  final int touristGroupId;
  final String name;
  final String startDate;
  final String endDate;

  Planning({
    required this.id,
    required this.touristGroupId,
    required this.name,
    required this.startDate,
    required this.endDate,
  });

  factory Planning.fromJson(Map<String, dynamic> json) {
    return Planning(
      id: json['id'],
      touristGroupId: json['tourist_group_id'],
      name: json['name'],
      startDate: json['start_date'],
      endDate: json['end_date'],
    );
  }
}

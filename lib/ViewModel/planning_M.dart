class Planning {
  final String id;
  final String agencyId;
  final String touristGuideId;
  final String touristGroupId;
  final String name;
  final DateTime startDate;
  final DateTime endDate;
  final String description;
  final bool enabled;
  final String creatorUserId;
  final DateTime createdAt;
  final String updaterUserId;
  final DateTime updatedAt;

  Planning({
    required this.id,
    required this.agencyId,
    required this.touristGuideId,
    required this.touristGroupId,
    required this.name,
    required this.startDate,
    required this.endDate,
    required this.description,
    required this.enabled,
    required this.creatorUserId,
    required this.createdAt,
    required this.updaterUserId,
    required this.updatedAt,
  });

  factory Planning.fromJson(Map<String, dynamic> json) {
    return Planning(
      id: json['id'],
      agencyId: json['agencyId'],
      touristGuideId: json['touristGuideId'],
      touristGroupId: json['touristGroupId'],
      name: json['name'],
      startDate: DateTime.parse(json['startDate']),
      endDate: DateTime.parse(json['endDate']),
      description: json['description'],
      enabled: json['enabled'],
      creatorUserId: json['creatorUserId'],
      createdAt: DateTime.parse(json['createdAt']),
      updaterUserId: json['updaterUserId'],
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }
}

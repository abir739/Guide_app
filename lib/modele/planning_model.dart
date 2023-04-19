class PlanningModel {
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
  final String updaterUserId;
  final DateTime createdAt;
  final DateTime updatedAt;

// {
//   "id": "string",*
//   "agencyId": "string",*
//   "touristGuideId": "string",*
//   "touristGroupId": "string",*
//   "name": "string",*
//   "startDate": {},*
//   "endDate": {},*
//   "description": "string",*
//   "enabled": true,*
//   "creatorUserId": "string",*
//   "createdAt": {},*
//   "updaterUserId": "string",*
//   "updatedAt": {}*
// }

  const PlanningModel({
    required this.startDate,
    required this.id,
    required this.agencyId,
    required this.touristGuideId,
    required this.touristGroupId,
    required this.name,
    required this.description,
    required this.enabled,
    required this.creatorUserId,
    required this.updaterUserId,
    required this.createdAt,
    required this.updatedAt,
    required this.endDate,
  });

  factory PlanningModel.fromJSON(Map<String, dynamic> map) {
    return PlanningModel(
      id: map['id'],
      agencyId: map['agencyId'],
      touristGuideId: map['touristGuideId'],
      touristGroupId: map['touristGroupId'],
      name: map['name'],
      description: map['description'],
      enabled: map['enabled'],
      creatorUserId: map['creatorUserId'],
      updaterUserId: map['updaterUserId'],
      createdAt: map['createdAt'],
      updatedAt: map['updatedAt'],
      startDate: map['startDate'],
      endDate: map['endDate'],
    );
  }
}

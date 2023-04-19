class activityTemplatesModel {
  final String id;
  final String fullName;
  final String logo;
  final String primaryColor;
  final String name;
  final DateTime startDate;
  final DateTime endDate;
  final String secondaryColor;
  final String subDomain;
  final String email;
  final String website;
  final String phone;
  final String fax;
  final String managerName;
  final String mobile;
  final String address;
  final String coordinates;
  final String zipCode;
  final String stateId;
  final String cityId;
  final bool enabled;
  final String creatorUserId;
  final String updaterUserId;
  final DateTime createdAt;
  final DateTime updatedAt;
//  "id": "string",
//   "name": "string",
//   "fullName": "string",
//   "logo": "string",
//   "primaryColor": "string",
//   "secondaryColor": "string",
//   "subDomain": "string",
//   "enabled": true,
//   "email": "string",
//   "website": "string",
//   "phone": "string",
//   "fax": "string",
//   "managerName": "string",
//   "mobile": "string",
//   "address": "string",
//   "coordinates": [
//     "string"
//   ],
//   "zipCode": "string",
//   "countryId": "string",
//   "stateId": "string",
//   "cityId": "string",
//   "creatorUserId": "string",
//   "createdAt": {},
//   "updaterUserId": "string",
//   "updatedAt": {}
// }

  const activityTemplatesModel({
    required this.fullName,
    required this.logo,
    required this.primaryColor,
    required this.secondaryColor,
    required this.subDomain,
    required this.email,
    required this.website,
    required this.phone,
    required this.fax,
    required this.managerName,
    required this.mobile,
    required this.address,
    required this.coordinates,
    required this.zipCode,
    required this.stateId,
    required this.cityId,
    required this.startDate,
    required this.id,
    required this.name,
    required this.enabled,
    required this.creatorUserId,
    required this.updaterUserId,
    required this.createdAt,
    required this.updatedAt,
    required this.endDate,
  });

  factory activityTemplatesModel.fromJSON(Map<String, dynamic> map) {
    return activityTemplatesModel(
      id: map['id'],
      logo: map['logo'],
      primaryColor: map['primaryColor'],
      secondaryColor: map['secondaryColor'],
      address: map['address'],
      cityId: map['cityId'],
      coordinates: map['coordinates'],
      email: map['email'],
      fax: map['fax'],
      fullName: map['fullName'],
      managerName: map['managerName'],
      mobile: map['mobile'],
      phone: map['phone'],
      stateId: map['stateId'],
      subDomain: map['subDomain'],
      website: map['website'],
      zipCode: map['zipCode'],
      name: map['name'],
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

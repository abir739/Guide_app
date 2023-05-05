
class Plannigs {
  String id;
  String agencyId;
  String touristGuideId;
  String touristGroupId;
  String name;
  String startDate;
  String endDate;
  String description;
  bool enabled;
  String creatorUserId;
  String createdAt;
  String updaterUserId;
  String updatedAt;
  dynamic deletedAt;
  Map<String, dynamic> agency;
  Map<String, dynamic> touristGuide;
  Map<String, dynamic> touristGroup;
  Plannigs({
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
    required this.deletedAt,
    required this.agency,
    required this.touristGuide,
    required this.touristGroup,
  });

  factory Plannigs.fromJSON(Map<String, dynamic> json) {
    return Plannigs(
      id: json['id'],
      agencyId: json['agencyId'],
      description: json['description'],
      deletedAt: json['deletedAt'],
      enabled: json['enabled'],
      endDate: json['endDate'],
      touristGuideId: json['childPrice'],
      touristGroupId: json['babyPrice'],
      startDate: json['startDate'],
      name: json['name'],
      creatorUserId: json['creatorUserId'],
      updaterUserId: json['updaterUserId'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      // agency: json['agency'],

      // touristGuide: TouristGuide.fromJson(json['touristGuide']),
      agency: json['agency'] as Map<String, dynamic>,
      // touristGroup: touristGroup.fromJson(json['touristGroup']),
      touristGroup: json['touristGroup'] as Map<String, dynamic>,
      touristGuide: json['touristGuide'] as Map<String, dynamic>,
    );
  }
}

class Agency {
  final String id;
  final String name;
  final String fullName;
  final String logo;
  final String primaryColor;
  final String secondaryColor;
  final String subDomain;
  final bool enabled;
  final String email;
  final String website;
  final String phone;
  final String fax;
  final String managerName;
  final String mobile;
  final String address;
  final dynamic coordinates;
  final String zipCode;
  final dynamic countryId;
  final dynamic stateId;
  final dynamic cityId;
  final String creatorUserId;
  final DateTime createdAt;
  final String updaterUserId;
  final DateTime updatedAt;
  final dynamic deletedAt;

  Agency({
    required this.id,
    required this.name,
    required this.fullName,
    required this.logo,
    required this.primaryColor,
    required this.secondaryColor,
    required this.subDomain,
    required this.enabled,
    required this.email,
    required this.website,
    required this.phone,
    required this.fax,
    required this.managerName,
    required this.mobile,
    required this.address,
    required this.coordinates,
    required this.zipCode,
    required this.countryId,
    required this.stateId,
    required this.cityId,
    required this.creatorUserId,
    required this.createdAt,
    required this.updaterUserId,
    required this.updatedAt,
    required this.deletedAt,
  });

  factory Agency.fromJson(Map<String, dynamic> json) {
    return Agency(
      id: json['id'],
      name: json['name'],
      fullName: json['fullName'],
      logo: json['logo'],
      primaryColor: json['primaryColor'],
      address: json['address'],
      cityId: json['cityId'],
      coordinates: json['coordinates'],
      countryId: json['countryId'],
      createdAt: json['createdAt'],
      creatorUserId: json['creatorUserId'],
      deletedAt: json['deletedAt'],
      email: json['email'],
      enabled: json['enabled'],
      fax: json['fax'],
      managerName: json['managerName'],
      mobile: json['mobile'],
      phone: json['phone'],
      secondaryColor: json['secondaryColor'],
      stateId: json['stateId'],
      subDomain: json['subDomain'],
      updatedAt: json['updatedAt'],
      updaterUserId: json['updaterUserId'],
      website: json['website'],
      zipCode: json['zipCode'],
    );
  }
}

class TouristGuide {
  final String id;
  final String name;
  final String fullName;
  final String logo;
  final String primaryColor;
  final String secondaryColor;
  final String subDomain;
  final bool enabled;
  final String email;
  final String website;
  final String phone;
  final String fax;
  final String managerName;
  final String mobile;
  final String address;
  final dynamic coordinates;
  final String zipCode;
  final dynamic countryId;
  final dynamic stateId;
  final dynamic cityId;
  final String creatorUserId;
  final DateTime createdAt;
  final String updaterUserId;
  final DateTime updatedAt;
  final dynamic deletedAt;

  TouristGuide({
    required this.id,
    required this.name,
    required this.fullName,
    required this.logo,
    required this.primaryColor,
    required this.secondaryColor,
    required this.subDomain,
    required this.enabled,
    required this.email,
    required this.website,
    required this.phone,
    required this.fax,
    required this.managerName,
    required this.mobile,
    required this.address,
    required this.coordinates,
    required this.zipCode,
    required this.countryId,
    required this.stateId,
    required this.cityId,
    required this.creatorUserId,
    required this.createdAt,
    required this.updaterUserId,
    required this.updatedAt,
    required this.deletedAt,
  });

  factory TouristGuide.fromJson(Map<String, dynamic> json) {
    return TouristGuide(
      id: json['id'],
      name: json['name'],
      fullName: json['fullName'],
      logo: json['logo'],
      primaryColor: json['primaryColor'],
      address: json['address'],
      cityId: json['cityId'],
      coordinates: json['coordinates'],
      countryId: json['countryId'],
      createdAt: json['createdAt'],
      creatorUserId: json['creatorUserId'],
      deletedAt: json['deletedAt'],
      email: json['email'],
      enabled: json['enabled'],
      fax: json['fax'],
      managerName: json['managerName'],
      mobile: json['mobile'],
      phone: json['phone'],
      secondaryColor: json['secondaryColor'],
      stateId: json['stateId'],
      subDomain: json['subDomain'],
      updatedAt: json['updatedAt'],
      updaterUserId: json['updaterUserId'],
      website: json['website'],
      zipCode: json['zipCode'],
    );
  }
}

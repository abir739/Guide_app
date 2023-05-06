import 'dart:convert';

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


// class TouristGuide {
  // final String id;
  // final String name;
  // final String fullName;
  // final String logo;
  // final String primaryColor;
  // final String secondaryColor;
  // final String subDomain;
  // final bool enabled;
  // final String email;
  // final String website;
  // final String phone;
  // final String fax;
  // final String managerName;
  // final String mobile;
  // final String address;
  // final String coordinates;
  // final String zipCode;
  // final String countryId;
  // final String stateId;
  // final String cityId;
  // final String creatorUserId;
  // final DateTime createdAt;
  // final String updaterUserId;
  // final DateTime updatedAt;
  // final DateTime deletedAt;

  // TouristGuide({
  //   required this.id,
  //   required this.name,
  //   required this.fullName,
  //   required this.logo,
  //   required this.primaryColor,
  //   required this.secondaryColor,
  //   required this.subDomain,
  //   required this.enabled,
  //   required this.email,
  //   required this.website,
  //   required this.phone,
  //   required this.fax,
  //   required this.managerName,
  //   required this.mobile,
  //   required this.address,
  //   required this.coordinates,
  //   required this.zipCode,
  //   required this.countryId,
  //   required this.stateId,
  //   required this.cityId,
  //   required this.creatorUserId,
  //   required this.createdAt,
  //   required this.updaterUserId,
  //   required this.updatedAt,
  //   required this.deletedAt,
  // });

  // factory TouristGuide.fromJson(Map<String, dynamic> json) {
//     return TouristGuide(
//       id: json['id'],
//       name: json['name'],
//       fullName: json['fullName'],
//       logo: json['logo'],
//       primaryColor: json['primaryColor'],
//       address: json['address'],
//       cityId: json['cityId'],
//       coordinates: json['coordinates'],
//       countryId: json['countryId'],
//       createdAt: json['createdAt'],
//       creatorUserId: json['creatorUserId'],
//       deletedAt: json['deletedAt'],
//       email: json['email'],
//       enabled: json['enabled'],
//       fax: json['fax'],
//       managerName: json['managerName'],
//       mobile: json['mobile'],
//       phone: json['phone'],
//       secondaryColor: json['secondaryColor'],
//       stateId: json['stateId'],
//       subDomain: json['subDomain'],
//       updatedAt: json['updatedAt'],
//       updaterUserId: json['updaterUserId'],
//       website: json['website'],
//       zipCode: json['zipCode'],
//     );
//   }
// }



// {
//       "id": "3aa7fdfe-1902-4f93-8669-d1b384903b39",
//       "agencyId": "56c2e669-417b-4fc4-9c77-6de0f6cf346b",
//       "touristGuideId": "bb4b9e3c-659b-4201-ae90-298a52ed8a99",
//       "touristGroupId": "d52719d8-cb3c-4d18-a045-3eee2976b996",
//       "name": "Sud tunisien ",
//       "startDate": "2023-04-05T01:00:00.000Z",
//       "endDate": "2023-04-29T23:00:00.000Z",
//       "description": null,
//       "enabled": true,
//       "creatorUserId": "1ecb5f2b-6b5c-4989-a747-b29e388216e9",
//       "createdAt": "2023-04-05T01:04:06.520Z",
//       "updaterUserId": "1ecb5f2b-6b5c-4989-a747-b29e388216e9",
//       "updatedAt": "2023-04-05T01:09:42.720Z",
//       "deletedAt": null,
//       "agency": {
//         "id": "56c2e669-417b-4fc4-9c77-6de0f6cf346b",
//         "name": "Continuous Travel",
//         "fullName": "Continuous Travel",
//         "logo": "/assets/uploads/agencies/continuous_travel-zt-20230313114856.png",
//         "primaryColor": "#026BC8",
//         "secondaryColor": "#00CDE7",
//         "subDomain": "continuoustravel",
//         "enabled": true,
//         "email": "contact@continuoustravel.com",
//         "website": "https://continuoustravel.com",
//         "phone": "73367132",
//         "fax": "73367240",
//         "managerName": "Sahbi KHALFALLAH",
//         "mobile": "50050509",
//         "address": "11 Rue Ali Ourdani",
//         "coordinates": null,
//         "zipCode": "",
//         "countryId": null,
//         "stateId": null,
//         "cityId": null,
//         "creatorUserId": "1ecb5f2b-6b5c-4989-a747-b29e388216e9",
//         "createdAt": "2023-03-12T14:12:42.763Z",
//         "updaterUserId": "1ecb5f2b-6b5c-4989-a747-b29e388216e9",
//         "updatedAt": "2023-03-13T11:49:01.938Z",
//         "deletedAt": null
//       },
//       "touristGuide": {
//         "id": "bb4b9e3c-659b-4201-ae90-298a52ed8a99",
//         "name": "Hajer Super Guide",
//         "photo": "assets/uploads/tourist-guides/tour-guide-jobs-zt-20230313135917.jpg",
//         "isRepresentative": true,
//         "employeeNumber": "0198454",
//         "biography": null,
//         "agencyId": "56c2e669-417b-4fc4-9c77-6de0f6cf346b",
//         "nationalityCountryId": null,
//         "shortCode": "SZRTY",
//         "userId": "d33b7d9a-4004-4c62-b40e-607834548c17",
//         "creatorUserId": "1ecb5f2b-6b5c-4989-a747-b29e388216e9",
//         "createdAt": "2023-03-13T13:59:43.692Z",
//         "updaterUserId": "1ecb5f2b-6b5c-4989-a747-b29e388216e9",
//         "updatedAt": "2023-04-02T01:03:38.583Z",
//         "deletedAt": null
//       },
//       "touristGroup": {
//         "id": "d52719d8-cb3c-4d18-a045-3eee2976b996",
//         "agencyId": "56c2e669-417b-4fc4-9c77-6de0f6cf346b",
//         "tourOperatorId": null,
//         "name": "Mars 2023",
//         "departureDate": "2023-04-01T01:00:00.000Z",
//         "departureAirlineCompanyId": null,
//         "departureFlightNumber": null,
//         "departureTransferId": null,
//         "departureNote": null,
//         "arrivalDate": "2023-04-05T01:00:00.000Z",
//         "arrivalAirlineCompanyId": null,
//         "arrivalFlightNumber": null,
//         "arrivalTransferId": null,
//         "arrivalNote": null,
//         "reference": null,
//         "shortCode": null,
//         "confirmed": false,
//         "originCountryId": "3ad82f2a-3b4d-43b9-a6e8-9b00551fd897",
//         "oringinCity": "paris",
//         "destinationCountryId": "3ad82f2a-3b4d-43b9-a6e8-9b00551fd897",
//         "destinationCity": "Sousse",
//         "languageId": "877566a6-5e4e-4f14-8d44-a4634885ae52",
//         "creatorUserId": "1ecb5f2b-6b5c-4989-a747-b29e388216e9",
//         "createdAt": "2023-04-05T01:03:17.440Z",
//         "updaterUserId": "1ecb5f2b-6b5c-4989-a747-b29e388216e9",
//         "updatedAt": "2023-04-05T01:09:24.517Z",
//         "deletedAt": null
//       },
//       "creatorUser": {
//         "id": "1ecb5f2b-6b5c-4989-a747-b29e388216e9",
//         "username": "sa7booch"
//       },
//       "updaterUser": {
//         "id": "1ecb5f2b-6b5c-4989-a747-b29e388216e9",
//         "username": "sa7booch"
//       }

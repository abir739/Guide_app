import 'package:json_annotation/json_annotation.dart';

part 'agance.g.dart';

@JsonSerializable()
class Agency {
  // "id": "56c2e669-417b-4fc4-9c77-6de0f6cf346b",
  //       "name": "Continuous Travel",
  //       "fullName": "Continuous Travel",
  //       "logo": "/assets/uploads/agencies/continuous_travel-zt-20230313114856.png",
  //       "primaryColor": "#026BC8",
  //       "secondaryColor": "#00CDE7",
  //       "subDomain": "continuoustravel",
  //       "enabled": true,
  //       "email": "contact@continuoustravel.com",
  //       "website": "https://continuoustravel.com",
  //       "phone": "73367132",
  //       "fax": "73367240",
  //       "managerName": "Sahbi KHALFALLAH",
  //       "mobile": "50050509",
  //       "address": "11 Rue Ali Ourdani",
  //       "coordinates": null,
  //       "zipCode": "",
  //       "countryId": null,
  //       "stateId": null,
  //       "cityId": null,
  //       "creatorUserId": "1ecb5f2b-6b5c-4989-a747-b29e388216e9",
  //       "createdAt": "2023-03-12T14:12:42.763Z",
  //       "updaterUserId": "1ecb5f2b-6b5c-4989-a747-b29e388216e9",
  //       "updatedAt": "2023-03-13T11:49:01.938Z",
  //       "deletedAt": null
  final String? id;
  final String? name;
  final String? fullName;
  final String? logo;
  final String? primaryColor;
  final String? secondaryColor;
  final String? subDomain;
  final bool? enabled;
  final String? email;
  final String? website;
  final String? phone;
  final String? fax;
  final String? managerName;
  final String? mobile;
  final String? address;
  final String? coordinates;
  final String? zipCode;
  final String? countryId;
  final String? stateId;
  final String? cityId;
  final String? creatorUserId;
  final DateTime? createdAt;
  final String? updaterUserId;
  final DateTime? updatedAt;
  final DateTime? deletedAt;

  Agency({
    this.id,
    this.name,
    this.fullName,
    this.logo,
    this.primaryColor,
    this.secondaryColor,
    this.subDomain,
    this.enabled,
    this.email,
    this.website,
    this.phone,
    this.fax,
    this.managerName,
    this.mobile,
    this.address,
    this.coordinates,
    this.zipCode,
    this.countryId,
    this.stateId,
    this.cityId,
    this.creatorUserId,
    this.createdAt,
    this.updaterUserId,
    this.updatedAt,
    this.deletedAt,
  });
  factory Agency.fromJson(Map<String, dynamic> json) => _$AgencyFromJson(json);
  Map<String, dynamic> toJson() => _$AgencyToJson(this);
}

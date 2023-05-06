// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'TouristGuide.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TouristGuide _$TouristGuideFromJson(Map<String, dynamic> json) => TouristGuide(
      id: json['id'] as String?,
      name: json['name'] as String?,
      fullName: json['fullName'] as String?,
      logo: json['logo'] as String?,
      primaryColor: json['primaryColor'] as String?,
      secondaryColor: json['secondaryColor'] as String?,
      subDomain: json['subDomain'] as String?,
      enabled: json['enabled'] as bool?,
      email: json['email'] as String?,
      website: json['website'] as String?,
      phone: json['phone'] as String?,
      fax: json['fax'] as String?,
      managerName: json['managerName'] as String?,
      mobile: json['mobile'] as String?,
      address: json['address'] as String?,
      coordinates: json['coordinates'] as String?,
      zipCode: json['zipCode'] as String?,
      countryId: json['countryId'] as String?,
      stateId: json['stateId'] as String?,
      cityId: json['cityId'] as String?,
      creatorUserId: json['creatorUserId'] as String?,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      updaterUserId: json['updaterUserId'] as String?,
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
      deletedAt: json['deletedAt'] == null
          ? null
          : DateTime.parse(json['deletedAt'] as String),
      agency: json['agency'] == null
          ? null
          : Agency.fromJson(json['agency'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$TouristGuideToJson(TouristGuide instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'fullName': instance.fullName,
      'logo': instance.logo,
      'primaryColor': instance.primaryColor,
      'secondaryColor': instance.secondaryColor,
      'subDomain': instance.subDomain,
      'enabled': instance.enabled,
      'email': instance.email,
      'website': instance.website,
      'phone': instance.phone,
      'fax': instance.fax,
      'managerName': instance.managerName,
      'mobile': instance.mobile,
      'address': instance.address,
      'coordinates': instance.coordinates,
      'zipCode': instance.zipCode,
      'countryId': instance.countryId,
      'stateId': instance.stateId,
      'cityId': instance.cityId,
      'creatorUserId': instance.creatorUserId,
      'createdAt': instance.createdAt?.toIso8601String(),
      'updaterUserId': instance.updaterUserId,
      'updatedAt': instance.updatedAt?.toIso8601String(),
      'deletedAt': instance.deletedAt?.toIso8601String(),
      'agency': instance.agency,
    };

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'activitesmodel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Activity _$ActivityFromJson(Map<String, dynamic> json) => Activity(
      id: json['id'] as String?,
      images:
          (json['images'] as List<dynamic>?)?.map((e) => e as String).toList(),
      agencyId: json['agencyId'] as String?,
      activityTemplateId: json['activityTemplateId'] as String?,
      touristGuideId: json['touristGuideId'] as String?,
      departureDate: json['departureDate'] == null
          ? null
          : DateTime.parse(json['departureDate'] as String),
      departureNote: json['departureNote'] as String?,
      returnDate: json['returnDate'] == null
          ? null
          : DateTime.parse(json['returnDate'] as String),
      returnNote: json['returnNote'] as String?,
      reference: json['reference'] as String?,
      confirmed: json['confirmed'] as bool?,
      adultPrice: (json['adultPrice'] as num?)?.toDouble(),
      childPrice: (json['childPrice'] as num?)?.toDouble(),
      babyPrice: (json['babyPrice'] as num?)?.toDouble(),
      currency: json['currency'] as String?,
      placesCount: json['placesCount'] as int?,
      parentActivityId: json['parentActivityId'] as String?,
      creatorUserId: json['creatorUserId'] as String?,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      updaterUserId: json['updaterUserId'] as String?,
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
      deletedAt: json['deletedAt'] as String?,
      name: json['name'] as String?,
      agency: json['agency'] == null
          ? null
          : Agency.fromJson(json['agency'] as Map<String, dynamic>),
      activityTemplate: json['activityTemplate'] == null
          ? null
          : ActivityTemplate.fromJson(
              json['activityTemplate'] as Map<String, dynamic>),
      touristGuide: json['touristGuide'] == null
          ? null
          : TouristGuide.fromJson(json['touristGuide'] as Map<String, dynamic>),
      plannings: (json['plannings'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      touristGroups: (json['touristGroups'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      logo: json['logo'] as String?,
    );

Map<String, dynamic> _$ActivityToJson(Activity instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'agencyId': instance.agencyId,
      'logo': instance.logo,
      'activityTemplateId': instance.activityTemplateId,
      'touristGuideId': instance.touristGuideId,
      'departureDate': instance.departureDate?.toIso8601String(),
      'departureNote': instance.departureNote,
      'returnDate': instance.returnDate?.toIso8601String(),
      'returnNote': instance.returnNote,
      'reference': instance.reference,
      'confirmed': instance.confirmed,
      'adultPrice': instance.adultPrice,
      'childPrice': instance.childPrice,
      'babyPrice': instance.babyPrice,
      'currency': instance.currency,
      'placesCount': instance.placesCount,
      'parentActivityId': instance.parentActivityId,
      'creatorUserId': instance.creatorUserId,
      'createdAt': instance.createdAt?.toIso8601String(),
      'updaterUserId': instance.updaterUserId,
      'updatedAt': instance.updatedAt?.toIso8601String(),
      'deletedAt': instance.deletedAt,
      'agency': instance.agency,
      'activityTemplate': instance.activityTemplate,
      'touristGuide': instance.touristGuide,
      'plannings': instance.plannings,
      'touristGroups': instance.touristGroups,
      'images': instance.images,
    };

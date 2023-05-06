// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'planningmainModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PlanningMainModel _$PlanningMainModelFromJson(Map<String, dynamic> json) =>
    PlanningMainModel(
      id: json['id'] as String?,
      agencyId: json['agencyId'] as String?,
      touristGuideId: json['touristGuideId'] as String?,
      touristGroupId: json['touristGroupId'] as String?,
      name: json['name'] as String?,
      startDate: json['startDate'] == null
          ? null
          : DateTime.parse(json['startDate'] as String),
      endDate: json['endDate'] == null
          ? null
          : DateTime.parse(json['endDate'] as String),
      description: json['description'] as String?,
      enabled: json['enabled'] as bool?,
      creatorUserId: json['creatorUserId'] as String?,
      createdAt: json['createdAt'] as String?,
      updaterUserId: json['updaterUserId'] as String?,
      updatedAt: json['updatedAt'] as String?,
      deletedAt: json['deletedAt'] == null
          ? null
          : DateTime.parse(json['deletedAt'] as String),
      agency: json['agency'] == null
          ? null
          : Agency.fromJson(json['agency'] as Map<String, dynamic>),
      touristGuide: json['touristGuide'] == null
          ? null
          : TouristGuide.fromJson(json['touristGuide'] as Map<String, dynamic>),
      touristGroup: json['touristGroup'] == null
          ? null
          : TouristGroup.fromJson(json['touristGroup'] as Map<String, dynamic>),
      creatorUser: json['creatorUser'] == null
          ? null
          : CreatorUser.fromJson(json['creatorUser'] as Map<String, dynamic>),
      updaterUser: json['updaterUser'] == null
          ? null
          : UpdaterUser.fromJson(json['updaterUser'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PlanningMainModelToJson(PlanningMainModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'agencyId': instance.agencyId,
      'touristGuideId': instance.touristGuideId,
      'touristGroupId': instance.touristGroupId,
      'name': instance.name,
      'startDate': instance.startDate?.toIso8601String(),
      'endDate': instance.endDate?.toIso8601String(),
      'description': instance.description,
      'enabled': instance.enabled,
      'creatorUserId': instance.creatorUserId,
      'createdAt': instance.createdAt,
      'updaterUserId': instance.updaterUserId,
      'updatedAt': instance.updatedAt,
      'deletedAt': instance.deletedAt?.toIso8601String(),
      'agency': instance.agency,
      'touristGuide': instance.touristGuide,
      'touristGroup': instance.touristGroup,
      'creatorUser': instance.creatorUser,
      'updaterUser': instance.updaterUser,
    };

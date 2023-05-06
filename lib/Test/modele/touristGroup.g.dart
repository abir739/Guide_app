// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'touristGroup.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TouristGroup _$TouristGroupFromJson(Map<String, dynamic> json) => TouristGroup(
      id: json['id'] as String?,
      agencyId: json['agencyId'] as String?,
      tourOperatorId: json['tourOperatorId'] as String?,
      name: json['name'] as String?,
      departureDate: json['departureDate'] == null
          ? null
          : DateTime.parse(json['departureDate'] as String),
      departureAirlineCompanyId: json['departureAirlineCompanyId'] as String?,
      departureFlightNumber: json['departureFlightNumber'] as String?,
      departureTransferId: json['departureTransferId'] as String?,
      departureNote: json['departureNote'] as String?,
      arrivalDate: json['arrivalDate'] == null
          ? null
          : DateTime.parse(json['arrivalDate'] as String),
      arrivalAirlineCompanyId: json['arrivalAirlineCompanyId'] as String?,
      arrivalFlightNumber: json['arrivalFlightNumber'] as String?,
      arrivalTransferId: json['arrivalTransferId'] as String?,
      arrivalNote: json['arrivalNote'] as String?,
      reference: json['reference'] as String?,
      shortCode: json['shortCode'] as String?,
      confirmed: json['confirmed'] as bool?,
      originCountryId: json['originCountryId'] as String?,
      originCity: json['originCity'] as String?,
      destinationCountryId: json['destinationCountryId'] as String?,
      destinationCity: json['destinationCity'] as String?,
      languageId: json['languageId'] as String?,
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
    );

Map<String, dynamic> _$TouristGroupToJson(TouristGroup instance) =>
    <String, dynamic>{
      'id': instance.id,
      'agencyId': instance.agencyId,
      'tourOperatorId': instance.tourOperatorId,
      'name': instance.name,
      'departureDate': instance.departureDate?.toIso8601String(),
      'departureAirlineCompanyId': instance.departureAirlineCompanyId,
      'departureFlightNumber': instance.departureFlightNumber,
      'departureTransferId': instance.departureTransferId,
      'departureNote': instance.departureNote,
      'arrivalDate': instance.arrivalDate?.toIso8601String(),
      'arrivalAirlineCompanyId': instance.arrivalAirlineCompanyId,
      'arrivalFlightNumber': instance.arrivalFlightNumber,
      'arrivalTransferId': instance.arrivalTransferId,
      'arrivalNote': instance.arrivalNote,
      'reference': instance.reference,
      'shortCode': instance.shortCode,
      'confirmed': instance.confirmed,
      'originCountryId': instance.originCountryId,
      'originCity': instance.originCity,
      'destinationCountryId': instance.destinationCountryId,
      'destinationCity': instance.destinationCity,
      'languageId': instance.languageId,
      'creatorUserId': instance.creatorUserId,
      'createdAt': instance.createdAt?.toIso8601String(),
      'updaterUserId': instance.updaterUserId,
      'updatedAt': instance.updatedAt?.toIso8601String(),
      'deletedAt': instance.deletedAt?.toIso8601String(),
    };

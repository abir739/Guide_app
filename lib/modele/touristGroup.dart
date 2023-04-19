import 'package:json_annotation/json_annotation.dart';

part 'touristGroup.g.dart';

@JsonSerializable()
class TouristGroup {
  final String? id;
  final String? agencyId;
  final String? tourOperatorId;
  final String? name;
  final DateTime? departureDate;
  final String? departureAirlineCompanyId;
  final String? departureFlightNumber;
  final String? departureTransferId;
  final String? departureNote;
  final DateTime? arrivalDate;
  final String? arrivalAirlineCompanyId;
  final String? arrivalFlightNumber;
  final String? arrivalTransferId;
  final String? arrivalNote;
  final String? reference;
  final String? shortCode;
  final bool? confirmed;
  final String? originCountryId;
  final String? originCity;
  final String? destinationCountryId;
  final String? destinationCity;
  final String? languageId;
  final String? creatorUserId;
  final DateTime? createdAt;
  final String? updaterUserId;
  final DateTime? updatedAt;
  final DateTime? deletedAt;

  TouristGroup({
    this.id,
    this.agencyId,
    this.tourOperatorId,
    this.name,
    this.departureDate,
    this.departureAirlineCompanyId,
    this.departureFlightNumber,
    this.departureTransferId,
    this.departureNote,
    this.arrivalDate,
    this.arrivalAirlineCompanyId,
    this.arrivalFlightNumber,
    this.arrivalTransferId,
    this.arrivalNote,
    this.reference,
    this.shortCode,
    this.confirmed,
    this.originCountryId,
    this.originCity,
    this.destinationCountryId,
    this.destinationCity,
    this.languageId,
    this.creatorUserId,
    this.createdAt,
    this.updaterUserId,
    this.updatedAt,
    this.deletedAt,
  });
  factory TouristGroup.fromJson(Map<String, dynamic> json) =>
      _$TouristGroupFromJson(json);
  Map<String, dynamic> toJson() => _$TouristGroupToJson(this);
}

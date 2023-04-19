import 'package:json_annotation/json_annotation.dart';

part 'activityTempModel.g.dart';

@JsonSerializable()
class ActivityTemplate {
  String? id;
  String? name;
  int? durationHours;
  String? shortDescription;
  String? picture;
  String? longDescription;
  String? includedServiceList;
  String? notIncludedServiceList;
  String? safetyMeasureList;
  double? adultPrice;
  int? childPrice;
  String? currency;
  bool? hotelPickupOffered;
  String? countryId;
  String? stateId;
  String? cityId;
  String? coordinates; // or LatLng class if using google_maps_flutter
  String? creatorUserId;
  DateTime? createdAt;
  String? updaterUserId;
  DateTime? updatedAt;
  DateTime? deletedAt;

  ActivityTemplate({
    this.id,
    this.name,
    this.durationHours,
    this.shortDescription,
    this.picture,
    this.longDescription,
    this.includedServiceList,
    this.notIncludedServiceList,
    this.safetyMeasureList,
    this.adultPrice,
    this.childPrice,
    this.currency,
    this.hotelPickupOffered,
    this.countryId,
    this.stateId,
    this.cityId,
    this.coordinates,
    this.creatorUserId,
    this.createdAt,
    this.updaterUserId,
    this.updatedAt,
    this.deletedAt,
  });
  factory ActivityTemplate.fromJson(Map<String, dynamic> json) =>
      _$ActivityTemplateFromJson(json);
  Map<String, dynamic> toJson() => _$ActivityTemplateToJson(this);
}

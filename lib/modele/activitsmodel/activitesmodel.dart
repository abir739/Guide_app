import 'package:json_annotation/json_annotation.dart';

import '../TouristGuide.dart';
import '../agance.dart';
import 'activityTempModel.dart';
part 'activitesmodel.g.dart';

@JsonSerializable()
class Activity {
  String? id;
  String? agencyId;
  String? activityTemplateId;
  String? touristGuideId;
  DateTime? departureDate;
  String? departureNote;
  DateTime? returnDate;
  String? returnNote;
  String? reference;
  bool? confirmed;
  double? adultPrice;
  double? childPrice;
  double? babyPrice;
  String? currency;
  int? placesCount;
  String? parentActivityId;
  String? creatorUserId;
  DateTime? createdAt;
  String? updaterUserId;
  DateTime? updatedAt;
  String? deletedAt;
  Agency? agency;
  ActivityTemplate? activityTemplate;
  TouristGuide? touristGuide;
  List<String>? plannings;
  List<String>? touristGroups;

  Activity({
    this.id,
    this.agencyId,
    this.activityTemplateId,
    this.touristGuideId,
    this.departureDate,
    this.departureNote,
    this.returnDate,
    this.returnNote,
    this.reference,
    this.confirmed,
    this.adultPrice,
    this.childPrice,
    this.babyPrice,
    this.currency,
    this.placesCount,
    this.parentActivityId,
    this.creatorUserId,
    this.createdAt,
    this.updaterUserId,
    this.updatedAt,
    this.deletedAt,
    this.agency,
    this.activityTemplate,
    this.touristGuide,
    this.plannings,
    this.touristGroups,
  });
  factory Activity.fromJson(Map<String, dynamic> json) =>
      _$ActivityFromJson(json);
  Map<String, dynamic> toJson() => _$ActivityToJson(this);
}

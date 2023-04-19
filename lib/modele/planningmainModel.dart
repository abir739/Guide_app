import 'TouristGuide.dart';
import 'agance.dart';
import 'creatorUser.dart';
import 'touristGroup.dart';
import 'updaterUser.dart';
import 'package:json_annotation/json_annotation.dart';

part 'planningmainModel.g.dart';

@JsonSerializable()
class PlanningMainModel {
  String? id;
  String? agencyId;
  String? touristGuideId;
  String? touristGroupId;
  String? name;
  DateTime? startDate;
  DateTime? endDate;
  String? description;
  bool? enabled;
  String? creatorUserId;
  String? createdAt;
  String? updaterUserId;
  String? updatedAt;
  DateTime? deletedAt;
  Agency? agency;

  TouristGuide? touristGuide;
  TouristGroup? touristGroup;
  CreatorUser? creatorUser;
  UpdaterUser? updaterUser;
  PlanningMainModel(
      {this.id,
      this.agencyId,
      this.touristGuideId,
      this.touristGroupId,
      this.name,
      this.startDate,
      this.endDate,
      this.description,
      this.enabled,
      this.creatorUserId,
      this.createdAt,
      this.updaterUserId,
      this.updatedAt,
      this.deletedAt,
      this.agency,
      this.touristGuide,
      this.touristGroup,
      this.creatorUser,
      this.updaterUser});
  factory PlanningMainModel.fromJson(Map<String, dynamic> json) =>
      _$PlanningMainModelFromJson(json);
  Map<String, dynamic> toJson() => _$PlanningMainModelToJson(this);
}

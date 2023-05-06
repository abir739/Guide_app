import 'package:guide_app/Test/modele/planningmainModel.dart';
import 'package:json_annotation/json_annotation.dart';


part 'listPlannig.g.dart';

@JsonSerializable()
class ListPlannings {
  List<PlanningMainModel>? results;

  ListPlannings({this.results});

  factory ListPlannings.fromJson(Map<String, dynamic> json) =>
      _$ListPlanningsFromJson(json);
  Map<String, dynamic> toJson() => _$ListPlanningsToJson(this);
}

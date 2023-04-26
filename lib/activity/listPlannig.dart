import 'package:json_annotation/json_annotation.dart';

import '../ViewModel/planning_model.dart';


part 'listPlannig.g.dart';

@JsonSerializable()
class ListPlannings {
  List<PlanningMainModel>? results;

  ListPlannings({this.results});

  factory ListPlannings.fromJson(Map<String, dynamic> json) =>
      _$ListPlanningsFromJson(json);
  Map<String, dynamic> toJson() => _$ListPlanningsToJson(this);
}
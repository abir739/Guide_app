// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'listPlannig.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ListPlannings _$ListPlanningsFromJson(Map<String, dynamic> json) =>
    ListPlannings(
      results: (json['results'] as List<dynamic>?)
          ?.map((e) => PlanningMainModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ListPlanningsToJson(ListPlannings instance) =>
    <String, dynamic>{
      'results': instance.results,
    };

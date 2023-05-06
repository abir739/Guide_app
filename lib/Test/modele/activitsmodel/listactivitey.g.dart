// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'listactivitey.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ListActivity _$ListActivityFromJson(Map<String, dynamic> json) => ListActivity(
      results: (json['results'] as List<dynamic>?)
          ?.map((e) => Activity.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ListActivityToJson(ListActivity instance) =>
    <String, dynamic>{
      'results': instance.results,
    };

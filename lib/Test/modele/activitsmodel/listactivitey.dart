import 'package:guide_app/Test/modele/activitsmodel/activitesmodel.dart';
import 'package:json_annotation/json_annotation.dart';


part 'listactivitey.g.dart';

@JsonSerializable()
class ListActivity {
  List<Activity>? results;

  ListActivity({this.results});

  factory ListActivity.fromJson(Map<String, dynamic> json) =>
      _$ListActivityFromJson(json);
  Map<String, dynamic> toJson() => _$ListActivityToJson(this);
}

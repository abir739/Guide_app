import 'package:json_annotation/json_annotation.dart';

part 'updaterUser.g.dart';

@JsonSerializable()

class UpdaterUser {
  String? id;
  String? username;

  UpdaterUser({ this.id,  this.username});

  
factory UpdaterUser.fromJson(Map<String, dynamic> json) => _$UpdaterUserFromJson(json);
  Map<String, dynamic> toJson() => _$UpdaterUserToJson(this);
}

import 'package:json_annotation/json_annotation.dart';

part 'creatorUser.g.dart';

@JsonSerializable()
class CreatorUser {
  String? id;
  String? username;

  CreatorUser({
    this.id,
    this.username,
  });

  factory CreatorUser.fromJson(Map<String, dynamic> json) =>
      _$CreatorUserFromJson(json);
  Map<String, dynamic> toJson() => _$CreatorUserToJson(this);
}

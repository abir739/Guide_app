
import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class notif {
  String? location;
  String? detail;
  String? test;

  notif({this.detail, this.location, this.test});

  notif.formJson(Map<String, dynamic> parsedJson) {
    location = parsedJson['location'];
    detail = parsedJson['detail'];
    test = parsedJson['test'];
  }
}

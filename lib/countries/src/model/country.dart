// ignore_for_file: non_constant_identifier_names

import './name.dart';
export './name.dart';

class Country {
  final String iso_3166_1_alpha2;
  final String iso_3166_1_alpha3;
  final Name name;
  final String dialing_code;
  final int default_number_length;
  final String default_number_format;
  final String local_number_sample;
  String flagUri;
  Country({
    required this.iso_3166_1_alpha2,
    required this.iso_3166_1_alpha3,
    required this.dialing_code,
    required this.default_number_length,
    required this.default_number_format,
    required this.local_number_sample,
    required this.name,
    this.flagUri = "",
  });
}

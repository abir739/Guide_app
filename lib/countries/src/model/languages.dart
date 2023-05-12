// ignore_for_file: non_constant_identifier_names, constant_identifier_names
import 'package:flutter/material.dart';

enum Languages {
  // Language in this version
  Arabic("AR", "ARA", "Arabic", TextDirection.rtl),
  Chinese("ZH", "ZHO", "Chinese", TextDirection.ltr),
  Croatian("HR", "HRV", "Croatian", TextDirection.ltr),
  Czech("CS", "CES", "Czech", TextDirection.ltr),
  English("EN", "ENG", "English", TextDirection.ltr),
  Estonian("ET", "EST", "Estonian", TextDirection.ltr),
  Finnish("FI", "FIN", "Finnish", TextDirection.ltr),
  French("FR", "FRA", "French", TextDirection.ltr),
  German("DE", "DEU", "German", TextDirection.ltr),
  Hungarian("HU", "HUN", "Hungarian", TextDirection.ltr),
  Italian("IT", "ITA", "Italian", TextDirection.ltr),
  Japanese("JA", "JPN", "Japanese", TextDirection.ltr),
  Korean("KO", "KOR", "Korean", TextDirection.ltr),
  Persian("FA", "PER", "Persian (Farsi)", TextDirection.rtl),
  Polish("PL", "POL", "Polish", TextDirection.ltr),
  Portuguese("PT", "POR", "Portuguese", TextDirection.ltr),
  Russian("RU", "RUS", "Russian", TextDirection.ltr),
  Slovak("SK", "SLK", "Slovak", TextDirection.ltr),
  Spanish("ES", "SPA", "Spanish", TextDirection.ltr),
  Swedish("SV", "SWE", "Swedish", TextDirection.ltr),
  Urdu("UR", "URD", "Urdu", TextDirection.rtl);

  // Languages in next version
  // Bulgarian("BG", "BUL", "Bulgarian",  TextDirection.ltr),
  // Danish("DA", "DAN", "Danish",  TextDirection.ltr),
  // Greek("EL", "ELL", "Greek (modern)",  TextDirection.ltr),
  // Esperanto("EO", "EPO", "Esperanto",  TextDirection.ltr),
  // Basque("EU", "EUS", "Basque",  TextDirection.ltr),
  // Armenian("HY", "HYE", "Armenian",  TextDirection.ltr),
  // Lithuanian("LT", "LIT", "Lithuanian",  TextDirection.ltr),
  // Norwegian("NO", "NOR", "Norwegian",  TextDirection.ltr),
  // Romanian("RO", "RON", "Romanian",  TextDirection.ltr),
  // Thai("TH", "THA", "Thai",  TextDirection.ltr),
  // Ukrainian("UK", "UKR", "Ukrainian",  TextDirection.ltr);

  const Languages(
    this.iso_639_1_alpha2,
    this.iso_639_2_alpha3,
    this.name,
    this.textDirection,
  );
  final String name;
  final String iso_639_1_alpha2;
  final String iso_639_2_alpha3;
  final TextDirection textDirection;
}

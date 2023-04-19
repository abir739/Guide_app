class Activites {
  final String id;
  final String agencyId;
  final String activityTemplateId;
  final String departureNote;
  final String returnNote;
  final String reference;
  final bool confirmed;
  final int adultPrice;
  final int childPrice;
  final int babyPrice;
  final String currency;
  final String parentActivityId;
  final String creatorUserId;
  final String updaterUserId;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime departureDate;
  final DateTime returnDate;
  final int placesCount;

// "id": "string",
//   "agencyId": "string",
//   "activityTemplateId": "string",
//   "touristGuideId": "string",
//   "departureDate": {},
//   "departureNote": "string",
//   "returnDate": {},
//   "returnNote": "string",
//   "reference": "string",
//   "confirmed": true,
//   "adultPrice": 0,
//   "childPrice": 0,
//   "babyPrice": 0,
//   "currency": "string",
//   "placesCount": 0,
//   "parentActivityId": "string",
//   "creatorUserId": "string",
//   "createdAt": {},
//   "updaterUserId": "string",
//   "updatedAt": {}

  const Activites({
    required this.departureDate,
    required this.returnDate,
    required this.id,
    required this.agencyId,
    required this.activityTemplateId,
    required this.departureNote,
    required this.returnNote,
    required this.reference,
    required this.confirmed,
    required this.adultPrice,
    required this.childPrice,
    required this.babyPrice,
    required this.currency,
    required this.parentActivityId,
    required this.creatorUserId,
    required this.updaterUserId,
    required this.createdAt,
    required this.updatedAt,
    required this.placesCount,
  });

  factory Activites.fromJSON(Map<String, dynamic> map) {
    return Activites(
        id: map['id'],
        agencyId: map['agencyId'],
        activityTemplateId: map['activityTemplateId'],
        departureNote: map['departureNote'],
        returnNote: map['returnNote'],
        reference: map['reference'],
        confirmed: map['confirmed'],
        adultPrice: map['adultPrice'],
        childPrice: map['childPrice'],
        babyPrice: map['babyPrice'],
        currency: map['currency'],
        parentActivityId: map['parentActivityId'],
        creatorUserId: map['creatorUserId'],
        updaterUserId: map['updaterUserId'],
        createdAt: map['createdAt'],
        updatedAt: map['updatedAt'],
        departureDate: map['departureDate'],
        returnDate: map['returnDate'],
        placesCount: map['placesCount']);
  }
}

class Activity {
  final int albumId;
  final int id;
  final String title;
  final String url;
  final String thumbnailUrl;
//  static const List<String> statuslist1 = ['Option 1', 'Option 2', 'Option 3', 'Status'];

  // List<String> get statuslist =>statuslist1;
  const Activity(
      {required this.albumId,
      required this.id,
      required this.title,
      required this.url,
      required this.thumbnailUrl,
});

  factory Activity.fromJSON(Map<String, dynamic> map) {
    return Activity(
        albumId: map['albumId'],
        id: map['id'],
        title: map['title'],
        url: map['url'],
        thumbnailUrl: map['thumbnailUrl']);
  }


}
import 'dart:convert';
import 'package:http/http.dart' as http;

class Item {
  final int userId;
  final int id;
  final String title;
  final bool completed;

//  static const List<String> statuslist1 = ['Option 1', 'Option 2', 'Option 3', 'Status'];

  // List<String> get statuslist =>statuslist1;
  const Item(
      {required this.userId,
      required this.id,
      required this.title,
      required this.completed});

  factory Item.fromJSON(Map<String, dynamic> map) {
    return Item(
        userId: map['userId'],
        id: map['id'],
        title: map['title'],
        completed: map['thumbnailUrl']);
  }
}

class HTTPHandlerItem {
  String baseurl = "https://jsonplaceholder.typicode.com/todos";

  Future<List<Item>> fetchData(String url) async {
    List<Item> activityList = [];
    url = formater(url);
    final respond = await http.get(Uri.parse(url));
    if (respond.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      var data = jsonDecode(respond.body);

      final List result = json.decode(respond.body);
      // for (Map<String, dynamic> d in data) {
      //   Activity activity = Activity.fromJSON(d);
      //   activityList.add(activity);
      // }
      return result.map((e) => Item.fromJSON(e)).toList();
      // return activityList;
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('${respond.statusCode}');
    }
  }

  String formater(String url) {
    return baseurl + url;
  }
}

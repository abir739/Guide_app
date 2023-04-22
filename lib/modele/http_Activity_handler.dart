import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:guide_app/modele/activity_model.dart';

class HTTPHandler {
  String baseurl = "https://jsonplaceholder.typicode.com/photos";
  // String baseurl = "https://api.zenify-trip.continuousnet.com/api/plannings";

  Future<List<Activity>> fetchData(String url) async {
    List<Activity> activityList = [];
    url = formater(url);
    final respond = await http.get(Uri.parse(url));
    if (respond.statusCode == 200 || respond.statusCode == 201) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      var data = jsonDecode(respond.body);

      final List result = json.decode(respond.body);
      // for (Map<String, dynamic> d in data) {
      //   Activity activity = Activity.fromJSON(d);
      //   activityList.add(activity);
      // }
      return result.map((e) => Activity.fromJSON(e)).toList();
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

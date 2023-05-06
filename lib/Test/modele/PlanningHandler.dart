import 'dart:convert';

import 'package:guide_app/Test/modele/activitsmodel/activitesmodel.dart';
import 'package:guide_app/Test/modele/plannings.dart';
import 'package:http/http.dart' as http;

class HTTPHandlerp {
  // String baseurl = "https://jsonplaceholder.typicode.com/photos";
  String baseurl = "https://api.zenify-trip.continuousnet.com/api/plannings";

  Future<List<Plannigs>> fetchData(String url) async {
    List<Activity> planingList = [];
    url = formater(url);
    final respond = await http.get(headers: {
      "Authorization":
          "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjFlY2I1ZjJiLTZiNWMtNDk4OS1hNzQ3LWIyOWUzODgyMTZlOSIsInN1YiI6IjFlY2I1ZjJiLTZiNWMtNDk4OS1hNzQ3LWIyOWUzODgyMTZlOSIsInVzZXJuYW1lIjoic2E3Ym9vY2giLCJlbWFpbCI6InNhN2Jvb2NoQGdtYWlsLmNvbSIsInJvbGUiOiJBZG1pbmlzdHJhdG9yIiwiZmlyc3ROYW1lIjoiU2FoYmkiLCJsYXN0TmFtZSI6IktoYWxmYWxsYWgiLCJleHBpcmVzIjoxNjgwOTg5OTQzLCJjcmVhdGVkIjoxNjgwOTAzNTQzLCJpYXQiOjE2ODA5MDM1NDMsImV4cCI6MTY4MDk4OTk0M30.claPkZxtbkFHvj4zMkbCgD79vpWdn1UZ7VK2yTZA1bU"
    }, Uri.parse(url));
    print(respond.statusCode);
    if (respond.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      var data = jsonDecode(respond.body);
      print(data);
      final touristGuideName = data["results"]["agency"];
      print(touristGuideName);
      final List<Map> result = json.decode(respond.body);
      print(result);
      // for (Map<String, dynamic> d in data) {
      //   Activity activity = Activity.fromJSON(d);
      //   activityList.add(activity);
      // }
      return result
          .map((e) => Plannigs.fromJSON(Map<String, dynamic>.from(e)))
          .toList();
// return result.map((e) => Plannigs.fromJSON(e)).toList();
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

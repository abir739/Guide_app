import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;




import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../modele/activitsmodel/activitesmodel.dart';



class HTTPHandlerActivites {
  Timer? timer;
  // String baseurl = "https://jsonplaceholder.typicode.com/photos";
  String baseurlA = "https://api.zenify-trip.continuousnet.com/api/";
  String baseurlp = "https://api.zenify-trip.continuousnet.com/api/plannings";
  final storage = const FlutterSecureStorage();
  Future<List<Activity>> fetchData(String url) async {
    String? token = await storage.read(key: 'access_token');
    List<Activity> activites = [];
    url = formater(url);
    final respond = await http
        .get(headers: {"Authorization": "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjFlY2I1ZjJiLTZiNWMtNDk4OS1hNzQ3LWIyOWUzODgyMTZlOSIsInN1YiI6IjFlY2I1ZjJiLTZiNWMtNDk4OS1hNzQ3LWIyOWUzODgyMTZlOSIsInVzZXJuYW1lIjoic2E3Ym9vY2giLCJlbWFpbCI6InNhN2Jvb2NoQGdtYWlsLmNvbSIsInJvbGUiOiJBZG1pbmlzdHJhdG9yIiwiZmlyc3ROYW1lIjoiU2FoYmkiLCJsYXN0TmFtZSI6IktoYWxmYWxsYWgiLCJleHBpcmVzIjoxNjgyNjAyMTMzLCJjcmVhdGVkIjoxNjgyNTE1NzMzLCJpYXQiOjE2ODI1MTU3MzMsImV4cCI6MTY4MjYwMjEzM30.kMPJF7rEhKr37qL4VaUCpyGaAH9ytRPKnzHv7YEkGbc"}, Uri.parse(url));
    print(respond.statusCode);
    if (respond.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      // var data = jsonDecode(respond.body);
      // print(data);
      // final touristGuideName = data["results"]["agency"];
      // print(touristGuideName);
      final data = json.decode(respond.body);

      final List r = data["results"];
      // var r = json.decode(res.body);
      // final data = r["results"];
      print(r);
      print("--------------------------------------------fffff--");
      print(r[0]["touristGuideId"]);
      print("-------------------------------------departureDate---------");
      print("----------------------------------------------");
      print(r[0]["departureDate"]);
      print("--------------------------------------departureDate--------");

      // for (Map<String, dynamic> d in data) {
      //   Activity activity = Activity.fromJSON(d);
      //   activityList.add(activity);
      // }
      // return result;
      return r.map((e) => Activity.fromJson(e)).toList();
// r.map((e) => PlanningMainModel.fromJson({"results": e})).toList();
      // return activityList;
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('${respond.statusCode}');
    }
  }

  String formater(String url) {
    return baseurlA + url;
  }
}

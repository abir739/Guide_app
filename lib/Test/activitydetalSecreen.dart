import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

import 'package:get/get.dart';
import 'package:get/get.dart';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:guide_app/Test/modele/activitsmodel/activitesmodel.dart';

class activitydetalSecreen extends StatelessWidget {
  Activity activity;
  String token;
  activitydetalSecreen(this.activity, this.token, {super.key});
  static final List<String> imageUrls = [
    'assets/h1.jpg',
    'assets/h2.jpeg',
    'assets/h3.jpg',
  ];
  final storage = const FlutterSecureStorage();
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [],
        backgroundColor: Color.fromRGBO(212, 5, 5, 0.976),
        title: Text("Activity "),
      ),
      body: SafeArea(
        minimum: EdgeInsets.only(left: 25.0, right: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.grey[200],
              ),
              child: Column(
                children: [
                  // Image.network(
                  //   'https://api.zenify-trip.continuousnet.com/api/activities/${activity.agency!.logo.toString()}',
                  //   width: 100, // set the desired width
                  //   height: 100, // set the desired height
                  // ),
                  Text(
                    activity.agency!.name.toString(),
                    style: TextStyle(
                      color: Color(0xFF00CDE7),
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            SizedBox(
              height: Get.height * 0.3,
            child: Expanded(
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  separatorBuilder: (_, __) => const SizedBox(
                    width: 10,
                  ),
                  shrinkWrap: true,
                  itemCount: activity.images?.length ?? 0,
                  itemBuilder: (BuildContext context, int index) {
                    final url = activity.images![index];
                    return GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (_) => Scaffold(
                            appBar: AppBar(),
                            body: Center(
                              child: Image.network(
                                'http://192.168.1.23:3000/api/activities/uploads/$url',
                                headers: {
                                  'Authorization': 'Bearer $token',
                                },
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                        ));
                      },
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8.0),
                        child: Image.network(
                          'http://192.168.1.23:3000/api/activities/uploads/$url',
                          headers: {
                            'Authorization': 'Bearer $token',
                          },
                          fit: BoxFit.cover,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 120.0),
              child: Divider(
                thickness: 2,
                color: Colors.white,
              ),
            ),
            // Container(
            //   child: Image.network(activity.thumbnailUrl),
            //   width: Get.height * 0.3,
            //   height: Get.height * 0.3,
            // ),

            Text(activity.agencyId.toString()),
            // Text(activity.activityTemplate!.cityId.toString()),
            Text(
              activity.agency!.address.toString(),
              style: TextStyle(
                  color: Color(int.parse(
                          activity.agency!.secondaryColor!.substring(1),
                          radix: 16) +
                      0xFF000000)),
            ),

            // Expanded(
            //     child: Html(data: activity.activityTemplate!.longDescription ,defaultTextStyle: TextStyle( color: Color(int.parse(activity.agency!.primaryColor!.substring(1), radix: 16) + 0xFF000000) ),)),
          ],
          //
        ),
      ),
    );
  }
}

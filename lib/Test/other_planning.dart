import 'dart:async';
import 'dart:convert';
import 'package:flutter_animated_icons/icons8.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:guide_app/Test/AddActivityScreen.dart';
import 'package:guide_app/Test/activitydetalSecreen.dart';
import 'package:guide_app/Test/modele/HttpPlaning.dart';
import 'package:guide_app/Test/modele/TouristGuide.dart';
import 'package:guide_app/Test/modele/activitsmodel/activitesmodel.dart';
import 'package:guide_app/Test/modele/activitsmodel/httpActivites.dart';
import 'package:guide_app/Test/modele/activitsmodel/listactivitey.dart';
import 'package:guide_app/Test/modele/item.dart';
import 'package:guide_app/Test/modele/listPlannig.dart';
import 'package:guide_app/Test/modele/planningmainModel.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';


class Planingtest extends StatefulWidget {
  final GoogleSignInAccount? user;
  final TouristGuide? touristGuide;
  final PlanningMainModel? planning;
  const Planingtest({super.key, this.user, this.touristGuide, this.planning});

  @override
  State<Planingtest> createState() => _PlaningtestState();
}

late AnimationController _animationControllerL;

HTTPHandlerplaning httpHandlerp = HTTPHandlerplaning();
HTTPHandlerActivites activiteshanhler = HTTPHandlerActivites();
final storage = const FlutterSecureStorage();
late Future<List<Item>> item;
//the same
// final httpHandlerp = Get.put(HTTPHandlerplaning());
// late TabController _tabController;
late List<Tab> tabs = [];
late List<Widget> tabViews;
ListPlannings plannig = ListPlannings();
ListActivity activ = ListActivity();
late Future<List<PlanningMainModel>> planninglist;
late Future<List<Activity>> activiteslist;
DateTime? endDate = DateTime.now();
String token = "";
String? planningid = "";
DateTime? startDate = DateTime.now();
String baseurl = "https://api.zenify-trip.continuousnet.com/api/activities";
String baseurlA = "https://api.zenify-trip.continuousnet.com/api/activities";
String baseurlp = "https://api.zenify-trip.continuousnet.com/api/plannings";
bool _showWidget = false;
bool showButton = true;

final http1 = Get.put(HTTPHandlerItem());

class _PlaningtestState extends State<Planingtest>
    with TickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    print("${widget.touristGuide!.id} widget.touristGuide!.id");
// _tabController = TabController(
//       length: tabs.length,
//       vsync: this,
//       initialIndex: 0,
//     );
    planningid = widget.planning!.id;
    _loadData();
    // item = http1.fetchData("tourist-guides");
    // _lodeaddata();
    initializeAsyncState();
    activiteslist = activiteshanhler.fetchData(
        "/api/activities/planningid/996a8585-31d2-4174-911e-d0bb93b2a3f9") as Future<List<Activity>>;
    getDataactivity();
    _refreshData();
    _animationControllerL =
        AnimationController(vsync: this, duration: const Duration(seconds: 1));
    getData();
    getstartDate();
    getenddate();

    planninglist = httpHandlerp
        .fetchData("/api/plannings/touristGuideId/${widget.touristGuide!.id}") as Future<List<PlanningMainModel>>;

    print(activiteslist);
    // var time = httpHandlerp.fetchtime("");

    // print(startDate);
    // print(time);
    // Future.delayed(Duration(seconds: 3), () {
    //   setState(() {
    //     _showWidget = true;
    //   });
    // });
  }

  Future<List<Activity>> _loadData() async {
    final updatedData = await activiteshanhler
        .fetchData("/api/activities/planningid/$planningid");
    setState(() {
      activiteslist = Future.value(updatedData);
    });
    return updatedData;
  }

  // _lodeaddata() async {
  //   await activiteslist;
  //   setState(() {
  //     activiteslist = activiteshanhler.fetchData("activities");
  //   });
  // }

  Future<void> _refreshData() async {
    var updatedData = await activiteshanhler
        .fetchData("/api/activities/planningid/$planningid");
    setState(() {
      activiteslist = Future.value(updatedData);
    });
  }

  Future<void> initializeAsyncState() async {
    await Future.delayed(Duration(seconds: 2));
    startDate = await getstartDate();
    endDate = await getenddate();
    // _lodeaddata();
    // Timer.periodic(Duration(seconds: 10), (timer) {
    //   setState(() {
    //     _refreshData();
    //   });
    // });
    // getData();
// setState(() {
//   endDate =  getenddate();
// });
    // var time = await httpHandlerp.fetchtime("");

    print("**********startDate*************************** " +
        startDate.toString());
    // print(time);

    Future.delayed(Duration(seconds: 3), () {
      setState(() {
        // _showWidget = false;
      });
    });
  }

  Future<DateTime> getstartDate() async {
    var startDate = await getStartDateFromApi();

    return startDate;
  }

  Future<DateTime> getenddate() async {
    var endDate = await gatenddate();

    return endDate;
  }

  Future<DateTime> getStartDateFromApi() async {
    token = (await storage.read(key: "access_token"))!;
    // String baseurlb =
    //     "http://192.168.1.23:3000/api/plannings/touristGuideId/${widget.touristGuide!.id}";
    String? baseUrl = await storage.read(key: "baseurl");
    String baseurlb =
        "${baseUrl}/api/plannings/touristGuideId/${widget.touristGuide!.id}";
    // simulate a delay of 2 seconds to represent a network request to an API
    await Future.delayed(Duration(seconds: 2));
    List<PlanningMainModel> planingList = [];

    final respond = await http
        .get(headers: {"Authorization": "Bearer $token"}, Uri.parse(baseurlb));
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
      print("----------------------------------------------");
      print(r[0]["endDate"]);
      print("----------------------------------------------");

      // for (Map<String, dynamic> d in data) {
      //   Activity activity = Activity.fromJSON(d);
      //   activityList.add(activity);
      // }
      // return result;
      return DateTime.parse(r[0]["startDate"]);
// r.map((e) => PlanningMainModel.fromJson({"results": e})).toList();
      // return activityList;
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('${respond.statusCode}');
    }
  }

  Future<DateTime> gatenddate() async {
    // String baseurlb = "https://api.zenify-trip.continuousnet.com/api/plannings";
    // String baseurlb =
    //     "http://192.168.1.23:3000/api/plannings/touristGuideId/${widget.touristGuide!.id}";
    String? baseUrl = await storage.read(key: "baseurl");
    String baseurlb =
        "${baseUrl}/api/plannings/touristGuideId/${widget.touristGuide!.id}";
    // simulate a delay of 2 seconds to represent a network request to an API

    List<PlanningMainModel> planingList = [];
    token = (await storage.read(key: "access_token"))!;
    final respond = await http
        .get(headers: {"Authorization": "Bearer $token"}, Uri.parse(baseurlb));
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
      print("------------------------------iiiiiiiiiiiii----------------");
      print(r[0]["startDate"]);
      print("---------------------------------------iiiiiiii-------");

      // for (Map<String, dynamic> d in data) {
      //   Activity activity = Activity.fromJSON(d);
      //   activityList.add(activity);
      // }
      // return result;
      return DateTime.parse(r[0]["endDate"]);
// r.map((e) => PlanningMainModel.fromJson({"results": e})).toList();
      // return activityList;
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('${respond.statusCode}');
    }
  }

  @override
  Widget build(BuildContext context) {
    tabViews = [];
    List<Tab> tabs = [];
    for (var date = startDate;
        date!.isBefore(endDate!);
        date = date.add(Duration(days: 1))) {
      tabs.add(Tab(text: '${date.day}/${date.month}'));
    }
    tabViews.add(_buildTabView(endDate!));
    tabs.add(Tab(text: '${endDate!.day}/${endDate!.month}'));

// Future<DateTime> futureDate =
//         Future.value(DateTime.now().add(Duration(days: 1)));
// futureDate.then((date) {
//       if (date.isBefore(DateTime.now())) {
//         print("The date is in the past.");
//       } else {
//         print("The date is in the future.");
//       }
//     });
    // Create a list of tabs for each date between the start and end dates

    return DefaultTabController(
      length: tabs.length,
      child: Scaffold(
//           bottomSheet: showButton
//               ? Container(
//                   height: 80,
//                   margin: const EdgeInsets.only(
//                     top: 12,
//                   ),
//                   child: Row(
//                     children: [
//                       Expanded(
//                         child: FutureBuilder(
//                           future: item,
//                           builder: (context, snapshot) {
//                             if (snapshot.hasData) {
//                               return ListView.builder(
//                                 scrollDirection: Axis.horizontal,
//                                 itemCount: snapshot.data!.length,
//                                 itemBuilder: (context, index) {
//                                   return GestureDetector(
//                                     onTap: () {
//                                       print(snapshot.data![index].id);
// //                                       Navigator.of(context)
// //                                           .push(MaterialPageRoute(builder: (_) {
// //                                         return Container();
// // // bu(snapshot.data![index]);
// //                                       }));
//                                     },
//                                     child: buttonshetCard(
//                                         snapshot.data![index].id,
//                                         snapshot.data![index].title),
//                                     // int red = Random().nextInt(256);
//                                     // int green = Random().nextInt(256);
//                                     // int blue = Random().nextInt(256);
//                                     // List<String> _selectedOptions =
//                                     //     List.filled(snapshot.data!.length, 'Status');
//                                     // _backgroundColors =
//                                     //     _colors[Random().nextInt(_colors.length)];
//                                     // Set the new background color
//                                     // Color backgroundColor =
//                                     //     Color.fromARGB(255, red, green, blue);

//                                     // if (index == 0 &&
//                                     //     snapshot.data![index].albumId == 0) {
//                                     //   return Column(
//                                     //     children: [
//                                     //       const SizedBox(
//                                     //         height: 20,
//                                     //       ),
//                                     //       buildCard(snapshot.data![index], index,
//                                     //           backgroundColor, _selectedOptions),
//                                     //     ],
//                                     //   );
//                                     // } else {
//                                     //   return buildCard(snapshot.data![index], index,
//                                     //       backgroundColor, _selectedOptions);
//                                     // }
//                                   );
//                                 },
//                               );
//                             } else if (snapshot.hasError) {
//                               return const Center(
//                                 child: Text('Something went wrong'),
//                               );
//                             } else {
//                               return const Center(
//                                 child: CircularProgressIndicator(),
//                               );
//                             }
//                           },
//                         ),

// //  ListView.builder(
//                         //   scrollDirection: Axis.horizontal,
//                         //   itemCount: 10,
//                         //   itemBuilder: (BuildContext context, int index) {
//                         //     return buttonshetCard(index);
//                         //   },
//                         // ),
//                       ),

// // DUMMY_CATEGORIES.map((item)=>buttonshetCard()).toList(),
//                       // ImageIcon(image)
//                       // Image.network(
//                       //   'https://picsum.photos/200/300?random=$index',
//                       //   height: 120,
//                       //   width: 120,
//                       // ),
//                       //   ElevatedButton(
//                       //     onPressed: () {
//                       //       // Do something when the button is pressed
//                       //       Get.to(AddHotel());

//                       //       // logout();
//                       //     },
//                       //     style: ElevatedButton.styleFrom(
//                       //       primary: Color.fromARGB(0, 12, 12, 12),
//                       //       onPrimary: Colors.black,
//                       //     ),
//                       //     child: Icon(Icons.mode_edit),
//                       //   ),

//                       //   // Icon(Icons.add),
//                     ],
//                   ),
//                 )
//               // )
//               : null,
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(70),
            child: AppBar(
              automaticallyImplyLeading: false,
              flexibleSpace: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Color.fromARGB(255, 252, 252, 253),
                      Color.fromARGB(255, 252, 252, 253)
                    ],
                  ),
                ),
              ),

              actions: <Widget>[
                Row(
                  children: [
                    IconButton(
                      icon: Icon(Icons.notification_add_rounded),
                      onPressed: () {
                        // Navigator.push(
                        //     context,
                        //     MaterialPageRoute(
                        //       builder: (context) =>null,
                        //     ));
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(
                        //       builder: (context) =>
                        //            NotificationActivityScreen()),
                        // );
                      },
                      color: Color.fromARGB(255, 243, 242, 245),
                    ),
                    // IconButton(
                    //   icon: Icon(Icons.menu_sharp),
                    //   onPressed: () {
                    //     // Navigator.push(
                    //     //     context,
                    //     //     MaterialPageRoute(
                    //     //       builder: (context) =>null,
                    //     //     ));
                    //     Navigator.push(
                    //       context,
                    //       MaterialPageRoute(builder: (context) => SettingsPage()),
                    //     );
                    //   },
                    //   color: Color.fromARGB(255, 243, 242, 245),
                    // ),
                    //                 GestureDetector(
                    //                   onTap: () {
                    //                     _animationController.reset();
                    //                     _animationController.forward();
                    //                     Future.delayed(Duration(milliseconds: 800), () {
                    //                       Navigator.push(
                    //                         context,
                    //                         MaterialPageRoute(
                    //                             builder: (context) => SettingsPage()),
                    //                       );
                    //                     });

                    //                   },
                    //                   child: AnimatedIcon(
                    // size: 35,
                    //                     icon: AnimatedIcons.list_view,
                    //                     progress: _animationController,
                    //                   ),
                    //                 ),
                    InkWell(
                      // onTap: () {
                      //   Get.to(GenerateQRPage());
                      // },
                      child: SizedBox(
                        height: 45,
                        child: SvgPicture.asset(
                          'assets/scc.svg',
                          height: 25,
                          width: 25,
                          // color: Color.fromARGB(255, 49, 8, 236),
                        ),
                        // Image.asset('assets/LL.jpg'),
                      ),
                    ),
                    IconButton(
                      splashRadius: 20,
                      iconSize: 20,
                      color: Color.fromARGB(255, 175, 10, 10),
                      onPressed: () {
                        // _animationControllerL.reset();
                        // _animationControllerL.forward();
                        // setState(() {
                        //   _showButton = !_showButton;
                        // });
                      },
                      icon: Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: Lottie.asset(
                          Icons8.list,
                          controller: _animationControllerL,
                        ),
                      ),
                    ),
                    // IconButton(
                    //   splashRadius: 50,
                    //   iconSize: 100,
                    //   onPressed: () {
                    //     if (_menuController.status == AnimationStatus.dismissed) {
                    //       _menuController.reset();
                    //       _menuController.animateTo(0.6);
                    //     } else {
                    //       _menuController.reverse();
                    //     }
                    //   },
                    //   icon: Lottie.asset(Useanimations.facebook,
                    //       controller: _menuController,
                    //       height: 60,
                    //       fit: BoxFit.fitHeight),
                    // ),
                  ],
                ),
              ],
              backgroundColor: Color.fromARGB(255, 242, 242, 244),
              title: InkWell(
                // onTap: () {
                //   Get.to(GenerateQRPage());
                // },
                child: SizedBox(
                  height: 45,
                  child: SvgPicture.asset(
                    'assets/Frame.svg',
                    height: 30,
                    width: 30,
                    // color: Color.fromARGB(255, 49, 8, 236),
                  ),
                  // Image.asset('assets/LL.jpg'),
                ),
              ),
              // const Text('Plannig'),
              bottom: PreferredSize(
                preferredSize: Size.fromHeight(kToolbarHeight),
                child: Column(
                  children: [
                    Text(widget.planning!.id.toString()),
                    Text(widget.touristGuide!.id.toString())
                  ],
                ),
              ),
            ),
          ),
          body: _showWidget
              ? Center(
                  //   child: ListView.builder(
                  //       itemCount: activ.results!.length,
                  //       itemBuilder: (context, index) {
                  //         if (activ.results![index] != null) {
                  //           Future.delayed(Duration(seconds: 5), () {
                  //             setState(() {
                  //               // _showWidget = true;
                  //             });
                  //           });
                  //           // access properties or methods on myVariable
                  //           return datashow(activ.results![index]);
                  //         } else {
                  //           // handle the case where myVariable is null
                  //           return null;
                  //         }

                  //         // access properties or methods on myVariable

                  //         // handle the case where myVariable is null
                  //       }),
                  // )

                  //     FutureBuilder(
                  //   future: planninglist,
                  //   builder: (context, snapshot) {
                  //     if (snapshot.hasData) {
                  //       return ListView.separated(
                  //         itemCount: snapshot.data!.length,
                  //         separatorBuilder: (context, index) {
                  //           return Divider();
                  //         },
                  //         itemBuilder: (context, index) {
                  //   return datashow(snapshot.data![index]);},
                  //       );
                  //     } else if (snapshot.hasError) {
                  //       print(snapshot.hasError);
                  //       return const Center(
                  //         child: Text('Something went wrong'),
                  //       );
                  //     } else {
                  //       return const Center(
                  //         child: CircularProgressIndicator(),
                  //       );
                  //     }
                  //   },
                  // ),)

                  child: FutureBuilder(
                    future: activiteslist,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return ListView.separated(
                          itemCount: snapshot.data!.length,
                          separatorBuilder: (context, index) {
                            return Divider();
                          },
                          itemBuilder: (context, index) {
                            return datashow(snapshot.data![index]);
                          },
                        );
                      } else if (snapshot.hasError) {
                        print(snapshot.hasError);
                        return const Center(
                          child: Text('snapshot.hasError'),
                        );
                      } else {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                    },
                  ),
                )
              : MyScaffold(
                  startDate: startDate,
                  endDate: endDate,
                  activityList: activiteslist,
                  planningId: planningid,
                )
// ActivityCalendar(
//                   startDate: startDate,
//                   endDate: endDate,
          // ),
//  IndexedStack(
//                 children: tabViews,
//               ),

          // TabBarView(
          //     children: tabs.map((Tab tab) {
          //       return FutureBuilder(
          //         future: activityList,
          //         builder: (context, snapshot) {
          //           if (snapshot.hasData) {
          //             return ListView.separated(
          //               itemCount: snapshot.data!.length,
          //               separatorBuilder: (context, index) {
          //                 return Divider();
          //               },
          //               itemBuilder: (context, index) {
          //                 return datashow(snapshot.data![index]);
          //               },
          //             );
          //           } else if (snapshot.hasError) {
          //             print(snapshot.hasError);
          //             return const Center(
          //               child: Text('Something went wrong'),
          //             );
          //           } else {
          //             return const Center(
          //               child: CircularProgressIndicator(),
          //             );
          //           }
          //         },
          //       );
          //     }).toList(),
          //   ),
// TabBarView(
//           children: tabs.map((Tab tab) {
//             return ListView.builder(
//               itemCount: 10, // Replace with your dynamic list length
//               itemBuilder: (context, index) {
//                 return ListTile(
//                   title: Text(
//                       'Item $index for ${tab.text!}'), // Replace with your dynamic list item
//                 );
//               },
//             );
//           }).toList(),
//         ),
// : Container(
          //     child: Center(
          //       child: Column(
          //         children: [

          //           Text("waiting data to be loaded"),
          //           CircularProgressIndicator()
          //         ],
          //       ),
          //     ),
          //   ),
          ),
    );
  }

  void getData() async {
    // print("test");
    var res = await http.get(headers: {
      "Authorization":
          "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjljYjEwZDQ4LWY3YWItNDYwNC05MGU5LTA4NzJmNDg0ZmM0MyIsInN1YiI6IjljYjEwZDQ4LWY3YWItNDYwNC05MGU5LTA4NzJmNDg0ZmM0MyIsInVzZXJuYW1lIjoic2E3Ym9vY2gzIiwiZW1haWwiOiJzYTdib29jaDNAZ21haWwuY29tIiwicm9sZSI6IkFkbWluaXN0cmF0b3IiLCJmaXJzdE5hbWUiOiJTYWhiaTMiLCJsYXN0TmFtZSI6IktoYWxmYWxsYWgiLCJleHBpcmVzIjoxNjgzMTQzMDk1LCJjcmVhdGVkIjoxNjgzMDU2Njk1LCJpYXQiOjE2ODMwNTY2OTUsImV4cCI6MTY4MzE0MzA5NX0.26y4gv-o-FndWBwqeR_mN0hAfSLkZEIodUUTw2pjPjI"
    }, Uri.parse(baseurl));
    print(res.statusCode);

    var r = json.decode(res.body);
    print(r);
    final data = r["results"];
    print(
        "***********************************************************************************");
    print(data);
    print(
        "***********************************************************************************");

    setState(() {
      plannig = ListPlannings.fromJson({"results": data});
    });
  }

  void getDataactivity() async {
    // print("test");
    var res = await http.get(headers: {
      "Authorization":
          "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjljYjEwZDQ4LWY3YWItNDYwNC05MGU5LTA4NzJmNDg0ZmM0MyIsInN1YiI6IjljYjEwZDQ4LWY3YWItNDYwNC05MGU5LTA4NzJmNDg0ZmM0MyIsInVzZXJuYW1lIjoic2E3Ym9vY2gzIiwiZW1haWwiOiJzYTdib29jaDNAZ21haWwuY29tIiwicm9sZSI6IkFkbWluaXN0cmF0b3IiLCJmaXJzdE5hbWUiOiJTYWhiaTMiLCJsYXN0TmFtZSI6IktoYWxmYWxsYWgiLCJleHBpcmVzIjoxNjgzMTQzMDk1LCJjcmVhdGVkIjoxNjgzMDU2Njk1LCJpYXQiOjE2ODMwNTY2OTUsImV4cCI6MTY4MzE0MzA5NX0.26y4gv-o-FndWBwqeR_mN0hAfSLkZEIodUUTw2pjPjI"
    }, Uri.parse(baseurl));
    print(res.statusCode);

    var r = json.decode(res.body);
    print(r);
    final data = r["results"];
    print(
        "***********************************************************************************");
    print(data);
    print(
        "***********************************************************************************");
    setState(() {
      activ = ListActivity.fromJson({"results": data});
    });
  }

  Widget datashow(Activity obj) {
    return Container(
      height: 200,
      child: Card(
        color: Colors.amber,
        child: Column(
          children: [
            Text("id :${obj!.agencyId}"),
            Text("creatorUser :${obj!.creatorUserId}"),
            Text("creatorUser :${obj.agency!.id}"),
            Text("startDate:$startDate"),
            Text("enddate:$endDate"),
          ],
        ),
      ),
    );
  }

// Widget _buildTabView(DateTime date) {
//     // Build the list view for each tab
//     return ListView.builder(
//       itemCount: 10, // Replace with the actual number of items
//       itemBuilder: (context, index) {
//         return ListTile(
//           title: Text('Item $index on ${date.day}/${date.month}'),
//         );
//       },
//     );
//   }
  Widget _buildTabView(DateTime date) {
    // Fetch the activity data for the given date from the API
    Future<List<String>> _fetchActivityData(DateTime date) async {
      // Replace this with your actual API call to fetch activity data
      await Future.delayed(Duration(seconds: 2)); // Simulate a network delay
      return List.generate(
          10, (index) => 'Activity $index on ${startDate}/${date.month}');
    }

    // Build the list view for each tab
    return FutureBuilder(
      future: _fetchActivityData(date),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else {
          final activityData = snapshot.data;
          return ListView.builder(
            itemCount: activityData!.length,
            itemBuilder: (context, index) {
              final activity = activityData[index];
              return ListTile(
                title: Text(activity),
              );
            },
          );
        }
      },
    );
  }

  buttonshetCard(index, item) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      elevation: 5,
      margin: const EdgeInsets.only(left: 12, right: 12, bottom: 12),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          // ImageIcon(image)

          // Image.network(

          //   'https://picsum.photos/200/300?random=$index',

          //   height: 120,

          //   width: 120,

          // ),

          // ListTile(

          //     title: Text('Item$index'),

          //     onTap: () {

          //       Navigator.push(context, MaterialPageRoute( builder: (context) => AddHotel(item)));

          //       })

          Icon(Icons.image),

          Text('Item$index'),
          Text(item),

          Icon(Icons.list_alt_sharp),
        ],
      ),
    );
  }
}

class MyScaffold extends StatefulWidget {
  // final DateTime startDate = DateTime.now();
  // final DateTime endDate = DateTime.now().add(Duration(days: 7));
  Timer? timer;
  final DateTime? startDate;
  final DateTime? endDate;
  Future<List<Activity>>? activityList;
  String? planningId;
  MyScaffold(
      {this.startDate, this.endDate, this.activityList, this.planningId});

  _MyScaffoldState createState() => _MyScaffoldState();
}

class _MyScaffoldState extends State<MyScaffold> with TickerProviderStateMixin {
  @override
  var activiteslist1;
  void initState() {
    super.initState();
    data();
    _loadData();
    _lodeaddata();
  }

  // Timer.periodic(Duration(seconds: 10), (timer) {
  //   setState(() {
  //     _refreshData();
  //   });
  // });
  Future<List<Activity>> _loadData() async {
    // String? baseUrl = await storage.read(key: "baseurl");

    final updatedData = await activiteshanhler
        .fetchData("/api/activities/planningid/$planningid");
    setState(() {
      activiteslist = Future.value(updatedData);
    });
    return updatedData;
  }

  // Future<List<Activity>>? _lodeaddata() async {
  //   var f = await activiteslist;
  //   var updatedData = await activiteshanhler.fetchData("activities");
  //   //   setState(() {
  //   //  var updatedData =  activiteshanhler.fetchData("activities");
  //   //   });
  //   return f;
  // }
  Future<List<Activity>>? _lodeaddata() async {
    // String? baseUrl = await storage.read(key: "baseurl");
    setState(() {
      activiteslist1 =
          // activiteshanhler.fetchData("activities?offset=0&limit=2");
          activiteshanhler.fetchData("/api/activities/planningid/$planningid");
    });
    return activiteslist1;
  }

  Future<List<Activity>>? data() {
    setState(() {
      activiteslist = _lodeaddata()!;
    });

    return activiteslist;
  }

  @override
  Widget build(BuildContext context) {
// final List<DateTime> dates = getRangeOfDates(startDate, endDate);
    return DefaultTabController(
      length: endDate!.difference(startDate!).inDays,
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.red,
            leadingWidth: 0.2,
            leading: InkWell(
              onTap: () {
                print("hi");
              },
              child: SizedBox(
                width: 200,
                height: 200,
                child: PopupMenuButton(
                  color: Color.fromARGB(225, 232, 218, 218),
                  itemBuilder: (BuildContext context) {
                    return [
                      PopupMenuItem(
                        child: Container(
                            child: Row(
                          children: [
                            Text('add new  client'),
                            Icon(size: 20, Icons.person_2),
                          ],
                        )),
                        value: 1,
                      ),
                      PopupMenuItem(
                        child: Text('add new Activity'),
                        value: 2,
                      ),
                      PopupMenuItem(
                        child: Text('Menu item 3'),
                        value: 3,
                      ),
                    ];
                  },
                  onSelected: (value) {
                    if (value == 1) {
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //       builder: (context) => AddClientScreen()),
                      // );
                    } else if (value == 2) {
                      setState(() {
                        // showButton = !showButton;
                        //Get.to(AddActtivityForm());
                        print(showButton);
                      });
                    } else if (value == 3) {
                      setState(() {
                        // showButton = !showButton;
                        //   Get.to(AddActtivityForm( activityList: activityList,));
                        //   print(showButton);
                      });
                    }
                  },
                  child: Icon(size: 20, Icons.menu),
                ),
              ),
            ),
            title: Column(
              children: [
                Row(
                  children: [
                    // IconButton(
                    //   icon: Icon(Icons.menu),
                    //   onPressed: () {
                    //     print("hi");
                    //   },
                    // ),
                    SizedBox(width: 20),
                    Text('Planning'),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    //     IconButton(
                    //       icon: Icon(Icons.arrow_back),
                    //       onPressed: () {
                    //         // Do something when the icon button is pressed
                    //       },
                    //     ),
                    // Text(

                    //         "Planning",
                    //           style: TextStyle(fontSize: 35),
                    //         ),
                    Text(
                      DateFormat('  MMMM  d ,y ').format(startDate!),
                      style: TextStyle(fontSize: 20),
                    ),
                    Text(
                      DateFormat(' ~ MMMM  d ,y ').format(endDate!),
                      style: TextStyle(fontSize: 20),
                    ),
                    //    ElevatedButton(
                    //                 onPressed: () {},
                    //                 child: Text(""),
                    //               ),

                    // SizedBox(width: 30),

                    // Column(
                    //   children: [
                    //     SizedBox(height: 16),
                    //     Text(
                    //       "Planning",
                    //       style: TextStyle(fontSize: 40),
                    //     ),
                    //     SizedBox(height: 16),
                    //     ElevatedButton(
                    //       onPressed: () {},
                    //       child: Text(""),
                    //     ),
                    //     SizedBox(height: 16),
                    //   ],
                    // ),
                  ],
                ),
              ],
            ),
            bottom: PreferredSize(
              preferredSize: Size.fromHeight(50),
              child: Container(
                color: Colors.white,
                child: buildTabBar(
                  startDate!,
                  endDate!,
                ),
              ),
            ),
          ),
          body: TabBarView(
            children: List.generate(
              endDate!.difference(startDate!).inDays,
              (index) => _buildTabView(startDate!.add(Duration(days: index))),
            ),
          )),
    );
  }

  Widget _buildTabView(DateTime date) {
    Future<List<Activity>> _fetchActivityData(DateTime date) async {
      final activities = await data();
      return activities!
          .where((activity) =>
              activity.departureDate != null &&
              activity.returnDate != null &&
              activity.departureDate!.isBefore(date.add(Duration(days: 1))) &&
              activity.returnDate!.isAfter(date))
          .toList();
    }

    // Build the list view for each tab
    return RefreshIndicator(
      onRefresh: () => _fetchActivityData(date),
      child: FutureBuilder<List<Activity>>(
        future: _fetchActivityData(date),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            final activityData = snapshot.data;
            return ListView.separated(
              separatorBuilder: (context, index) {
                return Divider();
              },
              itemCount: activityData!.length,
              itemBuilder: (context, index) {
                final activity = activityData[index];
                return buildCard(snapshot.data![index], index
                    // _backgroundColors,
                    );
                // ListTile(
                //   title: Text(snapshot.data![index].id as String),
                //   subtitle: Text(snapshot.data![index].adultPrice.toString()),
                // );
              },
            );
          }
        },
      ),
    );
  }
//   Widget _buildTabView(DateTime date) {
//     Future<List<Activity>> _fetchActivityData(DateTime date) async {
//       final activities = await data();
//       return activities!
//           .where((activity) =>
//               activity.departureDate!.isBefore(date.add(Duration(days: 1))) &&
//               activity.returnDate!.isAfter(date.add(-Duration(days: 1))))
//           .toList();
//     }

//     // Build the list view for each tab
//     return FutureBuilder<List<Activity>>(
//       future: _fetchActivityData(date),
//       builder: (context, snapshot) {
//         if (snapshot.connectionState == ConnectionState.waiting) {
//           return Center(child: CircularProgressIndicator());
//         } else if (snapshot.hasError) {
//           return Center(child: Text('Error: ${snapshot.error}'));
//         } else {
//           final activityData = snapshot.data;
//           return ListView.separated(
//             separatorBuilder: (context, index) {
//               return Divider();
//             },
//             itemCount: activityData!.length,
//             itemBuilder: (context, index) {
//               final activity = activityData[index];
//               return buildCard(snapshot.data![index], index
//                   // _backgroundColors,
//                   );
// // ListTile(
// //                 title: Text(snapshot.data![index].id as String),
// // subtitle: Text(snapshot.data![index].adultPrice.toString()),
// //               );
//             },
//           );
//         }
//       },
//     );
//   }

  buildCard(
    Activity activity,
    index,
  ) {
    List<String> _selectedOptions1 = List.filled(1000, 'Status');

    return Card(
      elevation: 7,
      margin: const EdgeInsets.only(left: 16, right: 16),
      child: Container(
        color: Color.fromARGB(255, 172, 174, 174),
        child: Container(
          height: Get.height * 0.3,
          margin: const EdgeInsets.only(left: 2),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "${DateFormat('kk:mm').format(activity.departureDate ?? DateTime.now())} ${DateFormat('- kk:mm ').format(activity.returnDate ?? DateTime.now())}"
                    // "${DateFormat(' kk:mm ').format(DateTime.now())}  ${DateFormat('- kk:mm ').format(DateTime.now())}",
                    ,
                    style: const TextStyle(fontSize: 14),
                  ),
                  Row(
                    children: [
                      IconButton(
                        // splashRadius: 20,
                        // iconSize: 20,
                        color: Color.fromARGB(255, 175, 10, 10),
                        onPressed: () {
                          // _animationController.reset();
                          // _animationController.forward();
                        },
                        icon: Padding(
                          padding: const EdgeInsets.only(top: 2.0, bottom: 3.0),
                          child: Lottie.asset(
                            Icons8.bell,
                            // controller: _animationController,
                          ),
                        ),
                      ),
//                       IconButton(
//                         // splashRadius: 20,
//                         // iconSize: 12,
//                         color: Color.fromARGB(255, 175, 10, 10),
//                         onPressed: () {
//                           // _animationController.reset();
//                           // _animationController.forward();
//                           setState(() {
//                             activiteslist1.removeAt(
//                                 index); // replace index with the desired index to remove
//                           });
//                         },
//                         icon: Padding(
//                             padding: const EdgeInsets.only(
//                                 top: 3.0, bottom: 3.0, right: 3.0),
//                             child: Image.asset('assets/M1.png')
// //  Lottie.asset(
// //                             Icons8.list,
// //                             controller: _animationController,
// //                           ),
//                             ),
//                       ),
//
                      PopupMenuButton<String>(
                        itemBuilder: (BuildContext context) =>
                            <PopupMenuEntry<String>>[
                          PopupMenuItem<String>(
                            value: 'delete',
                            child: Text('Delete'),
                          ),
                          PopupMenuItem<String>(
                            value: 'update',
                            child: Text('Update'),
                          ),
                          PopupMenuItem<String>(
                            value: 'Add new Activity',
                            child: Text('Add new Activity'),
                          ),
                        ],
                        onSelected: (String value) {
                          if (value == 'delete') {
                            // Perform delete action
                          } else if (value == 'update') {
                            // Perform update action
                          } else if (value == 'Add new Activity') {
                            // Get.to(AddActtivityForm(activity: activity));
                            Get.to(AddActivityScreen());
                          }
                        },
                        icon: Icon(Icons.more_vert),
                      )
                    ],
                  )
                ],
              ),
              Container(
                color: Color.fromARGB(255, 246, 248, 249),
                height: Get.height * 0.1,
                // padding: const EdgeInsets.all(2),
                alignment: Alignment.center,
                child: ListTile(
                  onTap: () {
                    print(index);

                    Get.to(activitydetalSecreen(activity, token));
                  },
                  title: Text(
// activity.title
                      activity.name?.toString() ?? 'N/A',
                      style: TextStyle(
                          fontSize: 24,
                          height: 0,
                          fontStyle: FontStyle.italic)),
// leading: SizedBox(
//                     width: 80,
//                     height: 80,
//                     child: Stack(
//                       children: [
//                        for (var url in activity.images ?? [])
//                           Positioned.fill(
//                             child: ClipOval(
//                               child: Image.network(
//                                 'http://192.168.1.23:3000/api/activities/uploads/$url',
//                                 headers: {
//                                   'Authorization': 'Bearer $token',
//                                 },
//                                 fit: BoxFit.cover,
//                               ),
//                             ),
//                           ),
//                       ],
//                     ),
//                   ),
                  leading: Container(
                      clipBehavior: Clip.hardEdge,
                      height: 80,
                      //  alignment: Alignment.center,
// width:80,
                      decoration: const BoxDecoration(shape: BoxShape.circle),
                      child: SizedBox(
                        height: 80,
                        width: 40,
                        child: Image.network(
                            'http://192.168.1.23:3000/api/activities/img/${activity.logo}',
                            headers: {
                              'Authorization': 'Bearer $token',
                            },
                            fit: BoxFit.fitWidth
                            //     .cover, // or BoxFit.fill, BoxFit.fitWidth, BoxFit.fitHeight, etc.
                            ),
                      )),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Column(
                    children: [
                      Text(
                        "${DateFormat(' kk:mm ').format(DateTime.now())}  ${DateFormat('- kk:mm ').format(DateTime.now())}",
                        style: const TextStyle(fontSize: 14),
                      ),
                      Text(
                        "${DateFormat(' kk:mm ').format(DateTime.now())}  ${DateFormat('- kk:mm ').format(DateTime.now())}",
                        style: const TextStyle(fontSize: 14),
                      ),
                    ],
                  ),
                  SizedBox(width: 180),
// IconButton(
//                     // splashRadius: 20,
//                     // iconSize: 12,
//                     color: Color.fromARGB(255, 175, 10, 10),
//                     onPressed: () {
//                       // _animationController.reset();
//                       // _animationController.forward();
//                     },
//                     icon: Icon(Icons.mode_edit),
//                   ),

//                   Text(
//                     'Modifie',
//                     style: TextStyle(color: Colors.black),
//                   ),

                  // DropdownButton<String>(
                  //   value: selectedOption,
                  //   items: _options.map((String option) {
                  //     return DropdownMenuItem<String>(
                  //       value: option,
                  //       child: Text(option),
                  //     );
                  //   }).toList(),
                  //   onChanged: (String? newValue) {
                  //     setState(() {
                  //       print(selectedOption);
                  //       selectedOption = newValue!;

                  //       print(newValue);
                  //     });
                  //   },
                  // ),

                  // ElevatedButton(
                  //   onPressed: () {
                  //     // Do something when the button is pressed
                  //     Get.to(ActivityEditScreen(activity));

                  //     // logout();
                  //   },
                  //   style: ElevatedButton.styleFrom(
                  //     primary: Colors.white,
                  //     onPrimary: Colors.black,
                  //   ),
                  //   child: Row(
                  //     children: [
                  //       Icon(Icons.mode),
                  //       SizedBox(width: 8),
                  //       Text(
                  //         'status',
                  //         style: TextStyle(color: Colors.black),
                  //       ),
                  //     ],
                  //   ),
                  // ),
                  // DropdownButton(
                  //   items: _dropDownItem(),
                  //   onChanged: (value) {
                  //     setState(() {
                  //       print('${index} and ${value}');
                  //     });
                  //   },
                  //   value: selectedItemValue[3],
                  //   hint: Text('0'),
                  // ),
//this what i will use with api
                  SizedBox(width: 2),
                ],
              ),
              const Divider(
                color: Colors.black,
                indent: 14,
                endIndent: 14,
                thickness: 1.8,
              ),
              Column(
                children: [
                  Row(
                    children: [
                      SizedBox(width: 20),
                      Text(
                        "france tunisia",
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w200,
                        ),
                      ),
                      SizedBox(width: 40),
                      Text(
                        "france tunisia",
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w200,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      SizedBox(width: 20),
                      Text(
                        "${DateFormat('EEE, MMM d').format(DateTime.now())}",
                      ),
                      SizedBox(width: 40),
                      Text(
                        "${DateFormat('EEE, MMM d').format(DateTime.now())}",
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      const SizedBox(width: 20),
                      Text(
                        "ASl France",
                        style: const TextStyle(
                            fontSize: 14, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(width: 20),
                      Icon(Icons.account_box),
                    ],
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Future<List<String>> _fetchActivityData(DateTime date) async {
  //   final url = 'https://example.com/api/activity?date=${date.toString()}';
  //   final response = await http.get(Uri.parse(url));

  //   if (response.statusCode == 200) {
  //     final List<dynamic> data = json.decode(response.body);
  //     final List<String> activities = data
  //         .map((activity) =>
  //             'Activity ${activity['id']} on ${date.day}/${date.month}')
  //         .toList();
  //     return activities;
  //   } else {
  //     throw Exception('Failed to fetch activity data');
  //   }
  // }

  // Widget _buildTabView(DateTime date) {
  //   // Fetch the activity data for the given date from the API
  //   Future<List<String>> _fetchActivityData(DateTime date) async {
  //     // Replace this with your actual API call to fetch activity data for the given date
  //     await Future.delayed(Duration(seconds: 2)); // Simulate a network delay
  //     final activities = await _fetchActivityData(date);
  //     return List.generate(
  //         activities.length,
  //         (index) =>
  //             'Activity ${activities[index]} on ${date.day}/${date.month}');
  //   }

  //   // Build the list view for each tab
  //   return FutureBuilder<List<String>>(
  //     future: _fetchActivityData(date),
  //     builder: (context, snapshot) {
  //       if (snapshot.connectionState == ConnectionState.waiting) {
  //         return Center(child: CircularProgressIndicator());
  //       } else if (snapshot.hasError) {
  //         return Center(child: Text('Error: ${snapshot.error}'));
  //       } else {
  //         final activityData = snapshot.data;
  //         return ListView.builder(
  //           itemCount: activityData!.length,
  //           itemBuilder: (context, index) {
  //             final activity = activityData[index];
  //             return ListTile(
  //               title: Text(activity),
  //             );
  //           },
  //         );
  //       }
  //     },
  //   );
  // }

// Build the tab bar with a tab for each day in the date range
  TabBar buildTabBar(DateTime startDate, DateTime endDate) {
    final List<Tab> tabs = [];
    final List<Widget> tabViews = [];

    for (var date = startDate;
        date.isBefore(endDate);
// .add(Duration(days: 1)));
        date = date.add(Duration(days: 1))) {
      tabs.add(Tab(text: DateFormat('EEE, MMM d').format(date)));
      tabViews.add(_buildTabView(date));
    }

    // return TabBar(
    //   tabs: tabs,
    //   isScrollable: true,
    // );
    return TabBar(
      // controller: controller,
      tabs: tabs,

      isScrollable: true,
      indicatorColor: Colors.blue,
      labelColor: Colors.blue,
      unselectedLabelColor: Colors.grey,
      labelStyle: TextStyle(fontWeight: FontWeight.bold),
      unselectedLabelStyle: TextStyle(fontWeight: FontWeight.bold),
      indicatorSize: TabBarIndicatorSize.label,
      indicatorWeight: 2.0,
      indicatorPadding: EdgeInsets.symmetric(horizontal: 16),
      labelPadding: EdgeInsets.symmetric(horizontal: 16),
      onTap: (index) {},
    );
  }
}

List<DateTime> getRangeOfDates(DateTime startDate, DateTime endDate) {
  final List<DateTime> dates = [];

  for (var date = startDate;
      date.isBefore(endDate);
      date = date.add(Duration(days: 1))) {
    dates.add(date);
  }

  // Add the end date to the list
  dates.add(endDate);

  return dates;
}
// class ActivityCalendar extends StatefulWidget {
//   final DateTime? startDate;
//   final DateTime? endDate;

//   ActivityCalendar({this.startDate, this.endDate});

//   @override
//   _ActivityCalendarState createState() => _ActivityCalendarState();
// }

// class _ActivityCalendarState extends State<ActivityCalendar> {
//   late List<Tab> _tabs;
//   late List<Widget> _tabViews;

//   @override
//   void initState() {
//     super.initState();

//     _tabs = [];
//     _tabViews = [];
// if (startDate != null && endDate != null ) {
//       for (var date = widget.startDate;
//           date!.isBefore(widget.endDate);
//           date = date!.add(Duration(days: 1))) {
//         _tabs.add(Tab(text: '${date!.day}/${date.month}'));
//         _tabViews.add(_buildTabView(date));
//       }
//       _tabs.add(Tab(text: '${widget.endDate!.day}/${widget.endDate!.month}'));
//       _tabViews.add(_buildTabView(widget.endDate));
//     }
//   }

//   Future<List<String>> _fetchActivityData(DateTime date) async {
//     // Replace this with your actual API call to fetch activity data
//     await Future.delayed(Duration(seconds: 2)); // Simulate a network delay
//     return List.generate(
//         10, (index) => 'Activity $index on ${date.day}/${date.month}');
//   }

//   Widget _buildTabView(DateTime date) {
//     return FutureBuilder<List<String>>(
//       future: _fetchActivityData(date),
//       builder: (context, snapshot) {
//         if (snapshot.connectionState == ConnectionState.waiting) {
//           return Center(child: CircularProgressIndicator());
//         } else if (snapshot.hasError) {
//           return Center(child: Text('Error: ${snapshot.error}'));
//         } else {
//           final activityData = snapshot.data!;
//           return ListView.builder(
//             itemCount: activityData.length,
//             itemBuilder: (context, index) {
//               final activity = activityData[index];
//               return ListTile(
//                 title: Text(activity),
//               );
//             },
//           );
//         }
//       },
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return DefaultTabController(
//       length: _tabs.length,
//       child: Scaffold(
//         appBar: AppBar(
//           title: Text('Activity Calendar'),
//           bottom: TabBar(
//             tabs: _tabs,
//             isScrollable: true,
//           ),
//         ),
//         body: TabBarView(
//           children: _tabViews,
//         ),
//       ),
//     );
//   }
// }
// class ActivityCalendar extends StatefulWidget {
//   final DateTime? startDate;
//   final DateTime? endDate;

//   ActivityCalendar({required this.startDate, required this.endDate});

//   @override
//   _ActivityCalendarState createState() => _ActivityCalendarState();
// }

// class _ActivityCalendarState extends State<ActivityCalendar> {
//   final List<Tab> _tabs = [];
//   final List<Widget> _tabViews = [];

//   @override
//   void initState() {
//     super.initState();

//   }

//   Future<List<String>> _fetchActivityData(DateTime date) async {
//     // Replace this with your actual API call to fetch activity data
//     await Future.delayed(Duration(seconds: 2)); // Simulate a network delay
//     return List.generate(
//         10, (index) => 'Activity $index on ${date.day}/${date.month}');
//   }

//   Widget _buildTabView(DateTime date) {
//     return FutureBuilder<List<String>>(
//       future: _fetchActivityData(date),
//       builder: (context, snapshot) {
//         if (snapshot.connectionState == ConnectionState.waiting) {
//           return Center(child: CircularProgressIndicator());
//         } else if (snapshot.hasError) {
//           return Center(child: Text('Error: ${snapshot.error}'));
//         } else {
//           final activityData = snapshot.data;
//           return ListView.builder(
//             itemCount: activityData!.length,
//             itemBuilder: (context, index) {
//               final activity = activityData[index];
//               return ListTile(
//                 title: Text(activity),
//               );
//             },
//           );
//         }
//       },
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     for (var date = widget.startDate!;
//         date.isBefore(widget.endDate!);
//         date = date.add(Duration(days: 1))) {
//       _tabs.add(Tab(text: '${date.day}/${date.month}'));
//       _tabViews.add(_buildTabView(date));
//     }
//     _tabs.add(Tab(text: '${widget.startDate!.day}/${widget.endDate!.month}'));
//     _tabViews.add(_buildTabView(widget.endDate!));
//     return DefaultTabController(
//       length: _tabs.length,
//       child: Scaffold(
//         appBar: AppBar(
//           title: Text('Activity Calendar'),
//           bottom: TabBar(
//             tabs: _tabs,
//             isScrollable: true,
//           ),
//         ),
//         body: TabBarView(
//           children: _tabViews,
//         ),
//       ),
//     );
//   }
// }

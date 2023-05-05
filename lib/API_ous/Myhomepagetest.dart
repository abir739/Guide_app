import 'dart:math';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
//import 'package:provider/provider.dart';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';


//import 'package:guide_app/Secreen/TimerService.dart';
//import 'package:guide_app/Secreen/creatitem.dart';
//import 'package:guide_app/Secreen/login_signup.dart';
//import 'package:guide_app/Secreen/services/PushNotificationService.dart';
//import 'package:guide_app/Secreen/services/local_notification_service.dart.dart';
//import 'package:guide_app/Secreen/socket_service.dart';
//import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:guide_app/modele/activity_model.dart';

import 'package:guide_app/modele/PlanningHandler.dart';
import 'package:guide_app/modele/item.dart';
import 'package:guide_app/modele/plannings.dart';
//import '../Screens/SettingsPage.dart';
import '../modele/http_Activity_handler.dart';
import '../modele/image_model.dart';

//import 'AddClientScreen.dart';
//import 'Notivificationactivity.dart';
//import 'StreamSocket.dart';

//import 'activityEditScreen.dart';
//import 'activitydetalSecreen.dart';
//import 'avtivityDetailSecreen.dart';
//import 'notificationscren.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_animated_icons/icons8.dart';

class MyHomePagetest extends StatefulWidget {
  final GoogleSignInAccount? user;
  const MyHomePagetest({
    Key? key,
    this.user,
  }) : super(key: key);

  @override
  _MyHomePagetestState createState() => _MyHomePagetestState();
}

List onlineuser = [];
final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

TextEditingController? _message;

bool _iserror = false;
var sub;
String? text;
String? title;
/*IO.Socket socket = IO.io('ws://192.168.1.12:3000', <String, dynamic>{
  'transports': ['websocket'],
  // 'autoConnect': true,
});*/

class _MyHomePagetestState extends State<MyHomePagetest>
    with TickerProviderStateMixin {
  String selectedOption = 'Option 1';
  final List<String> _options = ['Option 1', 'Option 2', 'Option 3', 'Status'];
  List<String> selectedItemValue = <String>[
    'Option 1',
    'Option 2',
    'Option 3',
    'Status'
  ];

  late AnimationController _animationController;
  late AnimationController _animationControllerL;
  int ind = 0;
  late AnimationController _menuController;
  HTTPHandler httpHandler = HTTPHandler(); //the same
  HTTPHandlerp httpHandlerp = HTTPHandlerp(); //the same
  HTTPHandlerItem httpHandler1 = HTTPHandlerItem(); //the same
  final https = Get.put(HTTPHandler());
  final httpsp = Get.put(HTTPHandlerp());
  final http1 = Get.put(HTTPHandlerItem());
  late Future<List<Activity>> activityList;
  late Future<List<Plannigs>> planingList;
  late Future<List<Item>> item;

  late final List<String> notifications = [];
  late final List<String> notificationsid = [];
  final List<notif> not = [];
  final List<Color> _colors = [
    const Color.fromARGB(130, 253, 148, 141),
    const Color.fromARGB(255, 158, 207, 248),
    const Color.fromARGB(255, 231, 168, 75),
    const Color.fromARGB(151, 239, 153, 254),
    const Color.fromARGB(165, 171, 252, 174),
  ];

  late Color _backgroundColors;
  final storage = const FlutterSecureStorage();
  late TabController _tabController;
  late DateTime _selectedDay;
  late DateTime _selectedDay2;
  late final int _selectedDaylast = 0;
  late List<DateTime>? days = [
    DateTime.now(),
    DateTime.now().add(const Duration(days: 1)),
    DateTime.now().add(const Duration(days: 2)),
    DateTime.now().add(const Duration(days: 3)),
    DateTime.now().add(const Duration(days: 4)),
    DateTime.now().add(const Duration(days: 5)),
    DateTime.now().add(const Duration(days: 6)),
  ];

  String data = '';
  String userId = '';
  //late final LocalNotificationService service;
  bool _showButton = false;
  String select = '';
  String _convertToDisplayTime(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    if (duration.inHours == 0) {
      return "$twoDigitMinutes:$twoDigitSeconds";
    }
    return "${twoDigits(duration.inHours)}:$twoDigitMinutes:$twoDigitSeconds";
  }

  @override
  void initState() {
    super.initState();

    _menuController =
        AnimationController(vsync: this, duration: const Duration(seconds: 1));
    _animationControllerL =
        AnimationController(vsync: this, duration: const Duration(seconds: 1));
    _animationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 1));
    super.initState();
    _tabController = TabController(length: 7, vsync: this);
    _selectedDay = days![0];
    _selectedDay2 = days![6];
    // authController = Get.put(AuthController());
    _tabController.addListener(() {
      setState(() {
        _selectedDay = days![_tabController.index];

        _selectedDay2 = days![6];
        // _selectedDaylast = 7 - 1 - _tabController.index;

        print(_selectedDaylast);
      });
    });

    activityList = https.fetchData("");
    planingList = httpsp.fetchData("");
    print(planingList);
    item = http1.fetchData("");
    //service = LocalNotificationService();
    //listenToNotification();
    //PushNotificationService().initialize();
    /*socket.connect();
    if (!socket.connected) {
      socket.connect();
      print('connecting...000.');
    }
    socket.onConnect((_) {
      print('connected and listening to socket!.');
    });

    socket.on('notification', (data) {
      setState(() {
        String detail = data['detail'];
        String id = data['id'];

        this.notifications.add(detail);
        this.notificationsid.add(id);

        this.data = data.toString();
        print('Received data......homepage: $data ' + '$detail');
      });
      if (data['user'] != null) {
        setState(() {});
      }
    });*/

    FlutterLocalNotificationsPlugin notifications =
        FlutterLocalNotificationsPlugin();
    var androidInit = const AndroidInitializationSettings('@mipmap/ic_launcher');
    var iOSInit = const IOSInitializationSettings();

    _message = TextEditingController();
    var init = InitializationSettings(android: androidInit, iOS: iOSInit);
  }

  List<DropdownMenuItem<String>> _dropDownItem() {
    List<String> options1 = ['Option 1', 'Option 2', 'Option 3', 'Status'];
    return options1
        .map((value) => DropdownMenuItem(
              value: value,
              child: Text(value.toString()),
            ))
        .toList();
  }

  /* void selecteditem(BuildContext ctx, item) {
    Navigator.of(ctx).push(MaterialPageRoute(builder: (_) {
      return AddHotel(item);
    }));
  }*/

  @override
  Widget build(BuildContext context) {
    //final themeProvider = Provider.of<ThemeProvider>(context);
    // final themeProvider = Get.put(ThemeProvider());

    DateTime now = DateTime.now();
    List<DateTime> days = [];
    for (int i = 0; i < 7; i++) {
      days.add(now.add(Duration(days: i)));
    }
    return WillPopScope(
      onWillPop: () async {
        // Perform some action here
        return false; // Prevent the user from going back
      },
      child: Scaffold(
        bottomSheet: _showButton
            ? Container(
                height: 80,
                margin: const EdgeInsets.only(
                  top: 12,
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: FutureBuilder(
                        future: item,
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: snapshot.data!.length,
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                  onTap: () {
                                    /* print(snapshot.data![index].id);
                                    Navigator.of(context)
                                        .push(MaterialPageRoute(builder: (_) {
                                      return AddHotel(snapshot.data![index]);
                                    }));*/
                                  },
                                  child: buttonshetCard(
                                      snapshot.data![index].id,
                                      snapshot.data![index].title),
                                  // int red = Random().nextInt(256);
                                  // int green = Random().nextInt(256);
                                  // int blue = Random().nextInt(256);
                                  // List<String> _selectedOptions =
                                  //     List.filled(snapshot.data!.length, 'Status');
                                  // _backgroundColors =
                                  //     _colors[Random().nextInt(_colors.length)];
                                  // Set the new background color
                                  // Color backgroundColor =
                                  //     Color.fromARGB(255, red, green, blue);

                                  // if (index == 0 &&
                                  //     snapshot.data![index].albumId == 0) {
                                  //   return Column(
                                  //     children: [
                                  //       const SizedBox(
                                  //         height: 20,
                                  //       ),
                                  //       buildCard(snapshot.data![index], index,
                                  //           backgroundColor, _selectedOptions),
                                  //     ],
                                  //   );
                                  // } else {
                                  //   return buildCard(snapshot.data![index], index,
                                  //       backgroundColor, _selectedOptions);
                                  // }
                                );
                              },
                            );
                          } else if (snapshot.hasError) {
                            return const Center(
                              child: Text('Something went wrong'),
                            );
                          } else {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                        },
                      ),

//  ListView.builder(
                      //   scrollDirection: Axis.horizontal,
                      //   itemCount: 10,
                      //   itemBuilder: (BuildContext context, int index) {
                      //     return buttonshetCard(index);
                      //   },
                      // ),
                    ),

// DUMMY_CATEGORIES.map((item)=>buttonshetCard()).toList(),
                    // ImageIcon(image)
                    // Image.network(
                    //   'https://picsum.photos/200/300?random=$index',
                    //   height: 120,
                    //   width: 120,
                    // ),
                    //   ElevatedButton(
                    //     onPressed: () {
                    //       // Do something when the button is pressed
                    //       Get.to(AddHotel());

                    //       // logout();
                    //     },
                    //     style: ElevatedButton.styleFrom(
                    //       primary: Color.fromARGB(0, 12, 12, 12),
                    //       onPrimary: Colors.black,
                    //     ),
                    //     child: Icon(Icons.mode_edit),
                    //   ),

                    //   // Icon(Icons.add),
                  ],
                ),
              )
            // )
            : null,
        //       drawer:
        // Drawer(
        //         child: ListView(
        //           children: <Widget>[
        //             DrawerHeader(
        //               child: Column(
        //                 children: <Widget>[

        //                   SizedBox(
        //                     height: 10,
        //                   ),
        //                   Text(""),
        //                 ],
        //               ),
        //             ),
        //             ListTile(
        //               title: Text("All Post"),
        //               trailing: Icon(Icons.launch),
        //               onTap: () {
        //                 Navigator.push(
        //                   context,
        //                   MaterialPageRoute(builder: (context) => notificationScreen()),
        //                 );

        //               },
        //             ),
        //             ListTile(
        //               title: Text("New Story"),
        //               trailing: Icon(Icons.add),
        //               onTap: () {
        //                 // Navigator.push(context,
        //                 //     CupertinoPageRoute(builder: (redContext) => HomePage()));
        //               },
        //             ),
        //             ListTile(
        //               title: Text("Settings"),
        //               trailing: Icon(Icons.settings),
        //               onTap: () {
        //                 Navigator.push(
        //                   context,
        //                   MaterialPageRoute(builder: (context) => SettingsPage()),
        //                 );
        //               },
        //             ),
        //             ListTile(
        //               title: Text("Feedback"),
        //               trailing: Icon(Icons.feedback),
        //               onTap: () {},
        //             ),
        //             ListTile(
        //               title: Text("Logout"),
        //               trailing: Icon(Icons.power_settings_new),
        //               onTap: logout,
        //              //  logout,buttonshetCard
        //             ),
        //             DrawerHeader(
        //               child: Column(
        //                 children: <Widget>[
        //                   // profilePhoto,
        //                 ],
        //               ),
        //             ),
        //           ],
        //         ),
        //       ),
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(70),
          child: AppBar(
            automaticallyImplyLeading: false,
            flexibleSpace: Container(
              decoration: const BoxDecoration(
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
                    icon: const Icon(Icons.notification_add_rounded),
                    onPressed: () {
                      // Navigator.push(
                      //     context,
                      //     MaterialPageRoute(
                      //       builder: (context) =>null,
                      //     ));
                      /*Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => NotificationActivityScreen()),
                      );*/
                    },
                    color: const Color.fromARGB(255, 243, 242, 245),
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
                    onTap: () {
                      //Get.to(GenerateQRPage());
                    },
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
                    color: const Color.fromARGB(255, 175, 10, 10),
                    onPressed: () {
                      _animationControllerL.reset();
                      _animationControllerL.forward();
                      setState(() {
                        _showButton = !_showButton;
                      });
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
            backgroundColor: const Color.fromARGB(255, 242, 242, 244),
            title: InkWell(
              onTap: () {
                // Get.to(GenerateQRPage());
              },
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
            bottom: const PreferredSize(
              preferredSize: Size.fromHeight(kToolbarHeight),
              child: Column(),
            ),
          ),
        ),
        body: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              // crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                const Text(
                  "Planning",
                  style: TextStyle(fontSize: 30),
                ),
                const SizedBox(width: 40),
                ElevatedButton(
                  onPressed: () {
                    // Do something when the button is pressed
                    // Get.to(ActivityEditScreen());
                    // Get.to(AddClientScreen());

                    // logout();
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.black, backgroundColor: Colors.white,
                  ),
                  child: const Row(
                    children: [
                      Icon(Icons.mode_edit),
                      SizedBox(width: 8),
                      Text(
                        'Modifie',
                        style: TextStyle(color: Colors.black),
                      ),
                    ],
                  ),
                )
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
                  DateFormat('  MMMM  d ,y ').format(_selectedDay),
                  style: const TextStyle(fontSize: 20),
                ),
                Text(
                  DateFormat(' ~ MMMM  d ,y ').format(_selectedDay2),
                  style: const TextStyle(fontSize: 20),
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

            //  SizedBox(
            //           height: 45,

            //           child: Image.asset('assets/L.jpg'),
            //         ),
            TabBar(
              controller: _tabController,
              isScrollable: true,
              labelColor: Colors.black38,
              tabs: days
                  .map((day) => Tab(text: DateFormat('EEE, MMM d').format(day)))
                  .toList(),
            ),

            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: <Widget>[
                  FutureBuilder(
                    future: planingList,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return ListView.separated(
                          itemCount: snapshot.data!.length,
                          separatorBuilder: (context, index) {
                            return const Divider();
                          },
                          itemBuilder: (context, index) {
                            // int red = Random().nextInt(256);
                            // int green = Random().nextInt(256);
                            // int blue = Random().nextInt(256);
                            // List<String> _selectedOptions =
                            //     List.filled(snapshot.data!.length, 'Status');
                            _backgroundColors =
                                _colors[Random().nextInt(_colors.length)];
                            // Set the new background color
                            // Color backgroundColor =
                            //     Color.fromARGB(255, red, green, blue);
                            switch (snapshot.data![index].id) {
                              case "3aa7fdfe-1902-4f93-8669-d1b384903b39":
                                return Column(
                                  children: [
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    buildCard(
                                      snapshot.data![index],
                                      index,
                                      _backgroundColors,
                                    ),
                                  ],
                                );

                              // case 1:
                              //   return Column(
                              //     children: [
                              //       const SizedBox(
                              //         height: 20,
                              //       ),
                              //       buildCardH(snapshot.data![index], index,
                              //           _backgroundColors),
                              //     ],
                              //   );

                              default:
                                return Column(
                                  children: [
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    buildCard(
                                      snapshot.data![index],
                                      index,
                                      _backgroundColors,
                                    ),
                                  ],
                                );
                            }

                            // if (index == 0 &&
                            //     snapshot.data![index].albumId == 0) {
                            //   return Column(
                            //     children: [
                            //       const SizedBox(
                            //         height: 20,
                            //       ),
                            //       buildCard(snapshot.data![index], index,
                            //           backgroundColor, _selectedOptions),
                            //     ],
                            //   );
                            // } else {
                            //   return buildCard(snapshot.data![index], index,
                            //       backgroundColor, _selectedOptions);
                            // }
                          },
                        );
                      } else if (snapshot.hasError) {
                        return const Center(
                          child: Text('Something went wrong'),
                        );
                      } else {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                    },
                  ),
                  const Center(
                      //   child: FutureBuilder(
                      // future: activityList,
                      // builder: (context, snapshot) {
                      //   if (snapshot.hasData) {
                      //     return ListView.separated(
                      //       // scrollDirection: Axis.horizontal,
                      //       //  reverse: true,
                      //       separatorBuilder: (context, index) {
                      //         return Divider();
                      //       },
                      //       itemCount: snapshot.data!.length,

                      //       itemBuilder: (context, index) {
                      //         int red = Random().nextInt(210 - 140) + 70;
                      //         int green = Random().nextInt(255 - 230) + 205;
                      //         int blue = Random().nextInt(210 - 200) + 208;

                      //         // Set the new background color
                      //         Color backgroundColor =
                      //             Color.fromARGB(255, red, blue, green);
                      //         Color.fromARGB(255, 227, 111, 22);
                      //         List<String> _selectedOptions =
                      //             List.filled(snapshot.data!.length, 'Status');
                      //         int itemCount = snapshot.data!.length ?? 0;
                      //         int reversedIndex = itemCount - 1 - index;

                      //         if (index == 0) {
                      //           return Column(
                      //             children: [
                      //               const SizedBox(
                      //                 height: 20,
                      //               ),
                      //               buildCard(
                      //                 snapshot.data![reversedIndex],
                      //                 index,
                      //                 _backgroundColors,
                      //               ),
                      //             ],
                      //           );
                      //         } else {
                      //           return buildCard(
                      //             snapshot.data![reversedIndex],
                      //             index,
                      //             _backgroundColors,
                      //           );
                      //         }
                      //       },
                      //     );
                      //   } else if (snapshot.hasError) {
                      //     return const Center(
                      //       child: Text('Something went wrong'),
                      //     );
                      //   } else {
                      //     return const Center(
                      //       child: CircularProgressIndicator(),
                      //     );
                      //   }
                      // },
                      ),
// // ),
                  const Center(),
                  const Center(),
                  const Center(),
                  const Center(),

                  const Center(),
//                   listview(),
//                   listview(),
//                   listview(),
//                   // Center(child: notificationScreen()),
//                   listview(),
//                   listview(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
  // Color _backgroundColor = Colors.white;

  // void _changeBackgroundColor() {
  //   setState(() {
  //     // Generate random RGB values
  //     int red = Random().nextInt(256);
  //     int green = Random().nextInt(256);
  //     int blue = Random().nextInt(256);

  //     // Set the new background color
  //     _backgroundColor = Color.fromARGB(255, red, green, blue);
  //   });
  // }
  void getdata() {}
  @override
  void dispose() {
    _tabController.dispose();
    _animationController.dispose();
    _menuController.dispose();
    // _iserror = false;F
    // _message!.dispose();
    // channel!.sink.close(status.goingAway);
    // sub.cancel();
    super.dispose();
  }
  // @override
  // void dispose() {
  //   _tabController.dispose();
  //   super.dispose();
  // }

  /* void listenToNotification() =>
      service.onNotificationClick.stream.listen(onNoticationListener);*/

  void onNoticationListener(String? payload) {
    if (payload != null && payload.isNotEmpty) {
      print('payload $payload');

      // Navigator.push(
      //     context,
      //     MaterialPageRoute(
      //         builder: ((context) => LoginView(payload: payload))));
    }
  }

  Widget showNotificationdetail() {
    return ListView.builder(
      itemCount: notifications.length,
      itemBuilder: (BuildContext context, int index) {
        return ListTile(
          // itemCount: not.length,
          // itemBuilder: (context, int index) {
          //   return Imagebuild(not[index]);
          // },
          leading: const Icon(Icons.notification_important),
          isThreeLine: false,
          dense: true,
          contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          selected: false,
          enabled: true,
          trailing: const Icon(Icons.arrow_forward),
          title: Text(not[index].detail as String),
          subtitle: Text(not[index].detail as String),
          onTap: () {
            print(index);
          },
        );
      },
    );
  }

  /*void logout() async {
    await storage.delete(key: "access_token");
    await FacebookAuth.instance.logOut();
    // _accessToken = null;
    // _userData = null;
    Navigator.pushAndRemoveUntil(context,
        MaterialPageRoute(builder: (context) => LoginView()), (route) => false);
  }*/

  _showBottomSheet() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SizedBox(
          height: 200,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: 10,
            itemBuilder: (BuildContext context, int index) {
              return Card(
                child: Column(
                  children: [
                    Image.network(
                      'https://picsum.photos/200/300?random=$index',
                      height: 120,
                      width: 120,
                    ),
                    Text('Item $index'),
                  ],
                ),
              );
            },
          ),
        );
      },
    );
  }

  buildCardH(Activity activity, index, backgroundColors) {
    return Card(
      elevation: 7,
      margin: const EdgeInsets.only(left: 16, right: 16),
      child: Container(
        color: backgroundColors,
        child: Container(
          height: Get.height * 0.3,
          margin: const EdgeInsets.only(left: 2),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "${DateFormat(' kk:mm ').format(DateTime.now())}  ${DateFormat('- kk:mm ').format(DateTime.now())}",
                    style: const TextStyle(fontSize: 14),
                  ),
                  Row(
                    children: [
                      IconButton(
                        // splashRadius: 20,
                        // iconSize: 20,
                        color: const Color.fromARGB(255, 175, 10, 10),
                        onPressed: () {
                          _animationController.reset();
                          _animationController.forward();
                        },
                        icon: Padding(
                          padding: const EdgeInsets.only(top: 2.0, bottom: 3.0),
                          child: Lottie.asset(
                            Icons8.bell_office_style,
                            controller: _animationController,
                          ),
                        ),
                      ),
                      IconButton(
                        // splashRadius: 20,
                        // iconSize: 12,
                        color: const Color.fromARGB(255, 175, 10, 10),
                        onPressed: () {
                          // _animationController.reset();
                          // _animationController.forward();
                          // Get.to(() => AvtivityDetailSecreen(
                          //       activity,
                          //     ));
                        },
                        icon: Padding(
                            padding: const EdgeInsets.only(
                                top: 3.0, bottom: 3.0, right: 3.0),
                            child: Image.asset('assets/M1.png')
//  Lottie.asset(
//                             Icons8.list,
//                             controller: _animationController,
//                           ),
                            ),
                      ),
                    ],
                  )
                ],
              ),
              Container(
                color: backgroundColors,
                height: Get.height * 0.1,
                // padding: const EdgeInsets.all(2),
                alignment: Alignment.center,
                child: ListTile(
                  onTap: () {
                    // print(index);
                    // Get.to(activitydetalSecreen(activity));
                  },
                  title: const Text(
// activity.title
                      "Restaurent ",
                      style: TextStyle(
                          fontSize: 24,
                          height: 0,
                          fontStyle: FontStyle.italic)),
                  leading: Container(
                    clipBehavior: Clip.antiAlias,
                    height: 80,
                    // alignment: Alignment.l,
                    decoration: const BoxDecoration(shape: BoxShape.circle),
                    child: Image.network(
                      activity.url,
                      errorBuilder: (BuildContext context, Object exception,
                          StackTrace? stackTrace) {
                        return const Icon(Icons.image);
                      },
                    ),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(width: Get.width * 0.05),
                  Container(
                    clipBehavior: Clip.antiAlias,
                    height: 50,
                    // alignment: Alignment.l,
                    decoration: const BoxDecoration(shape: BoxShape.circle),
                    child: Image.network(
                      activity.url,
                      errorBuilder: (BuildContext context, Object exception,
                          StackTrace? stackTrace) {
                        return const Icon(Icons.image);
                      },
                    ),
                  ),
                  SizedBox(width: Get.width * 0.01),
                  const Column(
                    children: [
                      Text(
                        "Restoron Name",
                        style: TextStyle(fontSize: 14),
                      ),
                    ],
                  ),
                  SizedBox(width: Get.width * 0.25),
                  // IconButton(
                  //   // splashRadius: 20,
                  //   // iconSize: 12,
                  //   color: Color.fromARGB(255, 175, 10, 10),
                  //   onPressed: () {
                  //     // _animationController.reset();
                  //     // _animationController.forward();
                  //   },
                  //   icon: Icon(Icons.mode_edit),
                  // ),
                  // Text(
                  //   'Modifie',
                  //   style: TextStyle(color: Colors.black),
                  // ),
//  ElevatedButton(
//                   onPressed: () {
//                     // Do something when the button is pressed
//                     Get.to(ActivityEditScreen(  activity));

//                     // logout();
//                   },
//                   style: ElevatedButton.styleFrom(
//                     primary: Colors.white,
//                     onPrimary: Colors.black,
//                   ),
//                   child: Row(
//                     children: [
//                       Icon(Icons.auto_mode_sharp),
//                       SizedBox(width: 8),
//                       Text(
//                         'status',
//                         style: TextStyle(color: Colors.black),
//                       ),
//                     ],
//                   ),
//                 ),

                  DropdownButton(
                    items: _dropDownItem(),
                    onChanged: (value) {
                      setState(() {
                        print('$index and $value');
                      });
                    },
                    value: selectedItemValue[3],
                    hint: const Text('0'),
                  ),
                  // DropdownButton<String>(
                  //   items: _options.map((String option) {
                  //     return DropdownMenuItem<String>(
                  //       value: option,
                  //       child: Text(option),
                  //     );
                  //   }).toList(),
                  //   value: selectedOption,
                  //   onChanged: (String? newValue) {
                  //     selectedOption = newValue!;
                  //     setState(() {
                  //       print(selectedOption);

                  //       print(newValue);
                  //     });
                  //   },
                  // ),

                  const SizedBox(width: 2),
                ],
              ),
              const Divider(
                color: Colors.black,
                indent: 14,
                endIndent: 14,
                thickness: 1.8,
              ),
              const Column(
                children: [
                  Row(
                    children: [
                      SizedBox(width: 20),
                      //     Text(
                      //       "france tunisia",
                      //       style: const TextStyle(
                      //         fontSize: 12,
                      //         fontWeight: FontWeight.w200,
                      //       ),
                      //     ),
                      //     SizedBox(width: 40),
                      //     Text(
                      //       "france tunisia",
                      //       style: const TextStyle(
                      //         fontSize: 12,
                      //         fontWeight: FontWeight.w200,
                      //       ),
                      //     ),
                      //   ],
                      // ),
                      // Row(
                      //   children: [
                      //     SizedBox(width: 20),
                      //     Text(
                      //       "${DateFormat('EEE, MMM d').format(DateTime.now())}",
                      //     ),
                      //     SizedBox(width: 40),
                      //     Text(
                      //       "${DateFormat('EEE, MMM d').format(DateTime.now())}",
                      //     ),
                      //   ],
                      // ),
                      // Row(
                      //   children: [
                      //     const SizedBox(width: 20),
                      //     Text(
                      //       "ASl France",
                      //       style: const TextStyle(
                      //           fontSize: 14, fontWeight: FontWeight.bold),
                      //     ),
                      //     SizedBox(width: 20),
                      //     Icon(Icons.account_box),

                      Icon(Icons.flag),
                      Text(
                        "Restorent location",
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(width: 20),
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

          const Icon(Icons.image),

          Text('Item$index'),
          Text(item),

          const Icon(Icons.list_alt_sharp),
        ],
      ),
    );
  }

  buildCard(
    // Activity activity,
    Plannigs planing,
    index,
    backgroundColors,
  ) {
    List<String> selectedOptions1 = List.filled(1000, 'Status');

    return Card(
      elevation: 7,
      margin: const EdgeInsets.only(left: 16, right: 16),
      child: Container(
        color: backgroundColors,
        child: Container(
          height: Get.height * 0.3,
          margin: const EdgeInsets.only(left: 2),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "${DateFormat(' kk:mm ').format(DateTime.now())}  ${DateFormat('- kk:mm ').format(DateTime.now())}",
                    style: const TextStyle(fontSize: 14),
                  ),
                  Row(
                    children: [
                      IconButton(
                        // splashRadius: 20,
                        // iconSize: 20,
                        color: const Color.fromARGB(255, 175, 10, 10),
                        onPressed: () {
                          _animationController.reset();
                          _animationController.forward();
                        },
                        icon: Padding(
                          padding: const EdgeInsets.only(top: 2.0, bottom: 3.0),
                          child: Lottie.asset(
                            Icons8.bell_office_style,
                            controller: _animationController,
                          ),
                        ),
                      ),
                      IconButton(
                        // splashRadius: 20,
                        // iconSize: 12,
                        color: const Color.fromARGB(255, 175, 10, 10),
                        onPressed: () {
                          // _animationController.reset();
                          // _animationController.forward();
                        },
                        icon: Padding(
                            padding: const EdgeInsets.only(
                                top: 3.0, bottom: 3.0, right: 3.0),
                            child: Image.asset('assets/M1.png')
//  Lottie.asset(
//                             Icons8.list,
//                             controller: _animationController,
//                           ),
                            ),
                      ),
                    ],
                  )
                ],
              ),
              Container(
                color: backgroundColors,
                height: Get.height * 0.1,
                // padding: const EdgeInsets.all(2),
                alignment: Alignment.center,
                child: ListTile(
                  onTap: () {
                    print(index);
                  },
                  title: const Text(
// activity.title
                      "Activity",
                      style: TextStyle(
                          fontSize: 24,
                          height: 0,
                          fontStyle: FontStyle.italic)),
                  leading: Container(
                    clipBehavior: Clip.antiAlias,
                    height: 80,
                    // alignment: Alignment.l,
                    decoration: const BoxDecoration(shape: BoxShape.circle),
                    child: Image.network(
                      planing.agencyId,
                      errorBuilder: (BuildContext context, Object exception,
                          StackTrace? stackTrace) {
                        return const Icon(Icons.image);
                      },
                    ),
                  ),
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
                  const SizedBox(width: 180),
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
                  DropdownButton(
                    items: _dropDownItem(),
                    onChanged: (value) {
                      setState(() {
                        print('$index and $value');
                      });
                    },
                    value: selectedItemValue[3],
                    hint: const Text('0'),
                  ),
//this what i will use with api
                  const SizedBox(width: 2),
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
                  const Row(
                    children: [
                      SizedBox(width: 20),
                      Text(
                        "france tunisia",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w200,
                        ),
                      ),
                      SizedBox(width: 40),
                      Text(
                        "france tunisia",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w200,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      const SizedBox(width: 20),
                      Text(
                        DateFormat('EEE, MMM d').format(DateTime.now()),
                      ),
                      const SizedBox(width: 40),
                      Text(
                        DateFormat('EEE, MMM d').format(DateTime.now()),
                      ),
                    ],
                  ),
                  const Row(
                    children: [
                      SizedBox(width: 20),
                      Text(
                        "ASl France",
                        style: TextStyle(
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

  // listview() {
  //   return Center(
  //       child: FutureBuilder(
  //     future: activityList,
  //     builder: (context, snapshot) {
  //       if (snapshot.hasData) {
  //         return ListView.separated(
  //           // scrollDirection: Axis.horizontal,
  //           //  reverse: true,
  //           separatorBuilder: (context, index) {
  //             return Divider();
  //           },
  //           itemCount: snapshot.data!.length,

  //           itemBuilder: (context, index) {
  //             int red = Random().nextInt(210 - 140) + 70;
  //             int green = Random().nextInt(255 - 230) + 205;
  //             int blue = Random().nextInt(210 - 200) + 208;

  //             // Set the new background color
  //             Color backgroundColor = Color.fromARGB(255, red, blue, green);
  //             Color.fromARGB(255, 227, 111, 22);
  //             List<String> _selectedOptions =
  //                 List.filled(snapshot.data!.length, 'Status');
  //             int itemCount = snapshot.data!.length ?? 0;
  //             int reversedIndex = itemCount - 1 - index;
  //             if (index == 0) {
  //               return Column(
  //                 children: [
  //                   const SizedBox(
  //                     height: 20,
  //                   ),
  //                   buildCard(
  //                     snapshot.data![reversedIndex],
  //                     index,
  //                     _backgroundColors,
  //                   ),
  //                 ],
  //               );
  //             } else {
  //               return buildCardH(
  //                 snapshot.data![reversedIndex],
  //                 index,
  //                 _backgroundColors,
  //               );
  //             }
  //           },
  //         );
  //       } else if (snapshot.hasError) {
  //         return const Center(
  //           child: Text('Something went wrong'),
  //         );
  //       } else {
  //         return const Center(
  //           child: CircularProgressIndicator(),
  //         );
  //       }
  //     },
  //   ));
  // }
}
  

// Widget Imagebuild(notif notification) {
//   return Container(
//     padding: EdgeInsets.all(20.0),
//     decoration: BoxDecoration(
//         border: Border.all(color: Color.fromARGB(222, 223, 101, 7))),
//     margin: EdgeInsets.all(20.0),
//     child: Column(
//       children: <Widget>[
//         Padding(
//           child: Text(notification.user as String),
//           padding: EdgeInsets.only(bottom: 8.0, top: 20.0),
//         ),
//         Text(notification.id as String)
//       ],
//     ),
//   );
// }

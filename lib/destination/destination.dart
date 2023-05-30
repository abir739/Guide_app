import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../notification/notification.dart';
import '../planning/guide_plan.dart';
import '../users/client_list.dart';
import '../notification/create_notification.dart';

import 'package:guide_app/planning/planing_list.dart';
import '../planning/guide_plan_test.dart';
import '../planning/home_tasks.dart';

//import 'package:guide_app/planning/guide_plan_test.dart';
import 'package:guide_app/planning/guide_plan.dart';


class DestinationScreen extends StatefulWidget {
  const DestinationScreen({super.key});

  @override
  _DestinationScreenState createState() => _DestinationScreenState();
}

class _DestinationScreenState extends State<DestinationScreen> {
  final List<String> _categories = [
    "Museums",
    "Mountains",
    "Forests",
    "Beaches",
    "Amusement Parks",
  ];

  final List<Map<String, dynamic>> _places = [
    {
      "name": "Museum of Modern Art",
      "image":
          "https://historiadeldisseny.org/web/wp-content/uploads/FHD_Recursos_museu_MoMa.jpg",
      "price": "\$20",
    },
    {
      "name": "Mount Everest",
      "image": "https://via.placeholder.com/150",
      "price": "\$100",
    },
    {
      "name": "Amazon Rainforest",
      "image": "https://via.placeholder.com/150",
      "price": "\$50",
    },
    {
      "name": "Miami Beach",
      "image": "https://via.placeholder.com/150",
      "price": "\$30",
    },
    {
      "name": "Universal Studios",
      "image": "https://via.placeholder.com/150",
      "price": "\$60",
    },
  ];

  List<Map<String, dynamic>> _filteredPlaces = [];

  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    _filteredPlaces = List.from(_places);
    super.initState();
  }

  void _filterPlaces(String query) {
    if (query.isNotEmpty) {
      setState(() {
        _filteredPlaces = _places
            .where((place) =>
                place["name"].toLowerCase().contains(query.toLowerCase()))
            .toList();
      });
    } else {
      setState(() {
        _filteredPlaces = List.from(_places);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: SvgPicture.asset(
          'assets/images/Logo.svg',
          fit: BoxFit.cover,
          height: 36.0,
        ),
        backgroundColor: const Color.fromARGB(255, 207, 207, 219),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.notifications),
            onPressed: () {
              // Navigate to notifications screen when button is pressed
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const NotificationsScreen()),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () {
              // Show menu options when button is pressed
              _showMenu(context);
            },
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Padding(
            padding: EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Bonjour John',
                  style: TextStyle(
                    fontSize: 27.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                CircleAvatar(
                  radius: 40.0,
                  backgroundImage: NetworkImage(
                      'https://randomuser.me/api/portraits/men/1.jpg'),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10.0),
          Container(
            child: TextField(
              controller: _searchController,
              decoration: const InputDecoration(
                hintText: "Search for a destination",
                prefixIcon: Icon(Icons.search),
              ),
              onChanged: _filterPlaces,
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _categories.length,
              itemBuilder: (context, index) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 16, top: 16),
                      child: Text(
                        _categories[index],
                        style: const TextStyle(fontSize: 18),
                      ),
                    ),
                    const SizedBox(height: 8),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: _filteredPlaces
                            .map((place) => GestureDetector(
                                  onTap: () {},
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 16),
                                    child: SizedBox(
                                      width: 150,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.stretch,
                                        children: [
                                          ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            child: Image.network(
                                              place["image"],
                                              height: 100,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                          const SizedBox(height: 8),
                                          Text(
                                            place["name"],
                                            style: const TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                          const SizedBox(height: 4),
                                          Text(
                                            place["price"],
                                            style: TextStyle(
                                                color: Colors.grey[600]),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ))
                            .toList(),
                      ),
                    ),
                    const SizedBox(height: 16),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

//
void _showMenu(BuildContext context) {
  final Color primary = Colors.white;
  final Color active = Colors.black;

  double screenHeight = MediaQuery.of(context).size.height;

  showModalBottomSheet(
    context: context,
    backgroundColor: Colors.transparent,
    isScrollControlled: true,
    builder: (BuildContext context) {
      return SizedBox(
        width: MediaQuery.of(context).size.width * 0.8, // Set the desired width
        child: Container(
          height: MediaQuery.of(context).size.height - 77,
          child: ClipPath(
            clipper: OvalRightBorderClipper(),
            child: Drawer(
              child: Container(
                padding: const EdgeInsets.only(left: 26.0, right: 140),
                decoration: BoxDecoration(
                  color: primary,
                  boxShadow: [BoxShadow(color: Colors.black45)],
                ),
                width: 300,
                child: SafeArea(
                  /// ---------------------------
                  /// Building scrolling  content for drawer .
                  /// ---------------------------

                  child: SingleChildScrollView(
                    child: Column(
                      children: <Widget>[
                        // Container(
                        //   alignment: Alignment.centerRight,
                        //   child: IconButton(
                        //     icon: Icon(
                        //       Icons.power_settings_new,
                        //       color: active,
                        //     ),
                        //     onPressed: () {},
                        //   ),
                        // ),

                        /// ---------------------------
                        /// Building header for drawer .
                        /// ---------------------------
                        SizedBox(height: 28.0),
                        Container(
                          height: 90,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              gradient: LinearGradient(
                                  colors: [Colors.orange, Colors.deepOrange])),
                          child: CircleAvatar(
                            radius: 40,
                            backgroundImage: AssetImage(
                              'assets/images/abir.jpeg',
                            ),
                          ),
                        ),
                        SizedBox(height: 5.0),

                        /// ---------------------------
                        /// Building header title for drawer .
                        /// ---------------------------

                        Text(
                          "Abir Cherif",
                          style: TextStyle(
                              color: Colors.purple.withOpacity(0.6),
                              fontSize: 18.0,
                              fontWeight: FontWeight.w600),
                        ),
                        Text(
                          "@Abir.ch",
                          style: TextStyle(color: active, fontSize: 16.0),
                        ),

                        /// ---------------------------
                        /// Building items list  for drawer .
                        /// ---------------------------
                        SizedBox(height: 16.0),
                        ListTile(
                          leading: Icon(Icons.home, color: active),
                          title: Text('Home', style: TextStyle(color: active)),
                          onTap: () {
                            // Navigate to home screen
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => PlanningListPage()),
                            );
                          },
                        ),
                        _buildDivider(),
                        ListTile(
                          leading: Icon(Icons.playlist_add_circle_outlined,
                              color: active),
                          title: Text('Destination',
                              style: TextStyle(color: active)),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => DestinationScreen()),
                            );
                          },
                        ),
                        _buildDivider(),
                        ListTile(
                          leading: Icon(Icons.calendar_month, color: active),
                          title:
                              Text('Schedule', style: TextStyle(color: active)),
                          onTap: () {
                            // Navigator.push(
                            //   context,
                            //   MaterialPageRoute(
                            //       builder: (context) => ScheduleScreen()),
                            // );
                          },
                        ),
                        _buildDivider(),
                        ListTile(
                          leading: Icon(Icons.groups, color: active),
                          title:
                              Text('Clients', style: TextStyle(color: active)),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ClientScreen()),
                            );
                          },
                        ),
                        _buildDivider(),
                        ListTile(
                          leading: Icon(Icons.notification_add, color: active),
                          title: Text('Create Notification',
                              style: TextStyle(color: active)),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => AddNotification()),
                            );
                          },
                        ),
                        _buildDivider(),
                        ListTile(
                          leading: Icon(Icons.info, color: active),
                          title: Text('About', style: TextStyle(color: active)),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => HomePage()),
                            );
                          },
                        ),
                        _buildDivider(),
                        ListTile(
                          leading: const Icon(Icons.done_sharp),
                          title: const Text('My Tasks'),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const HomePage(),
                              ),
                            );
                          },
                        ),

                        /// ---------------------------
                        /// last Item for drawer
                        /// ---------------------------

                        _buildDivider(),
                        SizedBox(height: 28.0),
                        Column(
                          children: <Widget>[
                            ListTile(
                              title: Text(
                                'Log In',
                                style: TextStyle(
                                  fontFamily: 'Bahij Janna',
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16,
                                  color: Colors.purple.withOpacity(0.6),
                                ),
                                textAlign: TextAlign.left,
                              ),
                              trailing: Icon(Icons.login, color: Colors.red),
                              onTap: () {
                                Navigator.of(context).pop();
                              },
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).padding.bottom,
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      );
    },
  );
}

Divider _buildDivider() {
  final Color divider = Colors.deepOrange;
  return Divider(
    color: divider,
  );
}

class OvalRightBorderClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, 0);
    path.lineTo(size.width * (2 / 3) - 20, 0);
    path.quadraticBezierTo(size.width * (2.2 / 3), size.height / 4,
        size.width * (2.2 / 3), size.height / 2);
    path.quadraticBezierTo(
        size.width * (2.2 / 3),
        size.height - (size.height / 4),
        size.width * (2 / 3) - 20,
        size.height);
    path.lineTo(0, size.height);
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}

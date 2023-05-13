import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:convert';

import '../destination/destination_test.dart';
import '../models/users_model.dart';
import '../planning/planing_list.dart';
import '../planning/shedule.dart';
import '../users/client_profile.dart';
import '../notification/notification.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import 'new_user.dart';

//import '../users/add_user_screen.dart';

class ClientScreen extends StatefulWidget {
  const ClientScreen({super.key});

  @override
  _ClientScreenState createState() => _ClientScreenState();
}

class _ClientScreenState extends State<ClientScreen> {
  List<User> _users = []; // Define the _users list here

  @override
  void initState() {
    super.initState();
    _loadUsers();
  }

  Future<void> _loadUsers() async {
    final data = await DefaultAssetBundle.of(context)
        .loadString('assets/data/users.json');
    final jsonResult = json.decode(data);

    setState(() {
      _users = List<User>.from(jsonResult.map((u) => User.fromJson(u)));
    });
  }

  void _onUserAdded(User newUser) {
    setState(() {
      _users.add(newUser);
    });
  }

  void _navigateToProfile(User user) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ProfileScreen(user: user)),
    );
  }

  void _navigateToAddUserScreen() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddUserScreen(
          key: UniqueKey(), // Pass a unique Key object
          usersList: _users,
          onUserAdded: (newUser) {
            setState(() {
              _users.add(newUser);
            });
          },
        ),
      ),
    );
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
        children: [
          const SizedBox(height: 10.0),
          // const Text(
          //   'Liste de passagers',
          //   style: TextStyle(
          //     fontSize: 27.0,
          //     fontWeight: FontWeight.bold,
          //   ),
          // ),
          Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              const SizedBox(width: 5.0),
              const Text(
        'Liste de passagers',
        style: TextStyle(
          fontSize: 27.0,
          fontWeight: FontWeight.bold,
          color: Color(0xFF3A3557),
        ),
              ),
              const SizedBox(width: 14.5),
              Container(
                height: 40.0,
                width: 100,
                decoration: BoxDecoration(
                  color: const Color(0xFFEB5F52),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white, backgroundColor: const Color(0xFFEB5F52),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  onPressed: _navigateToAddUserScreen,
                  child: const Center(
                    child: Text(
                      'Add User',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 17.0),
          Expanded(
            child: ListView.builder(
              itemCount: _users.length,
              itemBuilder: (context, index) {
                final user = _users[index];

                return Container(
                  child: GestureDetector(
                    onTap: () => _navigateToProfile(user),
                    child: Slidable(
                      startActionPane: ActionPane(
                        motion: const DrawerMotion(),
                        extentRatio: 0.25,
                        children: [
                          SlidableAction(
                            label: 'Call',
                            backgroundColor:
                                const Color.fromARGB(255, 27, 97, 39),
                            icon: Icons.phone,
                            onPressed: (context) async {
                              // TODO: Call the user
                              Uri phoneno = Uri.parse('tel:${user.phone}');
                              if (await launchUrl(phoneno)) {
                                //dialer opened
                              } else {
                                //dailer is not opened
                              }
                            },
                          ),
                        ],
                      ),
                      endActionPane: ActionPane(
                        motion: const DrawerMotion(),
                        extentRatio: 0.25,
                        children: [
                          SlidableAction(
                            label: 'Delete',
                            backgroundColor: Colors.red,
                            icon: Icons.delete,
                            onPressed: (context) {
                              //delete action for this button
                              _users.removeWhere((element) {
                                return element.id == user.id;
                              }); //go through the loop and match content to delete from list
                              setState(() {
                                //refresh Interface after deleting element from list
                              });
                            },
                          ),
                        ],
                      ),
                      child: Card(
                        child: ListTile(
                          leading: CircleAvatar(
                            backgroundImage: NetworkImage(user.picture),
                          ),
                          title: Text('${user.firstName} ${user.lastName}'),
                          subtitle: Text('ID: ${user.id}'),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

void _showMenu(BuildContext context) {
  showModalBottomSheet(
    context: context,
    backgroundColor: Colors.transparent,
    builder: (BuildContext context) {
      return Container(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.0),
            topRight: Radius.circular(20.0),
          ),
          color: Color.fromARGB(255, 255, 255, 255),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text('Home'),
              onTap: () {
                // Navigate to home screen
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const PlanningListPage()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.playlist_add_circle_outlined),
              title: const Text('Destination'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const DestinationScreen()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.calendar_month),
              title: const Text('Schedule'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const ScheduleScreen()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.groups),
              title: const Text('Clients'),
              onTap: () {
                // Navigate to activites screen when pressed
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ClientScreen()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.feedback),
              title: const Text('Feedbacks'),
              onTap: () {
                // Navigate to settings screen
                Navigator.pop(context);
                Navigator.pushNamed(context, '/Feedbacks');
              },
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('Settings'),
              onTap: () {
                // Navigate to settings screen
                Navigator.pop(context);
                Navigator.pushNamed(context, '/settings');
              },
            ),
            ListTile(
              leading: const Icon(Icons.info),
              title: const Text('About'),
              onTap: () {
                // Navigate to about screen
                Navigator.pop(context);
                Navigator.pushNamed(context, '/about');
              },
            ),
          ],
        ),
      );
    },
  );
}

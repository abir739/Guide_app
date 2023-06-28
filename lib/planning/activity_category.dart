import 'dart:math';

import 'package:flutter/material.dart';
import 'package:awesome_dialog/awesome_dialog.dart';

import 'package:flutter_svg/flutter_svg.dart';
import 'package:guide_app/about_page.dart';
import 'package:guide_app/menu.dart';
// import 'package:guide_app/notification/ActivityNotification.dart';
import 'package:guide_app/notification/activity_notif.dart';
import 'package:guide_app/planning/guide_plan_test.dart';
import 'package:guide_app/planning/planing_list.dart';

import 'package:intl/intl.dart';
import 'package:guide_app/activity/newactivityyy.dart';
import 'package:guide_app/notification/notification.dart';

import '../destination/destination_test.dart';
import '../models/planing_model.dart';
import '../notification/create_notification.dart';
import '../users/client_list.dart';

class EditActivityScreen extends StatefulWidget {
  final Activity activity;

  const EditActivityScreen({Key? key, required this.activity})
      : super(key: key);

  @override
  _EditActivityScreenState createState() => _EditActivityScreenState();
}

class _EditActivityScreenState extends State<EditActivityScreen> {
  late TextEditingController _nameController;
  late TextEditingController _timeController;
  late TextEditingController _priceController;
  late TextEditingController _placeController;
  late TextEditingController _commentController;
  late TextEditingController _descriptionController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.activity.name);
    _timeController = TextEditingController(text: widget.activity.time);
    _priceController = TextEditingController(text: widget.activity.price);
    _placeController = TextEditingController(text: widget.activity.place);
    _commentController = TextEditingController(text: widget.activity.comment);
    _descriptionController =
        TextEditingController(text: widget.activity.description);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text("Edit Activity"),
      // ),
      appBar: AppBar(
        title: Row(
          children: [
            SvgPicture.asset(
              'assets/images/Logo.svg',
              fit: BoxFit.cover,
              height: 36.0,
            ),
            const SizedBox(
                width: 30.0), // Add spacing between the logo and the text
            const Text("Edit Activity"),
          ],
        ),
        backgroundColor: const Color.fromARGB(255, 207, 207, 219),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: "Name",
              ),
            ),
            const SizedBox(height: 16.0),
            TextFormField(
              controller: _timeController,
              decoration: const InputDecoration(
                labelText: "Time",
              ),
            ),
            const SizedBox(height: 16.0),
            TextFormField(
              controller: _priceController,
              decoration: const InputDecoration(
                labelText: "Price",
              ),
            ),
            const SizedBox(height: 16.0),
            TextFormField(
              controller: _placeController,
              decoration: const InputDecoration(
                labelText: "Place",
              ),
            ),
            const SizedBox(height: 16.0),
            TextFormField(
              controller: _commentController,
              decoration: const InputDecoration(
                labelText: "Comment",
              ),
            ),
            const SizedBox(height: 16.0),
            TextFormField(
              controller: _descriptionController,
              decoration: const InputDecoration(
                labelText: "Description",
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          widget.activity.name = _nameController.text;
          widget.activity.time = _timeController.text;
          widget.activity.price = _priceController.text;
          widget.activity.place = _placeController.text;
          widget.activity.comment = _commentController.text;
          widget.activity.description = _descriptionController.text;
          Navigator.pop(context);
        },
        child: const Icon(Icons.save),
      ),
    );
  }
}

void showAlertDialogOnOkCallback(
  String title,
  String msg,
  DialogType dialogType,
  BuildContext context,
  VoidCallback onOkPress,
) {
  AwesomeDialog(
    context: context,
    animType: AnimType.TOPSLIDE,
    dialogType: dialogType,
    title: title,
    desc: msg,
    btnOkIcon: Icons.check_circle,
    btnOkColor: Colors.green.shade900,
    btnOkOnPress: onOkPress,
  ).show();
}

// void showDialogForModify(BuildContext context, Function() onConfirm) {
//   showDialog(
//     context: context,
//     builder: (BuildContext context) {
//       return AlertDialog(
//         title: const Text("Modify Confirmation"),
//         content: const Text("Are you sure you want to modify this activity?"),
//         actions: <Widget>[
//           TextButton(
//             onPressed: () => Navigator.pop(context),
//             child: const Text("CANCEL"),
//           ),
//           TextButton(
//             onPressed: () {
//               onConfirm();
//               Navigator.pop(context);
//             },
//             child: const Text("MODIFY"),
//           ),
//         ],
//       );
//     },
//   );
// }

void showDialogForModify(BuildContext context, Function() onConfirm) {
  AwesomeDialog(
    context: context,
    animType: AnimType.TOPSLIDE,
    dialogType: DialogType.INFO,
    title: 'Modify Confirmation',
    desc: 'Are you sure you want to modify this activity?',
    btnCancelOnPress: () => Navigator.pop(context),
    btnOkOnPress: () {
      onConfirm();
      Navigator.pop(context);
    },
  ).show();
}

// the description of an activity
class Activity {
  String id;
  String name;
  String time;
  String logoPath;
  String symbolName;
  String photoPath;
  String place;
  String comment;
  String description;
  String price;

  Activity(
      {required this.id,
      required this.name,
      required this.time,
      required this.price,
      required this.logoPath,
      required this.symbolName,
      required this.photoPath,
      required this.place,
      this.comment = "",
      required this.description});
}

class PlanningScreen extends StatefulWidget {
  final Planning planning;

  const PlanningScreen(this.planning, {super.key});
  @override
  _PlanningScreenState createState() => _PlanningScreenState();
}

class _PlanningScreenState extends State<PlanningScreen> {
  final DateTime _startDate = DateTime.now().subtract(const Duration(days: 3));
  final DateTime _endDate = DateTime.now().add(const Duration(days: 20));
  final List<DateTime> _days = [];

  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    // Generate a list of days between the start and end dates
    int daysDifference = _endDate.difference(_startDate).inDays;
    for (int i = 0; i <= daysDifference; i++) {
      _days.add(_startDate.add(Duration(days: i)));
    }
  }

  // exemple for list of activiies to test the activity list view
  final List<Activity> activities = [
    Activity(
      id: "1",
      name: "Restaurants",
      time: "19:00-20:00",
      price: "0€",
      logoPath: 'assets/images/restt.svg',
      symbolName: 'Restaurant Dar El Jeld',
      photoPath:
          'https://www.sejours-tunisie.com/wp-content/uploads/2019/02/meilleurs-restaurants-tunis.jpg',
      place: 'Tunisie, Tunis',
      description:
          'Dar El Jeld : avec sa localisation atypique au milieu du souk de Tunis, cette demeure exceptionnelle reconvertit en restaurant chic et raffiné propose divers plats orientaux et tunisiens d’exception : généreux et goûteux, vous serez agréablement séduit !',
    ),
    Activity(
      id: "1",
      name: "Flights",
      time: "14:00-14:45",
      price: "0€",
      logoPath: 'assets/images/Vol.svg',
      symbolName: 'Aéroport de Tunis',
      photoPath:
          'https://destinationsmed.com/wp-content/uploads/2022/08/TUN_1-984x554-1.jpg',
      place: 'Aéroport tunis carthage',
      description:
          'cette aéroport porte le nom de la cité historique de Carthage qui est située à cette aéroport. Lors de sa mise en exploitation, aérodrome est connu sous le nom de Tunis-El Aouina.',
    ),
    Activity(
      id: "2",
      name: "Bus",
      time: "15:00-15:45",
      price: "0€",
      logoPath: 'assets/images/bus.svg',
      symbolName: 'Aéroport de Tunis',
      photoPath:
          'https://destinationsmed.com/wp-content/uploads/2022/08/TUN_1-984x554-1.jpg',
      place: 'Aéroport tunis carthage',
      description:
          'cette aéroport porte le nom de la cité historique de Carthage qui est située à cette aéroport. Lors de sa mise en exploitation, aérodrome est connu sous le nom de Tunis-El Aouina.',
    ),
    Activity(
      id: "3",
      name: "Hotels",
      time: "15:45-17:30",
      price: "0€",
      logoPath: 'assets/images/hottt.svg',
      symbolName: 'Royal Azur Hotel Thalassa',
      photoPath:
          'https://cdn2.tqsan.com/booking/royal-azur-thalasso-golf/Hotel-783-20170607-093132.jpg',
      place: 'Hammamet, Tunisie Station touristique',
      description:
          'L’Hôtel Royal Azur Thalassa propose une de?couverte Tunisienne à travers une déambulation dans ses espaces à caractère culturel profond.',
    ),
    Activity(
      id: "4",
      name: "Restaurants",
      time: "18:00-20:00",
      price: "0€",
      logoPath: 'assets/images/restt.svg',
      symbolName: 'Restaurant Dar El Jeld',
      photoPath:
          'https://www.sejours-tunisie.com/wp-content/uploads/2019/02/meilleurs-restaurants-tunis.jpg',
      place: 'Tunisie, Tunis',
      description:
          'Dar El Jeld : avec sa localisation atypique au milieu du souk de Tunis, cette demeure exceptionnelle reconvertit en restaurant chic et raffiné propose divers plats orientaux et tunisiens d’exception : généreux et goûteux, vous serez agréablement séduit !',
    ),
    Activity(
      id: "5",
      name: "Visits",
      time: "17:00-18:00",
      price: "28,51€",
      logoPath: 'assets/images/vis.svg',
      symbolName: 'Sidi Bou Said',
      photoPath:
          "https://travelfree.info/wp-content/uploads/2020/06/tunisia-2425441_1280-e1593516163383.jpg",
      place: "Tunisia-tunis",
      description:
          "You could be forgiven for thinking that you’d made the hop across the Med to the islands of the Greek Aegean as you enter the vibrant interior of Sidi Bou Said town, sat just 20 kilometers from bustling Tunis.Yep, the sky-blue and whitewashed color scheme here is more than reminiscent of towns in Santorini and Mykonos.However, this one’s interesting hues were actually started by the French musicologist Rodolphe d’Erlanger.",
    ),
    Activity(
      id: "6",
      name: "Visits",
      time: "10:00-14:00",
      price: "28,51€",
      logoPath: 'assets/images/vis.svg',
      symbolName: 'Excursion Stars Wars',
      photoPath:
          "https://unsacsurledos.com/wp-content/uploads/2016/12/PC051057.jpg",
      place: "Tunisia-Gabes",
      description:
          "Quand l’histoire nous emporte de l’autre côté de l’écran ! Après la découverte des décors de Game of Thrones en Irlande du Nord, nous voici dans ceux de Star Wars en Tunisie. Au milieu du désert, nous sommes partis explorer la planète Tatooine, sur les traces de Anakin, Luke, Obi-Wan, Darth et Vador. Voici notre aventure en mode Jedi et toutes les informations pour visiter les lieux de tournage Star Wars en Tunisie." +
              "Star Wars en Tunisie: " +
              "Star Wars, une saga qu’on ne présente plus ! Qu’on soit fan ou pas, tout le monde connait le souffle rauque de Darth Vador, le cri de Luke, le bikini de Leia et la dégaine de Han Solo. Mais peu savent où les épisodes ont été tournés !" +
              "C’est dans le sud de la Tunisie, au milieu des étendues désertiques, que des passages de la trilogie originale (épisodes IV – V – VI) et de la « Prélogie » (épisodes I – II – III) ont été tournés, tout spécialement les épisodes I (tourné en 1997, sorti en 1999), II (tourné en 2000, sorti en 2002), III (tourné en 2003, sorti en 2005) et IV (tourné en 1976, sorti en 1977) ,' tous ceux qui concernent la planete Tatooine, planete natale du mignon petit blondinet Anakin Skywalker.",
    ),
    Activity(
      id: "7",
      name: "Activities",
      time: "10:00-12:30",
      price: "48,51€",
      logoPath: 'assets/images/mount.svg',
      symbolName: 'lle de Djerba',
      photoPath:
          'https://dynamic-media-cdn.tripadvisor.com/media/photo-o/1c/cd/1b/31/caption.jpg?w=500&h=400&s=1',
      place: 'Par Djerba Explore',
      description:
          'Essayez le quad à Djerba pour un circuit aventureux et passionnant, adapté aux débutants, aux cyclistes expérimentés et aux groupes. Parcourez des paysages incroyables remplis d' +
              "eucalyptus et de figuiers de Barbarie avec des machines de haute qualité et avec un guide spécialisé.",
    ),
  ];

  Widget _buildDay(DateTime day) {
    String dayOfWeek = "";
    switch (day.weekday) {
      case 1:
        dayOfWeek = "MON";
        break;
      case 2:
        dayOfWeek = "TUE";
        break;
      case 3:
        dayOfWeek = "WED";
        break;
      case 4:
        dayOfWeek = "THU";
        break;
      case 5:
        dayOfWeek = "FRI";
        break;
      case 6:
        dayOfWeek = "SAT";
        break;
      case 7:
        dayOfWeek = "SUN";
        break;
    }
    bool isSelected = _currentIndex == _days.indexOf(day);
    return GestureDetector(
      onTap: () {
        setState(() {
          _currentIndex = _days.indexOf(day);
        });
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 5.0),
        decoration: BoxDecoration(
          color: isSelected
              ? const Color.fromARGB(255, 241, 210, 231)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Center(
          child: Text(
            "$dayOfWeek ${day.day}",
            style: TextStyle(
              fontSize: 14.0,
              fontWeight: FontWeight.w500,
              color: (day == _currentIndex) ? Colors.blue : Colors.black,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDaysList() {
    return SizedBox(
      height: 50.0,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: _days.length,
        itemBuilder: (BuildContext context, int index) {
          return _buildDay(_days[index]);
        },
      ),
    );
  }

  List<Widget> _buildBoxes() {
    List<Widget> boxes = [];

    for (int j = 0; j < activities.length; j++) {
      Activity index = activities[j];
      // Generate a random color for each box
      Random random = Random();
      Color boxColor = Color.fromRGBO(
        Random().nextInt(255),
        Random().nextInt(255),
        Random().nextInt(255),
        0.5,
      );
      // Generate a random height for each box between 50 and 150
      double boxHeight = 250.0 /*+ DateTime.now().millisecond % 100*/;

      //Box's Detail
      Widget box = GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => BoxDescriptionPage(
                activity: index,
              ),
            ),
          );
        },
        child: Container(
          height: boxHeight,
          decoration: BoxDecoration(
            color: boxColor.withOpacity(0.6),
            borderRadius: BorderRadius.circular(8.0),
          ),
          margin: const EdgeInsets.all(10),
          padding: const EdgeInsets.all(10),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const SizedBox(height: 4),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        index.time,
                        style: const TextStyle(fontSize: 18),
                      ),
                      const SizedBox(width: 170.0),
                      GestureDetector(
                        onTap: () {
                          // Navigate to activity's notification page for the selected activity
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ActivityNotificationPage(),
                            ),
                          );
                        },
                        child: Icon(Icons.notifications),
                      ),
                      const SizedBox(width: 6.0),
                      //

                      PopupMenuButton<String>(
                        onSelected: (value) {
                          if (value == "delete") {
                            AwesomeDialog(
                              context: context,
                              animType: AnimType.TOPSLIDE,
                              dialogType: DialogType.WARNING,
                              title: 'Alert Dialog',
                              desc: 'Do you really want to delete?',
                              btnCancelOnPress: () {},
                              btnOkOnPress: () {
                                // execute delete action
                                activities.removeWhere(
                                    (element) => element.id == index.id);
                                setState(() {
                                  // refresh UI after deleting element from list
                                });
                              },
                              btnCancelText: 'Close',
                              btnOkText: 'Yes',
                            ).show();
                          } else if (value == "modify") {
                            //     AwesomeDialog(
                            //       context: context,
                            //       animType: AnimType.TOPSLIDE,
                            //       dialogType: DialogType.INFO,
                            //       title: 'Alert Dialog',
                            //       desc: 'Do you really want to modify?',
                            //       btnCancelOnPress: () {},
                            //       btnOkOnPress: () {
                            //         Navigator.pop(context); // close dialog
                            //         // navigate to EditActivityScreen to edit the activity data
                            //         Navigator.push(
                            //           context,
                            //           MaterialPageRoute(
                            //             builder: (context) =>
                            //                 EditActivityScreen(activity: index),
                            //           ),
                            //         ).then((value) {
                            //           // refresh UI after returning from EditActivityScreen
                            //           setState(() {});
                            //         });
                            //       },
                            //       btnCancelText: 'Close',
                            //       btnOkText: 'Yes',
                            //     ).show();
                            //   }
                            // },
                            showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: const Text('Alert Dialog'),
                                  content: const Text(
                                      'Do you really want to modify?'),
                                  actions: <Widget>[
                                    TextButton(
                                      onPressed: () {
                                        Navigator.pop(context); // close dialog
                                        // navigate to EditActivityScreen to edit the activity data
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                EditActivityScreen(
                                                    activity: index),
                                          ),
                                        ).then((value) {
                                          // refresh UI after returning from EditActivityScreen
                                          setState(() {});
                                        });
                                      },
                                      child: const Text('Yes'),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        Navigator.pop(context); // close dialog
                                      },
                                      child: const Text('Close'),
                                    ),
                                  ],
                                );
                              },
                            );
                          }
                        },
                        itemBuilder: (context) => [
                          const PopupMenuItem(
                            value: "delete",
                            child: Row(
                              children: [
                                Icon(Icons.delete),
                                SizedBox(width: 5),
                                Text("Delete"),
                              ],
                            ),
                          ),
                          const PopupMenuItem(
                            value: "modify",
                            child: Row(
                              children: [
                                Icon(Icons.edit),
                                SizedBox(width: 5),
                                Text("Modify"),
                              ],
                            ),
                          ),
                        ],
                        child: Icon(Icons.more_vert),
                      ),
                    ],
                  ),
                  const SizedBox(height: 14),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const SizedBox(height: 14),
                      ClipOval(
                        child: SvgPicture.asset(
                          index.logoPath,
                          fit: BoxFit.cover,
                          height: 40.0,
                        ),
                      ),
                      const SizedBox(width: 8, height: 16),
                      Text(
                        index.name,
                        style: const TextStyle(
                            fontSize: 17, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 4,
                        width: 79,
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const SizedBox(height: 20),
                      ClipOval(
                        child: Image.network(
                          index.photoPath,
                          width: 50,
                          height: 50,
                          fit: BoxFit.cover,
                        ),
                      ),
                      const SizedBox(width: 6, height: 80),
                      Text(
                        index.symbolName,
                        style: const TextStyle(
                            fontSize: 13, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        child: SvgPicture.asset(
                          'assets/images/place.svg',
                          width: 13,
                          height: 13,
                          fit: BoxFit.cover,
                        ),
                      ),
                      const SizedBox(height: 26, width: 10),
                      Text(
                        index.place,
                        style: const TextStyle(
                          color: Color.fromARGB(255, 8, 8, 8),
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      );

      // Add the box widget to the list of boxes
      boxes.add(box);
    }

    return boxes;
  }

  Widget _buildPlanContent() {
    DateTime currentDay = _days[_currentIndex];
    // Generate a list of boxes with different colors and contents
    List<Widget> boxes = _buildBoxes();
    return Container(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 10.0),
          Expanded(
            child: ListView.builder(
              itemCount: boxes.length,
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5.0),
                  child: boxes[index],
                  //),
                );
              },
            ),
          ),
        ],
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Planning ',
                  style: TextStyle(
                    fontSize: 27.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                InkWell(
                  onTap: () {
                    showModalBottomSheet(
                      context: context,
                      builder: (context) {
                        return Container(
                          height: MediaQuery.of(context).size.height * 0.6,
                          padding: const EdgeInsets.all(20.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Modify Activities',
                                style: TextStyle(
                                  fontSize: 24.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 20.0),
                              Expanded(
                                child: ListView.builder(
                                  itemCount: activities.length,
                                  itemBuilder: (context, index) {
                                    // Check if the activity name already exists
                                    bool isDuplicate = activities
                                            .where((activity) =>
                                                activity.name ==
                                                activities[index].name)
                                            .toList()
                                            .length >
                                        1;

                                    // Display the activity only if it is the first occurrence of its name
                                    if (isDuplicate &&
                                        index > 0 &&
                                        activities[index].name ==
                                            activities[index - 1].name) {
                                      return Container();
                                    }

                                    return Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 10.0),
                                      child: ElevatedButton(
                                        onPressed: () {
                                          String selectedActivityName =
                                              activities[index].name;
                                          List<Activity>
                                              activitiesWithSameName =
                                              activities
                                                  .where((activity) =>
                                                      activity.name ==
                                                      selectedActivityName)
                                                  .toList();

                                          // Display the list of activities with the same name
                                          showModalBottomSheet(
                                            context: context,
                                            builder: (context) {
                                              return Container(
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    0.6,
                                                padding:
                                                    const EdgeInsets.all(20.0),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    const Text(
                                                      'Activities List',
                                                      style: TextStyle(
                                                        fontSize: 24.0,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                    const SizedBox(
                                                        height: 20.0),
                                                    Expanded(
                                                      child: ListView.builder(
                                                        itemCount:
                                                            activitiesWithSameName
                                                                .length,
                                                        itemBuilder:
                                                            (context, index) {
                                                          return Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .symmetric(
                                                                    vertical:
                                                                        10.0),
                                                            child:
                                                                ElevatedButton(
                                                              onPressed: () {
                                                                // Handle the button press
                                                              },
                                                              style:
                                                                  ElevatedButton
                                                                      .styleFrom(
                                                                backgroundColor:
                                                                    Colors.grey[
                                                                        300],
                                                                shape:
                                                                    RoundedRectangleBorder(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              10.0),
                                                                ),
                                                              ),
                                                              child: Row(
                                                                children: [
                                                                  SvgPicture
                                                                      .asset(
                                                                    activitiesWithSameName[
                                                                            index]
                                                                        .logoPath,
                                                                    width: 40.0,
                                                                    height:
                                                                        40.0,
                                                                  ),
                                                                  const SizedBox(
                                                                      width:
                                                                          16.0),
                                                                  Text(
                                                                    activitiesWithSameName[
                                                                            index]
                                                                        .symbolName,
                                                                    style:
                                                                        const TextStyle(
                                                                      fontSize:
                                                                          16.0,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                      color: Colors
                                                                          .black,
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          );
                                                        },
                                                      ),
                                                    ),
                                                    const SizedBox(
                                                        height: 20.0),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        // Add other buttons or actions if needed
                                                        ElevatedButton(
                                                          onPressed: () {
                                                            Navigator.pop(
                                                                context);
                                                          },
                                                          child: const Text(
                                                              'Close'),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              );
                                            },
                                          );
                                        },
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.grey[300],
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                          ),
                                        ),
                                        child: Row(
                                          children: [
                                            SvgPicture.asset(
                                              activities[index].logoPath,
                                              width: 40.0,
                                              height: 40.0,
                                            ),
                                            const SizedBox(width: 16.0),
                                            Text(
                                              activities[index].name,
                                              style: const TextStyle(
                                                fontSize: 16.0,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                              const SizedBox(height: 20.0),
                             
                              ElevatedButton(
                                onPressed: () {
                                 
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) => const NewActivity(),
                                    ),
                                  );
                                },
                                child: const Text('New Activity'),
                              ),
                             
                            ],
                          ),
                        );
                      },
                    );
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      color: Colors.grey[300],
                    ),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10.0, vertical: 5.0),
                    child: const Row(
                      children: [
                        Icon(
                          Icons.edit,
                          size: 20.0,
                        ),
                        SizedBox(width: 5.0),
                        Text(
                          'Modify',
                          style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Text(
              '${DateFormat('MMM d, y').format(_startDate)} ~ ${DateFormat('MMM d, y').format(_endDate)}',
              style: const TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          _buildDaysList(),
          Expanded(
            child: _buildPlanContent(),
          ),
        ],
      ),
    );
  }
}

class BoxDescriptionPage extends StatelessWidget {
  final Activity activity;

  const BoxDescriptionPage({super.key, required this.activity});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text(
      //     activity.name,
      //     style: const TextStyle(
      //       color: Color.fromARGB(255, 38, 6, 39),
      //     ),
      //   ),
      //   backgroundColor: const Color.fromARGB(255, 207, 207, 219),
      // ),
      appBar: AppBar(
        title: Row(
          children: [
            SvgPicture.asset(
              'assets/images/Logo.svg',
              fit: BoxFit.cover,
              height: 36.0,
            ),
            const SizedBox(
                width: 30.0), // Add spacing between the logo and the text
            Text(
              activity.name,
              style: const TextStyle(
                color: Color.fromARGB(255, 38, 6, 39),
              ),
            ),
          ],
        ),
        backgroundColor: const Color.fromARGB(255, 207, 207, 219),
      ),
      body: Container(
        margin: const EdgeInsets.all(20),

        //child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Image.network(activity.photoPath),
            const SizedBox(height: 16),
            /* Text(place.time),*/
            const SizedBox(height: 16),
            Row(
              children: [
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 153, 158, 233)
                        .withOpacity(0.2),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    activity.time,
                    style: const TextStyle(
                      color: Color.fromARGB(255, 39, 41, 176),
                    ),
                  ),
                ),
                const SizedBox(width: 146),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 153, 158, 233)
                        .withOpacity(0.2),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    'Price : ${activity.price}',
                    style: const TextStyle(
                      color: Color.fromARGB(255, 39, 41, 176),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Text(
              activity.symbolName,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  child: SvgPicture.asset(
                    'assets/images/place.svg',
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(height: 8, width: 6),
                Text(
                  activity.place,
                  style: const TextStyle(
                    color: Color.fromARGB(255, 8, 8, 8),
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16.0),
            const Divider(
              color: Color.fromARGB(255, 189, 184, 184),
              thickness: 2.0,
            ),
            const SizedBox(height: 16),
            const Text(
              "Description",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Expanded(
              child: SingleChildScrollView(
                child: Text(
                  activity.description,
                ),
              ),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}

// void _showMenu(BuildContext context) {
//   Scaffold.of(context).openDrawer();
// }

// class ShapedDrawer extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Drawer(
//       child: Container(
//         decoration: const BoxDecoration(
//           shape: BoxShape.rectangle,
//           borderRadius: BorderRadius.only(
//             topRight: Radius.circular(30),
//             bottomRight: Radius.circular(30),
//           ),
//           color: Color.fromARGB(255, 255, 255, 255),
//         ),
//         child: ListView(
//           padding: EdgeInsets.zero,
//           children: <Widget>[
//             ListTile(
//               leading: const Icon(Icons.home),
//               title: const Text('Home'),
//               onTap: () {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                       builder: (context) => const PlanningListPage()),
//                 );
//               },
//             ),
//             ListTile(
//               leading: const Icon(Icons.playlist_add_circle_outlined),
//               title: const Text('Destination'),
//               onTap: () {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                       builder: (context) => const DestinationScreen()),
//                 );
//               },
//             ),
//             ListTile(
//               leading: const Icon(Icons.calendar_month),
//               title: const Text('Schedule'),
//               onTap: () {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                       builder: (context) => const ScheduleScreen()),
//                 );
//               },
//             ),
//             ListTile(
//               leading: const Icon(Icons.groups),
//               title: const Text('Clients'),
//               onTap: () {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(builder: (context) => const ClientScreen()),
//                 );
//               },
//             ),
//             ListTile(
//               leading: const Icon(Icons.notification_add),
//               title: const Text('Create Notification'),
//               onTap: () {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                       builder: (context) => const AddNotification()),
//                 );
//               },
//             ),
//             ListTile(
//               leading: const Icon(Icons.info),
//               title: const Text('About'),
//               onTap: () {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(builder: (context) => const HomePage()),
//                 );
//               },
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

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
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ScheduleScreen()),
                            );
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
                                  builder: (context) => AboutPage()),
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

import 'dart:math';

import 'package:flutter/material.dart';

import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:guide_app/activity/newactivityyy.dart';
import 'package:guide_app/planning/Add_Client.dart';
import 'package:guide_app/notification/notification.dart';

import '../HelpScreen.dart';
import '../SettingsScreen.dart';
//import 'package:guide_app/activity/newactivity_test.dart';

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
      appBar: AppBar(
        title: Text("Edit Activity"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              controller: _nameController,
              decoration: InputDecoration(
                labelText: "Name",
              ),
            ),
            SizedBox(height: 16.0),
            TextFormField(
              controller: _timeController,
              decoration: InputDecoration(
                labelText: "Time",
              ),
            ),
            SizedBox(height: 16.0),
            TextFormField(
              controller: _priceController,
              decoration: InputDecoration(
                labelText: "Price",
              ),
            ),
            SizedBox(height: 16.0),
            TextFormField(
              controller: _placeController,
              decoration: InputDecoration(
                labelText: "Place",
              ),
            ),
            SizedBox(height: 16.0),
            TextFormField(
              controller: _commentController,
              decoration: InputDecoration(
                labelText: "Comment",
              ),
            ),
            SizedBox(height: 16.0),
            TextFormField(
              controller: _descriptionController,
              decoration: InputDecoration(
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
        child: Icon(Icons.save),
      ),
    );
  }
}

void showDialogForModify(BuildContext context, Function() onConfirm) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text("Modify Confirmation"),
        content: Text("Are you sure you want to modify this activity?"),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("CANCEL"),
          ),
          TextButton(
            onPressed: () {
              onConfirm();
              Navigator.pop(context);
            },
            child: Text("MODIFY"),
          ),
        ],
      );
    },
  );
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
  @override
  _PlanningScreenState createState() => _PlanningScreenState();
}

class _PlanningScreenState extends State<PlanningScreen> {
  DateTime _startDate = DateTime.now().subtract(Duration(days: 3));
  DateTime _endDate = DateTime.now().add(Duration(days: 20));
  List<DateTime> _days = [];
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
      id: "2",
      name: "Vols",
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
      id: "3",
      name: "Transport",
      time: "14:00-14:45",
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
      id: "4",
      name: "Hotles",
      time: "16:00-16:50",
      price: "0€",
      logoPath: 'assets/images/hottt.svg',
      symbolName: 'Royal Azur Hotel Thalassa',
      photoPath:
          'https://fwk.resabo.com/cr.fwk/images/hotels/Hotel-8905-20230102-095053.jpg',
      place: 'Hammamet, Tunisie Station touristique',
      description:
          'L’Hôtel Royal Azur Thalassa propose une de?couverte Tunisienne à travers une déambulation dans ses espaces à caractère culturel profond.',
    ),
    Activity(
      id: "5",
      name: "Visites",
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
      name: "Activities",
      time: "10:00-12:30",
      price: "48,51€",
      logoPath: 'assets/images/mount.svg',
      symbolName: 'lle de Djerba',
      photoPath:
          'https://dynamic-media-cdn.tripadvisor.com/media/photo-o/1c/cd/1b/31/caption.jpg?w=500&h=400&s=1',
      place: 'Par Djerba Explore',
      description: 'Ile de Djerba: excursion : une heure et demie en quad',
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
        margin: EdgeInsets.symmetric(horizontal: 5.0),
        decoration: BoxDecoration(
          color: isSelected
              ? Color.fromARGB(255, 241, 210, 231)
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
    return Container(
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

  /*Widget _buildBox() {
    return Container(
      height: 240.0,
      decoration: BoxDecoration(
        color: Color.fromRGBO(
          Random().nextInt(255),
          Random().nextInt(255),
          Random().nextInt(255),
          0.5,
        ),
        borderRadius: BorderRadius.circular(8.0),
      ),
    );
  }*/
  List<Widget> _buildBoxes() {
    String _selectedStatus = 'Pending';
    List<String> _statusOptions = ['Pending', 'In progress', 'Completed'];

    // List of boxes to be built dynamically
    List<Widget> boxes = [];
    // Generate a random number of boxes between 3 and 10
    int numBoxes = 3 + DateTime.now().millisecond % 8;

    // Loop through the number of boxes and add them to the list
    for (int i = 0; i < numBoxes; i++) {
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
            margin: EdgeInsets.all(10),
            padding: EdgeInsets.all(10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(height: 4),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          "${index.time}",
                          style: TextStyle(fontSize: 18),
                        ),
                        SizedBox(width: 170.0),
                        Icon(Icons.notifications),
                        SizedBox(width: 6.0),
                        PopupMenuButton(
                          onSelected: (value) {
                            if (value == "delete") {
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title: Text('Alert Dialog'),
                                    content:
                                        Text('Do you really want to delete?'),
                                    actions: <Widget>[
                                      TextButton(
                                        onPressed: () {
                                          // execute delete action
                                          activities.removeWhere((element) {
                                            return element.id == index.id;
                                          });
                                          setState(() {
                                            // refresh UI after deleting element from list
                                          });
                                          Navigator.pop(
                                              context); // close dialog
                                        },
                                        child: Text('Yes'),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          Navigator.pop(
                                              context); // close dialog
                                        },
                                        child: Text('Close'),
                                      ),
                                    ],
                                  );
                                },
                              );
                            } else if (value == "modify") {
                              // handle modify action
                              // navigate to EditActivityScreen to edit the activity data
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      EditActivityScreen(activity: index),
                                ),
                              ).then((value) {
                                // refresh UI after returning from EditActivityScreen
                                setState(() {});
                              });
                            }
                          },
                          itemBuilder: (context) => [
                            PopupMenuItem(
                              value: "delete",
                              child: Row(
                                children: [
                                  Icon(Icons.delete),
                                  SizedBox(width: 5),
                                  Text("Delete"),
                                ],
                              ),
                            ),
                            PopupMenuItem(
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
                    SizedBox(height: 14),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(height: 14),
                        ClipOval(
                          child: SvgPicture.asset(
                            index.logoPath,
                            fit: BoxFit.cover,
                            height: 40.0,
                          ),
                        ),
                        SizedBox(width: 8, height: 16),
                        Text(
                          index.name,
                          style: TextStyle(
                              fontSize: 17, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 4,
                          width: 79,
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: Color.fromARGB(255, 221, 216, 216),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: DropdownButton<String>(
                            value: _selectedStatus,
                            onChanged: (String? newValue) {
                              setState(() {
                                _selectedStatus = newValue!;
                              });
                            },
                            items: _statusOptions
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(height: 20),
                        ClipOval(
                          child: Image.network(
                            index.photoPath,
                            width: 50,
                            height: 50,
                            fit: BoxFit.cover,
                          ),
                        ),
                        SizedBox(width: 6, height: 80),
                        Text(
                          index.symbolName,
                          style: TextStyle(
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
                        SizedBox(height: 26, width: 10),
                        Text(
                          index.place,
                          style: TextStyle(
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
    }
    return boxes;
  }

  Widget _buildPlanContent() {
    DateTime currentDay = _days[_currentIndex];
    // Generate a list of boxes with different colors and contents
    List<Widget> boxes = _buildBoxes();
    return Container(
      padding: EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 10.0),
          Expanded(
            child: ListView.builder(
              itemCount: boxes.length,
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: EdgeInsets.symmetric(vertical: 5.0),
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
    final start = DateFormat("MMM dd, yyyy").format(_startDate);
    final end = DateFormat("MMM dd, yyyy").format(_endDate);
    List<String> _works = [
      'Work 1',
      'Work 2',
      'Work 3',
      'Work 4',
      'Work 5',
      'Work 6'
    ]; // add the _works list

    return Scaffold(
      appBar: AppBar(
        title: SvgPicture.asset(
          'assets/images/Logo.svg',
          fit: BoxFit.cover,
          height: 36.0,
        ),
        backgroundColor: Color.fromARGB(255, 207, 207, 219),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.notifications),
            onPressed: () {
              // Navigate to notifications screen when button is pressed
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => NotificationsScreen()),
              );
            },
          ),
          IconButton(
            icon: Icon(Icons.menu),
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
            padding: EdgeInsets.all(10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Planning 1',
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
                          padding: EdgeInsets.all(20.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Modify Activities',
                                style: TextStyle(
                                  fontSize: 24.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 20.0),
                              Expanded(
                                child: ListView.builder(
                                  itemCount: activities.length,
                                  itemBuilder: (context, index) {
                                    return Padding(
                                      padding:
                                          EdgeInsets.symmetric(vertical: 10.0),
                                      child: ElevatedButton(
                                        onPressed: () {
                                          // Handle the button press
                                        },
                                        style: ElevatedButton.styleFrom(
                                          primary: Colors.grey[300],
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
                                            SizedBox(width: 16.0),
                                            Text(
                                              activities[index].name,
                                              style: TextStyle(
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
                              SizedBox(height: 20.0),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  ElevatedButton(
                                    onPressed: () {
                                      // Handle the button press
                                      Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (context) => NewActivity(),
                                        ),
                                      );
                                    },
                                    child: Text('Ajouter autre'),
                                  ),
                                  Row(
                                    children: [
                                      ElevatedButton(
                                        onPressed: () {
                                          // Handle the button press
                                        },
                                        child: Text('Enregistrer'),
                                      ),
                                      SizedBox(width: 10.0),
                                      ElevatedButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: Text('Annuler'),
                                      ),
                                    ],
                                  ),
                                ],
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
                    padding:
                        EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
                    child: Row(
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
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            child: Text(
              '${DateFormat('MMM d, y').format(_startDate)} ~ ${DateFormat('MMM d, y').format(_endDate)}',
              style: TextStyle(
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
      /*floatingActionButton: FloatingActionButton(
        onPressed: () {
          // add new activity
        },
        tooltip: 'Add Activity',
        child: Icon(Icons.add),
        backgroundColor: Color.fromARGB(255, 243, 151, 208),
      ),*/
    );
  }
}

class BoxDescriptionPage extends StatelessWidget {
  final Activity activity;

  BoxDescriptionPage({required this.activity});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          activity.name,
          style: TextStyle(
            color: Color.fromARGB(255, 38, 6, 39),
          ),
        ),
        backgroundColor: Color.fromARGB(255, 207, 207, 219),
      ),
      body: Container(
        margin: EdgeInsets.all(20),

        //child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Image.network(activity.photoPath),
            SizedBox(height: 16),
            /* Text(place.time),*/

            Row(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 153, 158, 233).withOpacity(0.2),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    activity.time,
                    style: TextStyle(
                      color: Color.fromARGB(255, 39, 41, 176),
                    ),
                  ),
                ),
                SizedBox(width: 146),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 153, 158, 233).withOpacity(0.2),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    'Price : ${activity.price}',
                    style: TextStyle(
                      color: Color.fromARGB(255, 39, 41, 176),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 8),
            Text(
              activity.symbolName,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            /*SizedBox(height: 8),
          Text(place.address),*/

            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  child: SvgPicture.asset(
                    'assets/images/place.svg',
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(height: 8, width: 6),
                Text(
                  activity.place,
                  style: TextStyle(
                    color: Color.fromARGB(255, 8, 8, 8),
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ],
            ),
            SizedBox(height: 16.0),
            Divider(
              color: Color.fromARGB(255, 189, 184, 184),
              thickness: 2.0,
            ),
            SizedBox(height: 16),
            Text(
              "Description",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(activity.description),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                  onPressed: () {},
                  child: Text("Accept", style: TextStyle(color: Colors.white)),
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(
                        Color.fromARGB(255, 252, 56, 121)),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {},
                  child: Text("Decline", style: TextStyle(color: Colors.black)),
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(
                        Color.fromARGB(255, 214, 208, 208)),
                  ),
                ),
              ],
            ),
          ],
        ),
        // ),
      ),
    );
  }
}

// Define a function to show the menu options
/*void _showMenu(BuildContext context) {
  showModalBottomSheet(
    context: context,
    builder: (BuildContext context) {
      return Container(
        child: Wrap(
          children: <Widget>[
            ListTile(
              leading: const Icon(Icons.local_hotel_outlined),
              title: const Text('Hotels'),
              onTap: () {
                // Navigate to hotels screen when pressed
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AddClientScreen()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.category),
              title: const Text('Restaurants'),
              onTap: () {
                // Navigate to restaurants screen when pressed
                Navigator.pushNamed(context, '/restaurants');
              },
            ),
            /* ListTile(
              leading: const Icon(Icons.category),
              title: const Text('Activié/Visite'),
              onTap: () {
                // Navigate to activites screen when pressed
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => VisitesScreen()),
                );
              },
            ),*/
          ],
        ),
      );
    },
  );
}
*/
void _showMenu(BuildContext context) {
  showModalBottomSheet(
    context: context,
    backgroundColor: Colors.transparent,
    builder: (BuildContext context) {
      return Container(
        decoration: BoxDecoration(
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
              leading: Icon(Icons.home),
              title: Text('Home'),
              onTap: () {
                // Navigate to home screen
                Navigator.pop(context);
                Navigator.pushReplacementNamed(context, '/home');
              },
            ),
            ListTile(
              leading: Icon(Icons.person),
              title: Text('Profile'),
              onTap: () {
                // Navigate to settings screen
                Navigator.pop(context);
                Navigator.pushNamed(context, '/profile');
              },
            ),
            ListTile(
              leading: Icon(Icons.calendar_month),
              title: Text('Schedule'),
              onTap: () {
                // Navigate to settings screen
                Navigator.pop(context);
                Navigator.pushNamed(context, '/Schedule');
              },
            ),
            ListTile(
              leading: Icon(Icons.groups),
              title: Text('Clients'),
              onTap: () {
                // Navigate to settings screen
                Navigator.pop(context);
                Navigator.pushNamed(context, '/clients');
              },
            ),
            ListTile(
              leading: Icon(Icons.feedback),
              title: Text('Feedbacks'),
              onTap: () {
                // Navigate to settings screen
                Navigator.pop(context);
                Navigator.pushNamed(context, '/Feedbacks');
              },
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text('Settings'),
              onTap: () {
                // Navigate to settings screen
                Navigator.pop(context);
                Navigator.pushNamed(context, '/settings');
              },
            ),
            ListTile(
              leading: Icon(Icons.info),
              title: Text('About'),
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

// import 'package:flutter/material.dart';

// class ActivityNotificationPage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Activity Notifications'),
//       ),
//       body: SingleChildScrollView(
//         child: Column(
//           children: [
//             SizedBox(height: 10),
//             Text(
//               'Comments from Passengers',
//               style: TextStyle(
//                 fontSize: 18,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//             SizedBox(height: 10),
//             CommentList(),
//             SizedBox(height: 20),
//             Text(
//               'Passengers Who Accepted the Activity',
//               style: TextStyle(
//                 fontSize: 18,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//             SizedBox(height: 10),
//             AcceptedPassengerList(),
//             SizedBox(height: 20),
//             Text(
//               'Passengers Who Declined the Activity',
//               style: TextStyle(
//                 fontSize: 18,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//             SizedBox(height: 10),
//             DeclinedPassengerList(),
//             SizedBox(height: 20),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class CommentList extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     // Replace this with your actual list of comments
//     List<String> comments = [
//       'Great activity!',
//       'I enjoyed it a lot.',
//       'Could be better.',
//     ];

//     return ListView.builder(
//       shrinkWrap: true,
//       physics: NeverScrollableScrollPhysics(),
//       itemCount: comments.length,
//       itemBuilder: (context, index) {
//         return ListTile(
//           leading: Icon(Icons.comment),
//           title: Text(comments[index]),
//         );
//       },
//     );
//   }
// }

// class AcceptedPassengerList extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     // Replace this with your actual list of accepted passengers
//     List<String> acceptedPassengers = [
//       'John Doe',
//       'Jane Smith',
//       'Michael Johnson',
//     ];

//     return ListView.builder(
//       shrinkWrap: true,
//       physics: NeverScrollableScrollPhysics(),
//       itemCount: acceptedPassengers.length,
//       itemBuilder: (context, index) {
//         return ListTile(
//           leading: Icon(Icons.check_circle),
//           title: Text(acceptedPassengers[index]),
//         );
//       },
//     );
//   }
// }

// class DeclinedPassengerList extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     // Replace this with your actual list of declined passengers
//     List<String> declinedPassengers = [
//       'Alex Johnson',
//       'Emily Wilson',
//       'David Brown',
//     ];

//     return ListView.builder(
//       shrinkWrap: true,
//       physics: NeverScrollableScrollPhysics(),
//       itemCount: declinedPassengers.length,
//       itemBuilder: (context, index) {
//         return ListTile(
//           leading: Icon(Icons.cancel),
//           title: Text(declinedPassengers[index]),
//         );
//       },
//     );
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:curved_navigation_bar/curved_navigation_bar.dart';

// class ActivityNotificationPage extends StatefulWidget {
//   @override
//   _ActivityNotificationPageState createState() =>
//       _ActivityNotificationPageState();
// }

// class _ActivityNotificationPageState extends State<ActivityNotificationPage> {
//   int _page = 0;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Activity Notifications'),
//       ),
//       body: SingleChildScrollView(
//         child: Column(
//           children: [
//             SizedBox(height: 10),
//             Text(
//               'Comments from Passengers',
//               style: TextStyle(
//                 fontSize: 18,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//             SizedBox(height: 10),
//             CommentList(),
//             SizedBox(height: 20),
//             Text(
//               'Passengers Who Accepted the Activity',
//               style: TextStyle(
//                 fontSize: 18,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//             SizedBox(height: 10),
//             AcceptedPassengerList(),
//             SizedBox(height: 20),
//             Text(
//               'Passengers Who Declined the Activity',
//               style: TextStyle(
//                 fontSize: 18,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//             SizedBox(height: 10),
//             DeclinedPassengerList(),
//             SizedBox(height: 20),
//           ],
//         ),
//       ),
//       bottomNavigationBar: CurvedNavigationBar(
//         index: _page,
//         height: 50.0,
//         items: <Widget>[
//           Icon(Icons.home, size: 30),
//           Icon(Icons.favorite_border, size: 30),
//           Icon(Icons.supervised_user_circle, size: 30),
//           Icon(Icons.notifications_active, size: 30),
//           Icon(Icons.more_vert, size: 30),
//         ],
//         color: Colors.white,
//         buttonBackgroundColor: Colors.white,
//         backgroundColor: Colors.blueAccent,
//         animationCurve: Curves.easeInOut,
//         animationDuration: Duration(milliseconds: 600),
//         onTap: (index) {
//           setState(() {
//             _page = index;
//           });
//         },
//       ),
//     );
//   }
// }

// class CommentList extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     // Replace this with your actual list of comments
//     List<String> comments = [
//       'Great activity!',
//       'I enjoyed it a lot.',
//       'Could be better.',
//     ];

//     return ListView.builder(
//       shrinkWrap: true,
//       physics: NeverScrollableScrollPhysics(),
//       itemCount: comments.length,
//       itemBuilder: (context, index) {
//         return ListTile(
//           leading: Icon(Icons.comment),
//           title: Text(comments[index]),
//         );
//       },
//     );
//   }
// }

// class AcceptedPassengerList extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     // Replace this with your actual list of accepted passengers
//     List<String> acceptedPassengers = [
//       'John Doe',
//       'Jane Smith',
//       'Michael Johnson',
//     ];

//     return ListView.builder(
//       shrinkWrap: true,
//       physics: NeverScrollableScrollPhysics(),
//       itemCount: acceptedPassengers.length,
//       itemBuilder: (context, index) {
//         return ListTile(
//           leading: Icon(Icons.check_circle),
//           title: Text(acceptedPassengers[index]),
//         );
//       },
//     );
//   }
// }

// class DeclinedPassengerList extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     // Replace this with your actual list of declined passengers
//     List<String> declinedPassengers = [
//       'Alex Johnson',
//       'Emily Wilson',
//       'David Brown',
//     ];

//     return ListView.builder(
//       shrinkWrap: true,
//       physics: NeverScrollableScrollPhysics(),
//       itemCount: declinedPassengers.length,
//       itemBuilder: (context, index) {
//         return ListTile(
//           leading: Icon(Icons.cancel),
//           title: Text(declinedPassengers[index]),
//         );
//       },
//     );
//   }
// }
import 'package:flutter_svg/svg.dart';
import 'package:flutter/material.dart';

class ActivityNotificationPage extends StatefulWidget {
  @override
  _ActivityNotificationPageState createState() =>
      _ActivityNotificationPageState();
}

class _ActivityNotificationPageState extends State<ActivityNotificationPage> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text('Activity Notifications'),
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
            const Text('Activity Notifications'),
          ],
        ),
        backgroundColor: const Color.fromARGB(255, 207, 207, 219),
      ),
      body: _buildPageContent(),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.comment),
            label: 'Comments',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.check_circle),
            label: 'Accepted',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.cancel),
            label: 'Declined',
          ),
        ],
      ),
    );
  }

  Widget _buildPageContent() {
    switch (_currentIndex) {
      case 0:
        return CommentList();
      case 1:
        return AcceptedPassengerList();
      case 2:
        return DeclinedPassengerList();
      default:
        return SizedBox.shrink();
    }
  }
}

class CommentList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Replace this with your actual list of comments
    List<String> comments = [
      'Great activity!',
      'I enjoyed it a lot.',
      'Could be better.',
    ];

    return ListView.builder(
      itemCount: comments.length,
      itemBuilder: (context, index) {
        return ListTile(
          leading: Icon(Icons.comment),
          title: Text(comments[index]),
        );
      },
    );
  }
}

class AcceptedPassengerList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Replace this with your actual list of accepted passengers
    List<String> acceptedPassengers = [
      'John Doe',
      'Jane Smith',
      'Michael Johnson',
    ];

    return ListView.builder(
      itemCount: acceptedPassengers.length,
      itemBuilder: (context, index) {
        return ListTile(
          leading: Icon(Icons.check_circle),
          title: Text(acceptedPassengers[index]),
        );
      },
    );
  }
}

class DeclinedPassengerList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Replace this with your actual list of declined passengers
    List<String> declinedPassengers = [
      'Alex Johnson',
      'Emily Wilson',
      'David Brown',
    ];

    return ListView.builder(
      itemCount: declinedPassengers.length,
      itemBuilder: (context, index) {
        return ListTile(
          leading: Icon(Icons.cancel),
          title: Text(declinedPassengers[index]),
        );
      },
    );
  }
}

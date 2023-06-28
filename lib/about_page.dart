import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class AboutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            SvgPicture.asset(
              'assets/images/Logo.svg',
              fit: BoxFit.cover,
              height: 36.0,
            ),
            const SizedBox(width: 30.0),
            const Text('About Zenify App'),
          ],
        ),
        backgroundColor: const Color.fromARGB(255, 207, 207, 219),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Zenify App is a mobile tour management application that offers an efficient and convenient solution for travel agencies and tour guides. This application allows managing notifications and complaints, contacting customers, managing task lists for guides, as well as managing activities and destinations for each trip. The application improves the communication between the travel agency, the guides, and the customers, by offering a centralized and user-friendly platform.',
              style: TextStyle(fontSize: 22.0),
            ),
            SizedBox(height: 120.0),
            SvgPicture.asset(
              'assets/images/Logo.svg',
              width: 120,
            ),
          ],
        ),
      ),
    );
  }
}

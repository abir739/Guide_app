import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../planning/planning.dart';

class BoxDescriptionPage extends StatelessWidget {
  final Activity activity;

  const BoxDescriptionPage({super.key, required this.activity});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          activity.name,
          style: const TextStyle(
            color: Color.fromARGB(255, 38, 6, 39),
          ),
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
            const SizedBox(height: 8),
            Text(
              activity.symbolName,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          
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
            Text(activity.description),
            const SizedBox(height: 16),
          ],
        ),
      
      ),
    );
  }
}
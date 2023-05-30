import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CommentSection extends StatelessWidget {
  final String placeName;

  const CommentSection({Key? key, required this.placeName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Fetch the comments for the current place
    final comments = fetchCommentsForPlace(placeName);

    return Scaffold(
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
            //  Text('Comments for $placeName'),
            const Text('Comments'),
          ],
        ),
        backgroundColor: const Color.fromARGB(255, 207, 207, 219),
      ),
      body: ListView.builder(
        itemCount: comments.length,
        itemBuilder: (context, index) {
          final comment = comments[index];
          return ListTile(
            title: Text(comment['author']!),
            subtitle: Text(comment['text']!),
          );
        },
      ),
    );
  }

  List<Map<String, String>> fetchCommentsForPlace(String placeName) {
    // Fetch comments from an external data source based on the place name
    // For simplicity, we'll just return a hardcoded list of comments here
    return [
      {'author': 'John Doe', 'text': 'This place is amazing!'},
      {'author': 'Jane Smith', 'text': 'I had a great time here.'},
      {'author': 'Adam Smith', 'text': 'I love spending my weekends here.'},
    ];
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CommentSection extends StatelessWidget {
  final String placeName;

  const CommentSection({Key? key, required this.placeName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Fetch the comments for the current place
    final comments = fetchCommentsForPlace(placeName);

    return Scaffold(
      appBar: AppBar(
        title: Text('Comments for $placeName'),
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
    ];
  }
}

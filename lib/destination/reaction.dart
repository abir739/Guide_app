import 'package:flutter/material.dart';

class ReactionsScreen extends StatelessWidget {
  final String placeName;

  ReactionsScreen({required this.placeName});

  final List<String> reactions = [
    '😍 Love it!',
    '👍 Good',
    '😕 Disappointing',
    '😡 Terrible',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Reactions for $placeName'),
      ),
      body: ListView.builder(
        itemCount: reactions.length,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            title: Text(reactions[index]),
          );
        },
      ),
    );
  }
}

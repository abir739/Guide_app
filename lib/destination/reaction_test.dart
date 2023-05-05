import 'package:flutter/material.dart';

class ReactionsScreen extends StatefulWidget {
  final String placeName;

  ReactionsScreen({required this.placeName});

  @override
  _ReactionsScreenState createState() => _ReactionsScreenState();
}

class _ReactionsScreenState extends State<ReactionsScreen> {
  int likes = 0;
  int loveCount = 0;
  int goodCount = 0;
  int disappointingCount = 0;
  int terribleCount = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Reactions for ${widget.placeName}'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Likes: $likes',
              style: TextStyle(fontSize: 20.0),
            ),
            SizedBox(height: 16.0),
            Text(
              'Reactions:',
              style: TextStyle(fontSize: 20.0),
            ),
            SizedBox(height: 8.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ReactionButton(
                  icon: '😍',
                  count: loveCount,
                  onPressed: () {
                    setState(() {
                      loveCount++;
                    });
                  },
                ),
                ReactionButton(
                  icon: '👍',
                  count: goodCount,
                  onPressed: () {
                    setState(() {
                      goodCount++;
                    });
                  },
                ),
                ReactionButton(
                  icon: '😕',
                  count: disappointingCount,
                  onPressed: () {
                    setState(() {
                      disappointingCount++;
                    });
                  },
                ),
                ReactionButton(
                  icon: '😡',
                  count: terribleCount,
                  onPressed: () {
                    setState(() {
                      terribleCount++;
                    });
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class ReactionButton extends StatelessWidget {
  final String icon;
  final int count;
  final VoidCallback onPressed;

  ReactionButton({
    required this.icon,
    required this.count,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        IconButton(
          icon: Text(icon, style: TextStyle(fontSize: 30.0)),
          onPressed: onPressed,
        ),
        Text('$count', style: TextStyle(fontSize: 16.0)),
      ],
    );
  }
}

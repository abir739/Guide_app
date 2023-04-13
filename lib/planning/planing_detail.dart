import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../models/planing_model.dart';

class PlanningDetailPage extends StatelessWidget {
  final Planning planning;

  const PlanningDetailPage(this.planning);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Planning Detail'),
      ),
      body: Center(
        child: Text('Activities for ${planning.name}'),
      ),
    );
  }
}

import 'package:flutter/material.dart';

import '../models/planing_model.dart';

class PlanningDetailPage extends StatelessWidget {
  final Planning planning;

  const PlanningDetailPage(this.planning, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Planning Detail'),
      ),
      body: Center(
        child: Text('Activities for ${planning.name}'),
      ),
    );
  }
}

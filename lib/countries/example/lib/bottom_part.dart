import 'package:country_list_picker_example/model/screen.dart';
import 'package:country_list_picker_example/translation.dart';
import 'package:country_list_picker_example/widget/expansion_tile.dart';
import 'package:flutter/material.dart';


import 'app_data.dart';

class BottomPart extends StatelessWidget {
  final Screen screen;
  const BottomPart({super.key, required this.screen});

  @override
  Widget build(BuildContext context) {
    if (screen.arguments.isEmpty) return screen.child!;
    int selectedIndex = 0;
    return ListView.separated(
      padding: const EdgeInsets.symmetric(horizontal: 5).copyWith(top: 0),
      separatorBuilder: (context, index) => const SizedBox(height: 2.5),
      itemCount: screen.arguments.length,
      itemBuilder: (context, index) {
        screen.arguments[index].key = GlobalKey<State<StatefulWidget>>();
        return Card(
          elevation: 5,
          child: XExpansionTile(
            initiallyExpanded: selectedIndex == index,
            key: screen.arguments[index].key,
            title: Text(screen.arguments[index].title.tr,
                style: const TextStyle(
                    fontSize: titlesFontSize, fontWeight: FontWeight.bold)),
            children: [screen.arguments[index].child],
            onExpansionChanged: (value) {
              if (value && index != selectedIndex) {
                screen.arguments[selectedIndex].key!.currentState
                    .closeExpansion();
              }
              selectedIndex = index;
            },
          ),
        );
      },
    );
  }
}

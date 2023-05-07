import 'package:flutter/material.dart';
import 'package:guide_app/planning/home_tasks.dart';
import 'package:guide_app/theme/colors/light_colors.dart';
import 'package:guide_app/widgets/top_container.dart';
import 'package:guide_app/widgets/back_button.dart';
import 'package:guide_app/widgets/my_text_field.dart';

class CreateNewTaskPage extends StatelessWidget {
  const CreateNewTaskPage({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    var downwardIcon = const Icon(
      Icons.keyboard_arrow_down,
      color: Colors.black54,
    );
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: <Widget>[
            TopContainer(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 40),
              width: width,
              height: 380,
              child: Column(
                children: <Widget>[
                  const MyBackButton(),
                  const SizedBox(
                    height: 30,
                  ),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        'Create new task',
                        style: TextStyle(
                            fontSize: 30.0, fontWeight: FontWeight.w700),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Container(
                      child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      const MyTextField(
                        label: 'Title',
                        icon: Icon(Icons.category_rounded),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: <Widget>[
                          Expanded(
                            child: MyTextField(
                              label: 'Date',
                              icon: downwardIcon,
                            ),
                          ),
                          HomePage.calendarIcon(),
                        ],
                      )
                    ],
                  ))
                ],
              ),
            ),
            Expanded(
                child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Expanded(
                          child: MyTextField(
                        label: 'Start Time',
                        icon: downwardIcon,
                      )),
                      const SizedBox(width: 40),
                      Expanded(
                        child: MyTextField(
                          label: 'End Time',
                          icon: downwardIcon,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  const MyTextField(
                    label: 'Description',
                    icon: Icon(Icons
                        .description), // Add the icon parameter with the desired icon
                    minLines: 3,
                    maxLines: 3,
                  ),
                  const SizedBox(height: 20),
                  Container(
                    alignment: Alignment.topLeft,
                    child: const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          'Category',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.black54,
                          ),
                        ),
                        Wrap(
                          crossAxisAlignment: WrapCrossAlignment.start,
                          //direction: Axis.vertical,
                          alignment: WrapAlignment.start,
                          verticalDirection: VerticalDirection.down,
                          runSpacing: 0,
                          //textDirection: TextDirection.rtl,
                          spacing: 10.0,
                          children: <Widget>[
                            Chip(
                              label: Text("Aireport"),
                              backgroundColor: LightColors.kRed,
                              labelStyle: TextStyle(color: Colors.white),
                            ),
                            Chip(
                              label: Text("Visite"),
                            ),
                            Chip(
                              label: Text("Booking"),
                            ),
                            Chip(
                              label: Text("NOTES"),
                            ),
                            Chip(
                              label: Text("Activity"),
                            ),
                            Chip(
                              label: Text("Transfert"),
                            ),
                          ],
                        ),
                      ],
                    ),
                  )
                ],
              ),
            )),
            SizedBox(
              height: 80,
              width: width,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Container(
                    alignment: Alignment.center,
                    margin: const EdgeInsets.fromLTRB(20, 10, 20, 20),
                    width: width - 40,
                    decoration: BoxDecoration(
                      color: LightColors.kBlue,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: const Text(
                      'Create Task',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                          fontSize: 18),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

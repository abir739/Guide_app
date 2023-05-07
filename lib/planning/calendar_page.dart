import 'package:flutter/material.dart';
import 'package:guide_app/planning/Add_tasks.dart';
import 'package:guide_app/planning/dates_list.dart';

import 'package:guide_app/theme/colors/light_colors.dart';
import 'package:guide_app/widgets/calendar_dates.dart';
import 'package:guide_app/widgets/task_container.dart';

import 'package:guide_app/widgets/back_button.dart';

class CalendarPage extends StatelessWidget {
  const CalendarPage({super.key});

  Widget _dashedText() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 15),
      child: const Text(
        '------------------------------------------',
        maxLines: 1,
        style:
            TextStyle(fontSize: 20.0, color: Colors.black12, letterSpacing: 5),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: LightColors.kLightYellow,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(
            20,
            20,
            20,
            0,
          ),
          child: Column(
            children: <Widget>[
              const MyBackButton(),
              const SizedBox(height: 30.0),
              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    const Text(
                      'Today',
                      style: TextStyle(
                          fontSize: 30.0, fontWeight: FontWeight.w700),
                    ),
                    Container(
                      height: 40.0,
                      width: 120,
                      decoration: BoxDecoration(
                        color: LightColors.kGreen,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const CreateNewTaskPage(),
                            ),
                          );
                        },
                        child: const Center(
                          child: Text(
                            'Add task',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w700,
                                fontSize: 16),
                          ),
                        ),
                      ),
                    ),
                  ]),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  RichText(
                    text: const TextSpan(
                      text: 'Productive Day, Abir ',
                      style: TextStyle(
                        fontSize: 18.0,
                        color: Colors.grey,
                        fontWeight: FontWeight.w400,
                      ),
                      children: [
                        WidgetSpan(
                          child: Padding(
                            padding: EdgeInsets.only(left: 4.0),
                            child: Text(
                              '😍',
                              style: TextStyle(fontSize: 18.0),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 30),
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Mai, 2023',
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20),
                ),
              ),
              const SizedBox(height: 20.0),
              SizedBox(
                height: 58.0,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: days.length,
                  itemBuilder: (BuildContext context, int index) {
                    return CalendarDates(
                      day: days[index],
                      date: dates[index],
                      dayColor: index == 0 ? LightColors.kRed : Colors.black54,
                      dateColor:
                          index == 0 ? LightColors.kRed : LightColors.kDarkBlue,
                    );
                  },
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 20.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Expanded(
                          flex: 1,
                          child: ListView.builder(
                            itemCount: time.length,
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (BuildContext context, int index) =>
                                Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 15.0),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  '${time[index]} ${time[index] > 8 ? 'PM' : 'AM'}',
                                  style: const TextStyle(
                                    fontSize: 16.0,
                                    color: Colors.black54,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        Expanded(
                          flex: 5,
                          child: ListView(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            children: <Widget>[
                              _dashedText(),
                              const TaskContainer(
                                title: 'Extra Activity',
                                subtitle:
                                    'Discuss with the colleagues about the future plan',
                                boxColor: LightColors.kLightYellow2,
                              ),
                              _dashedText(),
                              const TaskContainer(
                                title: 'Confirm reservations',
                                subtitle: 'Add Clients',
                                boxColor: LightColors.kLavender,
                              ),
                              const TaskContainer(
                                title: 'Call',
                                subtitle: 'Call to david',
                                boxColor: LightColors.kPalePink,
                              ),
                              const TaskContainer(
                                title: 'Travellers Meeting',
                                subtitle:
                                    'Discuss with clients for new task for the Trip prog',
                                boxColor: LightColors.kLightGreen,
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

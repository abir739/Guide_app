import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:country_list_picker/country_list_picker.dart';
import '../controller/onboarding_provider.dart';
import '../controller/settings_provider.dart';
import '../translation.dart';
import '../home_page.dart';
import '../app_data.dart';
export '../controller/onboarding_provider.dart';

class OnBoardingPage extends StatelessWidget {
  const OnBoardingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer2<OnboardingProvider, SettingsProvider>(
        builder: (context, boarding, settings, child) => Directionality(
              textDirection: settings.language.textDirection,
              child: SafeArea(
                child: Scaffold(
                  appBar: AppBar(elevation: 0, backgroundColor: Colors.transparent, actions: [
                    IconButton(
                      onPressed: () => settings.isDarkMode = !settings.isDarkMode,
                      icon: settings.isDarkMode
                          ? Icon(
                              Icons.sunny,
                              color: settings.darkprimarySwatch,
                            )
                          : Icon(
                              Icons.dark_mode,
                              color: settings.lightprimarySwatch,
                            ),
                    )
                  ]),
                  body: Column(
                    children: [
                      Expanded(
                        flex: 3,
                        child: PageView.builder(
                            itemCount: listOnboarding.length,
                            controller: boarding.pageController,
                            onPageChanged: (value) => boarding.currentOnboard = value,
                            itemBuilder: (context, index) {
                              return Container(
                                margin: const EdgeInsets.symmetric(horizontal: 30),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    // Image.asset(
                                    //   listOnboarding[index].image,
                                    //   width: 200,
                                    //   height: 250,
                                    // ),
                                    // const FlutterLogo(size: 250),
                                    Text(listOnboarding[index].title.tr,
                                        style: Theme.of(context)
                                            .textTheme
                                            .headlineSmall!
                                            .copyWith(fontSize: 21, fontWeight: FontWeight.bold)),
                                    const SizedBox(height: 20),
                                    Text(
                                      textAlign: TextAlign.center,
                                      listOnboarding[index].body.tr,
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleLarge!
                                          .copyWith(fontSize: 16),
                                    ),
                                  ],
                                ),
                              );
                            }),
                      ),
                      Expanded(
                          flex: 1,
                          child: Container(
                            padding: const EdgeInsets.all(30),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    ...List.generate(listOnboarding.length, (index) {
                                      return AnimatedContainer(
                                        duration: const Duration(milliseconds: 900),
                                        margin: const EdgeInsets.only(right: 10),
                                        width: (boarding.currentOnboard == index) ? 30 : 6,
                                        height: 5,
                                        decoration: BoxDecoration(
                                            color: Theme.of(context).colorScheme.primary,
                                            borderRadius: BorderRadius.circular(10)),
                                      );
                                    }),
                                  ],
                                ),
                                const SizedBox(height: 10),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    TextButton(
                                      onPressed: () {
                                        Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(builder: (context) => const HomePage()),
                                        );
                                      },
                                      child: Text("SKIP".tr,
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold, fontSize: 15)),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        if (boarding.currentOnboard >= listOnboarding.length - 1) {
                                          Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) => const HomePage()),
                                          );
                                        } else {
                                          boarding.nextOnboarding();
                                        }
                                      },
                                      child: boarding.currentOnboard < listOnboarding.length - 1
                                          ? Text("NEXT".tr,
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.bold, fontSize: 15))
                                          : Text("FINISH".tr,
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.bold, fontSize: 15)),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          )),
                      Directionality(
                        textDirection: TextDirection.ltr,
                        child: Container(
                          padding: const EdgeInsets.only(bottom: 20),
                          width: 200,
                          child: DropdownButtonFormField<Languages>(
                            alignment: Alignment.center,
                            decoration: const InputDecoration(
                              floatingLabelAlignment: FloatingLabelAlignment.center,
                              border: InputBorder.none,
                              prefixIcon: Icon(Icons.language),
                              hoverColor: Colors.transparent,
                              focusColor: Colors.transparent,
                            ),
                            focusColor: Colors.transparent,
                            value: settings.language,
                            items: Languages.values
                                .map<DropdownMenuItem<Languages>>(
                                  (e) => DropdownMenuItem<Languages>(
                                    value: e,
                                    child: Padding(
                                      padding: const EdgeInsets.all(0.0),
                                      child: Text(e.name,
                                          style: const TextStyle(fontFamily: "Quicksand"),
                                          overflow: TextOverflow.ellipsis),
                                    ),
                                  ),
                                )
                                .toList(),
                            onChanged: ((value) => settings.language = value!),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ));
  }
}

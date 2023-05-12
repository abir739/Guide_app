import 'package:flutter/material.dart';
import '../app_data.dart';

class OnboardingProvider extends ChangeNotifier {
  late PageController pageController;

  OnboardingProvider() {
    pageController = PageController();
  }

  int _currentOnboard = 0;
  int get currentOnboard => _currentOnboard;
  set currentOnboard(int value) {
    _currentOnboard = value;
    notifyListeners();
  }

  void nextOnboarding() {
    ++_currentOnboard;
    if (_currentOnboard >= listOnboarding.length) {
      currentOnboard = 0;
      pageController.animateToPage(currentOnboard,
          duration: const Duration(milliseconds: 900), curve: Curves.easeIn);
    } else {
      pageController.animateToPage(currentOnboard,
          duration: const Duration(milliseconds: 900), curve: Curves.easeIn);
    }

    // notifyListeners();
  }

  // void onPageChanged(int index) {
  //   currentPage = index;
  //   update();
  // }

  // void next(int total) {
  //   currentPage++;
  //   if (currentPage >= total) {
  //     Get.offAll(XLoginPage());
  //   } else {
  //     pageController.animateToPage(currentPage,
  //         duration: Duration(milliseconds: 900), curve: Curves.easeIn);
  //   }

  //   update();
  // }

}

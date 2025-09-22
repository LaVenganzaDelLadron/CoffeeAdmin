import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Onboardingcontroller extends GetxController {
  static Onboardingcontroller get instance => Get.find();

  final PageController pageController = PageController();
  final RxInt currentPage = 0.obs;

  void updatePageIndicator(int index) {
    currentPage.value = index;
  }

  void dotNavigationClicked(int index) {
    pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.ease,
    );
  }

  void nextPage() {
    if (currentPage.value < 4) {
      pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.ease,
      );
    }
  }

  void previousPage() {
    if (currentPage.value > 0) {
      pageController.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.ease,
      );
    }
  }

  void skipPage() {
    pageController.jumpToPage(4); // last index
  }
}

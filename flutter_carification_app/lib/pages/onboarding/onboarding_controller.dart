import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OnBoardingController extends GetxController {
  /// Observables
  final elapsed = 0.0.obs;

  /// Params
  final _pageAnimationDuration = const Duration(milliseconds: 500);
  final _pageAnimationCurve = Curves.easeInOut;
  int _pageIndex = 0;

  late PageController pageController;
  late Timer _timer;

  int get pageIndex => _pageIndex;

  @override
  void onInit() {
    super.onInit();
    _onInitControllers();
  }

  @override
  void onClose() {
    super.onClose();
    _onDisposeControllers();
  }

  void _onInitControllers() {
    pageController = PageController(initialPage: 0);
    _startTimer();
  }

  void _onDisposeControllers() {
    pageController.dispose();
    _timer.cancel();
  }

  void _startTimer() {
    elapsed.value = 0;
    _timer = Timer.periodic(const Duration(milliseconds: 50), (timer) {
      elapsed.value += 16 / 1000;
      elapsed.value = min(elapsed.value, 1);
      if (elapsed.value >= 1) {
        if (_pageIndex == 2) {
          _timer.cancel();
        } else if (_pageIndex < 2) {
          elapsed.value = 0;
          _timer.cancel();
          _pageIndex++;
          pageController.nextPage(
            duration: _pageAnimationDuration,
            curve: _pageAnimationCurve,
          );
        }
      }
    });
  }

  void onPageSlideLeft() {
    pageController.previousPage(
      duration: _pageAnimationDuration,
      curve: _pageAnimationCurve,
    );
  }

  void onPageSlideRight() {
    pageController.nextPage(
      duration: _pageAnimationDuration,
      curve: _pageAnimationCurve,
    );
  }

  void onPageChanged(int pageIndex) {
    _pageIndex = pageIndex;
    _timer.cancel();
    _startTimer();
  }

  Future<bool> onWillPop() async {
    elapsed.value = 0;

    if (_pageIndex > 0) {
      _pageIndex -= 1;
      elapsed.value = 0;
      pageController.previousPage(
        duration: _pageAnimationDuration,
        curve: _pageAnimationCurve,
      );
    }
    return false;
  }
}

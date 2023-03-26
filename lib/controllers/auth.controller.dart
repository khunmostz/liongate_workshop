import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class AuthController extends GetxController {
  PageController pageController = PageController(
    initialPage: 0,
  );

  double pageValue = 0.0;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    pageController..addListener(pageListener);
  }

  pageListener() {
    print(pageController.page);
    pageValue = pageController.page!;
    update();
  }
}

import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class QrcodeController extends GetxController with GetTickerProviderStateMixin {
  late AnimationController animationController;
  double circleOffset = 0.0;
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();

    animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    )
      ..forward()
      ..addListener(circlelistener);
  }

  circlelistener() {
    circleOffset = animationController.value;
    // print(circleOffset);
    update();
  }
}

import 'package:get/get.dart';
import 'package:flutter/material.dart';

import '../../profile/presentation/profile_screen.dart';

class BottomNavController extends GetxController {
  int selectedScreen = 0;

  late List<Widget> screenList;

  BottomNavController();

  @override
  void onInit() {
    screenList = [
      Text("Hello"),
      Text("World"),
      Text("World"),
      Text("World"),
      Profile(),
    ];

    super.onInit();
  }

  // @override
  // void onClose() {
  //   super.onClose();
  // }

  void setSelectedScreen(int value) {
    selectedScreen = value;
    update();
  }
}

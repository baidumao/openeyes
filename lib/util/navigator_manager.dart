import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NavigatorManager{
  static to(Widget page, {bool rebuildRoutes = false}){
    Get.to(page);
  }
  static back() {
    Get.back();
  }

}
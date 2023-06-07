import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeLogic extends GetxController {
  var selectIndex = 0.obs;
  final PageController pageController = PageController();
  jump(int i){
    selectIndex.value = i;
    pageController.jumpToPage(i);
  }
}

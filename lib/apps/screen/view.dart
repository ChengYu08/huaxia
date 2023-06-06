import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:huaxia/config/config.dart';

import 'logic.dart';

class ScreenPage extends StatefulWidget {
  @override
  State<ScreenPage> createState() => _ScreenPageState();
}

class _ScreenPageState extends State<ScreenPage> {
  final logic = Get.find<ScreenLogic>();
@override
  void initState() {
  Future.delayed(1000.milliseconds,(){
    Get.offAndToNamed(Routers.home);
  });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: CircularProgressIndicator()),
    );
  }
}

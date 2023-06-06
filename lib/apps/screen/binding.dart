import 'package:get/get.dart';

import 'logic.dart';

class ScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ScreenLogic());
  }
}

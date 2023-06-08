import 'package:get/get.dart';

import 'logic.dart';

class HomeSentenceBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => HomeSentenceLogic());
  }
}

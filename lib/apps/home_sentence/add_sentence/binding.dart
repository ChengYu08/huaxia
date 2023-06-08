import 'package:get/get.dart';

import 'logic.dart';

class AddSentenceBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AddSentenceLogic());
  }
}

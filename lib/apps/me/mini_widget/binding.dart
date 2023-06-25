import 'package:get/get.dart';

import 'logic.dart';

class MiniWidgetBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => MiniWidgetLogic());
  }
}

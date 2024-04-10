import 'package:get/get.dart';

import 'logic.dart';

class Me_read_historyBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => Me_read_historyLogic());
  }
}

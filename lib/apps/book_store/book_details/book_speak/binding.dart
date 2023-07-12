import 'package:get/get.dart';

import 'logic.dart';

class BookSpeakBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => BookSpeakLogic());
  }
}

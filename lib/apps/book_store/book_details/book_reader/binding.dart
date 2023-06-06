import 'package:get/get.dart';

import 'logic.dart';

class BookReaderBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => BookReaderLogic());
  }
}

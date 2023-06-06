import 'package:get/get.dart';

import 'logic.dart';

class BookStoreBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => BookStoreLogic());
  }
}

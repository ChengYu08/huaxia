import 'package:get/get.dart';

import 'logic.dart';

class BookSearchBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => BookSearchLogic());
  }
}

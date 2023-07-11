import 'package:get/get.dart';
import 'package:huaxia/apps/book_store/my_book_logic.dart';

import 'logic.dart';

class BookStoreBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => BookStoreLogic());
    Get.lazyPut(() => MyBookLogic());
  }
}

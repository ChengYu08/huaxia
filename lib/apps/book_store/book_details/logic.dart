import 'package:get/get.dart';
import 'package:huaxia/apps/book_store/model/BookList.dart';

class BookDetailsLogic extends GetxController {

  late BookList book;
@override
  void onInit() {
      book = Get.arguments as BookList;
    super.onInit();
  }
}

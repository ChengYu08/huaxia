import 'package:get/get.dart';
import 'package:huaxia/apps/book_store/logic.dart';
import 'package:huaxia/apps/book_store/model/BookList.dart';

import 'logic.dart';

class BookSpeakBinding extends Bindings {
  @override
  void dependencies() {
    final tag = Get. arguments as BookList;

  }
}

import 'package:get/get.dart';
import 'package:huaxia/apps/book_store/model/BookList.dart';

import '../../../config/config.dart';

class BookDetailsLogic extends GetxController {

  var  book = BookList().obs;
@override
  void onInit() {
      book.value = Get.arguments as BookList;
    super.onInit();
  }
  void addBook() {
    final c=AppLoading.loading();
    Api.book_shelf_add('${book.value.bookId}').then((value){
      c();
      if(value.success){
        AppToast.toast('加入成功');
        book.update((val) {
          val?.isJoin = 1;
        });
      }else{
        AppToast.toast(value.message);
      }
    }).catchError((e){
      AppToast.toast(e.message);
      c();
    });
  }
}


import 'package:bot_toast/bot_toast.dart';
import 'package:get/get.dart';
import 'package:huaxia/config/config.dart';

import 'model/ShelfBook.dart';

class MyBookLogic  extends GetxController {
  late Future<ApiResult<List<ShelfBook>>>  book_shelf;
  var selectBook=0.obs;
  RxList<ShelfBook> selectBooksOBX =RxList([]);

  @override
  void onInit() {
    book_shelf= Api.book_shelf();
    super.onInit();
  }

  void delect() {
    if(selectBooksOBX.isNotEmpty){
      final c = AppLoading.loading();
      String ids='';
      selectBooksOBX.forEach((element) {
        ids+='${element.bookId!},';
      });
    Api.book_shelf_delete(ids: ids).then((value) {
      c();
      if(value.success){
        upData();
        selectBook.value = 0;
        selectBooksOBX.clear();
        AppToast.toast('删除成功');
      }else{
        AppToast.toast('删除失败：${value.message}');
      }
    }).catchError((e){
      c();
      final error = e as ApiResult;
      AppToast.toast('删除失败：${error.message}');
    });
    }else{
      AppToast.toast('当前没有选择书本');
    }
  }
  upData(){
    book_shelf= Api.book_shelf();
    update();
  }
}
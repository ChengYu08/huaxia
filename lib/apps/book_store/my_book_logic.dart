
import 'package:bot_toast/bot_toast.dart';
import 'package:get/get.dart';
import 'package:huaxia/config/config.dart';

import 'model/ShelfBook.dart';

class MyBookLogic  extends GetxController {

  var selectBook=0.obs;
  RxList<ShelfBook> selectBooksOBX =RxList([]);

  RxList<ShelfBook> allBooksOBX =RxList([]);

  @override
  void onInit() {
    getData();
    super.onInit();
  }


  void delect() {
    if(selectBooksOBX.isNotEmpty){
      final c = AppLoading.loading();
      String ids='';
      selectBooksOBX.forEach((element) {
        ids+='${element.bookId!},';
        allBooksOBX.removeWhere((e) => e.bookId==element.bookId);
      });
    Api.book_shelf_delete(ids: ids).then((value) {
      c();
      if(value.success){
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

  void getData() {
    Api.book_shelf().then((value) {
      allBooksOBX.value = value.data??[];
    });
  }

}
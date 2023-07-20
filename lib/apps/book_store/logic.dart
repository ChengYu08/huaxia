import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:huaxia/config/config.dart';
import 'package:huaxia/config/http/api_service.dart';


import 'model/BookList.dart';

class BookStoreLogic extends GetxController {
  ///
  var changedBook =0.obs;

   RxMap<int,Future<ApiResult<List<BookList>>>>  bookList=RxMap();
  @override
  void onInit() {
    intBookList(0);
    super.onInit();
  }

  intBookList(int index)async{
    if(bookList.containsKey(index)){
    final f =await  bookList[index];
      if(f?.failed==true){
        int typeId = index+1;
        bookList[index]=Api.book_list('$typeId');
      }
    }

    if((!bookList.containsKey(index) )|| (bookList[index]==null)){
      int typeId = index+1;

        bookList[index]=Api.book_list('$typeId');
    }
  }

}



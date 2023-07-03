import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:huaxia/config/config.dart';
import 'package:huaxia/config/http/api_service.dart';


import 'model/BookList.dart';

class BookStoreLogic extends GetxController {
  ///
  var changedBook =0.obs;

  var selectBook=0.obs;

  RxList<Book> selectBooksOBX =RxList([]);
  final List<Book> books =[
    Book(title: '论语'),
    Book(title: '论语1'),
    Book(title: '论语2'),
    Book(title: '论语3'),
    Book(title: '论语4'),
    Book(title: '论语5'),
    Book(title: '论语6'),
    Book(title: '论7'),
    Book(title: '论语8'),
    Book(title: '论语9'),
    Book(title: '论语10'),
    Book(title: '论语11'),
    Book(title: '论语12'),
  ];

   RxMap<int,Future<ApiResult<List<BookList>>>>  bookList=RxMap();
  @override
  void onInit() {
    intBookList(0);
    super.onInit();
  }

  intBookList(int index){
    if((!bookList.containsKey(index) )|| (bookList[index]==null)){
      int typeId = index+1;
        bookList[index]=Api.book_list('$typeId');
    }
  }

}


class Book{
  final String title;
  final ValueNotifier<bool> selectBook=ValueNotifier(false);
  Book( {required this.title, });
}
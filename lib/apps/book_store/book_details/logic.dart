import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:huaxia/application/tts/tts_app.dart';
import 'package:huaxia/apps/book_store/model/BookList.dart';

import '../../../config/config.dart';
import '../model/Catalogue.dart';
import 'book_reader/data/book_chapter.dart';

class BookDetailsLogic extends GetxController {

  var  book = BookList().obs;
  late Future<ApiResult<List<Catalogue>>>   bookCatalogue;
  late int bookId;
@override
  void onInit() {
  bookId = int.parse('${Get.parameters['bookId']}');
      if(Get.arguments is BookList){
        book.value = Get.arguments as BookList;
      }else{
        Api.book_info(bookId).then((value) {
          if(value.success){
            book.value = value.data!;
          }
        });
      }


      bookCatalogue= Api.book_Catalogue(bookId);
    super.onInit();
  }

  void goBook(List<Catalogue> catalogue) {
    final List<BookChapter> b = catalogue
        .map((catalogue) => BookChapter(
        title: catalogue.secondCatalogue,
        bookId: book.value.bookId,
        paragraphId: catalogue.bookCatalogueId!))
        .toList();
    Get.toNamed(Routers.bookReaderPage, arguments: b, parameters: {
      'bookId': '${book.value.bookId}',
      'title': '${book.value.name}',
      'author': '${book.value.author}',
      'isJoin': '${book.value.isJoin}',
      'index': '0',
    });
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

  void goSpeak(List<Catalogue> catalogue,BuildContext context) {
    final List<BookChapter> bookChapter = catalogue
        .map((catalogue) => BookChapter(
        title: catalogue.secondCatalogue,
        bookId: book.value.bookId,
        paragraphId: catalogue.bookCatalogueId!))
        .toList();
    final tts = Get.find<TTSApp>();
    tts.openSpeakPage(context, bookChapter:bookChapter,
        tag: '${book.value.bookId}', bookId: book.value.bookId!,
        title: book.value.name!, author: book.value.author!);
  }
}

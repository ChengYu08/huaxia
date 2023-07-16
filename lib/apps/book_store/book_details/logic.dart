import 'package:get/get.dart';
import 'package:huaxia/apps/book_store/model/BookList.dart';

import '../../../config/config.dart';
import '../model/Catalogue.dart';
import 'book_reader/data/book_chapter.dart';

class BookDetailsLogic extends GetxController {

  var  book = BookList().obs;
  late Future<ApiResult<List<Catalogue>>>   bookCatalogue;
@override
  void onInit() {
      book.value = Get.arguments as BookList;
      bookCatalogue= Api.book_Catalogue(book.value.bookId!);
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
}

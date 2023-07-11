import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:huaxia/apps/book_store/model/Catalogue.dart';
import 'package:huaxia/apps/book_store/model/Chapters.dart';
import 'package:huaxia/config/config.dart';
import 'package:huaxia/widgets/custom_selectable_text/custom_selectable_text.dart';
import 'package:screen_brightness/screen_brightness.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

import '../../model/BookList.dart';

class BookReaderLogic extends GetxController {
  var showFistPop = true.obs;
  late List<CustomSelectableTextItem> customSelectableTextItems;

// final PageController controller = PageController();
  var menuBarShow = false.obs;
  var menuBottomShow = false.obs;
  var currentIndex = 0.obs;
  var m1 = false.obs;
  var m2 = false.obs;
  var m3 = false.obs;
  var m4 = false.obs;

  var translateText = 0.obs;

  late Future<double> brightness;
  List<List<String>> len = [];
  late Future<List<List<String>>> f;

  var  book = BookList().obs;

  RxList<Catalogue> catalogues = RxList([]);
  RxMap<Catalogue, Future<ApiResult<Chapters>>> cc = RxMap();

  final ItemScrollController itemScrollController = ItemScrollController();
  final ScrollOffsetController scrollOffsetController = ScrollOffsetController();
  final ItemPositionsListener itemPositionsListener = ItemPositionsListener
      .create();
  final ScrollOffsetListener scrollOffsetListener = ScrollOffsetListener
      .create();

  @override
  void onInit() {
    book.value = Get.arguments as BookList;
    super.onInit();
    initBook();
    brightness = ScreenBrightness().system;

    itemPositionsListener.itemPositions.addListener(() {

    });
    init();
  }

  void initBook() {
    Api.book_Catalogue(book.value.bookId!).then((value) {
      if (value.success) {
        catalogues.value = value.data ?? [];
        if (catalogues.first.bookCatalogueId != null) {
          cc[catalogues.first] = Api.book_Chapters(bookId: book.value.bookId!,
              chaptersId: catalogues.first.bookCatalogueId!);
        }
      } else {
        AppToast.toast(value.message);
        Get.back();
      }
    });
  }

  toCuttex(int index) {
    getBook_Chapters(index);
    itemScrollController.jumpTo(index: index);
  }


  Future<ApiResult<Chapters>>  getBook_Chapters(int index) {
    final cl = catalogues[index];
    if (cc.containsKey(cl) && cc[cl]!=null) {
      return cc[cl]!;
    } else {
      final f = Api.book_Chapters(
          bookId: book.value.bookId!, chaptersId: cl.bookCatalogueId!);
      cc[cl] = f;
      return f;
    }
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

      c();
    });
  }


  init() {
    customSelectableTextItems = [
      CustomSelectableTextItem.icon(
          icon: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                Imgs.ic_text_copy,
                width: 18,
                height: 18,
                color: Colors.white,
              ),
              const Text(
                '复制',
                style: TextStyle(color: Colors.white, fontSize: 10),
              )
            ],
          ),
          controlType: SelectionControlType.copy,
          onPressed: (text, d) {
            AppToast.toast('复制成功');
          }),
      CustomSelectableTextItem.icon(
          icon: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                Imgs.ic_share,
                width: 18,
                height: 18,
                color: Colors.white,
              ),
              const Text(
                '分享',
                style: TextStyle(color: Colors.white, fontSize: 10),
              )
            ],
          ),
          controlType: SelectionControlType.other,
          onPressed: (text, d) {
            AppToast.toast('正在开发中...');
          }),
      CustomSelectableTextItem.icon(
          icon: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                Imgs.ic_text_line,
                width: 18,
                height: 18,
                color: Colors.white,
              ),
              const Text(
                '划线',
                style: TextStyle(color: Colors.white, fontSize: 10),
              )
            ],
          ),
          controlType: SelectionControlType.other,
          onPressed: (text, textSelection) {
            String changed = '<u>$text</u>';
          }),
      CustomSelectableTextItem.icon(
          icon: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                Imgs.ic_text_idea,
                width: 18,
                height: 18,
                color: Colors.white,
              ),
              const Text(
                '想法',
                style: TextStyle(color: Colors.white, fontSize: 10),
              )
            ],
          ),
          controlType: SelectionControlType.other,
          onPressed: (text, d) {
            AppToast.toast('正在开发中...');
          }),
      CustomSelectableTextItem.icon(
          icon: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                Imgs.ic_text_idea,
                width: 18,
                height: 18,
                color: Colors.white,
              ),
              const Text(
                '查询',
                style: TextStyle(color: Colors.white, fontSize: 10),
              )
            ],
          ),
          controlType: SelectionControlType.other,
          onPressed: (text, d) {
            AppToast.toast('正在开发中...');
          }),
    ];
  }

  openMenuList(int index) {
    currentIndex.value = index;

    switch (index) {
      case 0:
        m1.value = !m1.value;
        menuBarShow.value = !m1.value;
        m2.value = false;
        m3.value = false;
        m4.value = false;
        break;
      case 1:
        m2.value = !m2.value;
        menuBarShow.value = !m2.value;
        m1.value = false;
        m3.value = false;
        m4.value = false;
        break;
      case 2:
        m3.value = !m3.value;
        menuBarShow.value = !m3.value;
        m1.value = false;
        m2.value = false;
        m4.value = false;
        break;
      case 3:
        m4.value = !m4.value;
        menuBarShow.value = !m4.value;
        m2.value = false;
        m3.value = false;
        m1.value = false;
        break;
    }
  }

  void onTapMenu() {
    menuBottomShow.value = !menuBottomShow.value;
    menuBarShow.value = menuBottomShow.value;
    m1.value = false;
    m2.value = false;
    m3.value = false;
    m4.value = false;
  }


}

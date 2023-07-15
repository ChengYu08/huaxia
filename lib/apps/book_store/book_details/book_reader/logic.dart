import 'package:bot_toast/bot_toast.dart';
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
enum BookLoadingState {
  loading,
  error,
  success,
}
class BookReaderLogic extends GetxController {
  var showFistPop = true.obs;

  var menuBarShow = false.obs;
  var menuBottomShow = false.obs;

  var m1 = false.obs;
  var m2 = false.obs;
  var m3 = false.obs;
  var m4 = false.obs;

  var translateText = 0.obs;

  late Future<double> brightness;

  late List<CustomSelectableTextItem> customSelectableTextItems;

  RxMap<Catalogue, Chapters> ccMap = RxMap();
  final ItemScrollController itemScrollController = ItemScrollController();
  final ScrollOffsetController scrollOffsetController =
      ScrollOffsetController();
  final ItemPositionsListener itemPositionsListener =
      ItemPositionsListener.create();
  final ScrollOffsetListener scrollOffsetListener =
      ScrollOffsetListener.create();

  RxList<Catalogue> catalogues = RxList([]);
  late int bookId;
  var currentIndex = 0.obs;
  var isJoin = 0.obs;
  String title = '';

  @override
  void onInit() {
    initBook();
    super.onInit();

    brightness = ScreenBrightness().system;

    itemPositionsListener.itemPositions.addListener(_changeListener);
    init();
  }

  @override
  void onClose() {
    itemPositionsListener.itemPositions.removeListener(_changeListener);
    super.onClose();
  }

  void initBook() {
    final List<Catalogue> getCatalogue = Get.arguments as List<Catalogue>;
    bookId = int.parse('${Get.parameters['bookId']}');
    currentIndex.value = int.parse('${Get.parameters['index'] ?? 0}');
    isJoin.value = int.parse('${Get.parameters['isJoin'] ?? 0}');
    title = Get.parameters['title'] ?? '';
    catalogues.value = getCatalogue!;
      if(catalogues.isNotEmpty){
        getBook_Chapters(0);
        if(catalogues.length>=2){
          getBook_Chapters(1);
        }
      }
  }

  toCurrentChapters(int index) {
    currentIndex.value = index;
    getBook_Chapters(currentIndex.value);
    itemScrollController.jumpTo(index: currentIndex.value);
  }

  getBook_Chapters(int index) {
    final cl = catalogues[index];
    try{
      if (ccMap.containsKey(cl)) {
        if(ccMap[cl]==null){
           addBookChapters(cl);
        }
      }else{
         addBookChapters(cl);
      }
    }catch( e){
      final error = e as ApiResult;
      cl.error = error.message;
      cl.bookLoadingState.value = BookLoadingState.error;
    }
  }

  Future<void> addBookChapters(Catalogue cl) async {
      cl.bookLoadingState.value = BookLoadingState.loading;
    final chapter=  await   Api.book_Chapters(bookId: bookId, chaptersId: cl.bookCatalogueId!);
      if(chapter.success){
        ccMap[cl] = chapter.data!;
        cl.bookLoadingState.value = BookLoadingState.success;
      }else{
        cl.error = chapter.message;
        cl.bookLoadingState.value = BookLoadingState.error;
      }
  }


  void addBook() {
    final c = AppLoading.loading();
    Api.book_shelf_add('$bookId').then((value) {
      c();
      if (value.success) {
        AppToast.toast('加入成功');
        isJoin.value = 1;
      } else {
        AppToast.toast(value.message);
      }
    }).catchError((e) {
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

  void _changeListener() {
    currentIndex.value = itemPositionsListener.itemPositions.value.first.index;
    getBook_Chapters(currentIndex.value);
  }
}

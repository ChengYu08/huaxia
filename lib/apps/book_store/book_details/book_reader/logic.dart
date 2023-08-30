import 'dart:ui';

import 'package:bot_toast/bot_toast.dart';
import 'package:flustars_flutter3/flustars_flutter3.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'package:get/get.dart';
import 'package:huaxia/apps/book_store/book_details/book_reader/data/book_paragraph.dart';
import 'package:huaxia/apps/book_store/model/Catalogue.dart';
import 'package:huaxia/apps/book_store/model/Chapters.dart';
import 'package:huaxia/apps/book_store/model/ShelfBook.dart';
import 'package:huaxia/apps/book_store/my_book_logic.dart';
import 'package:huaxia/apps/login/logic.dart';
import 'package:huaxia/apps/login/model/user_model.dart';
import 'package:huaxia/config/config.dart';
import 'package:huaxia/tools/RepaintBoundaryUtils.dart';
import 'package:huaxia/tools/wx_share.dart';
import 'package:huaxia/widgets/custom_selectable_text/custom_selectable_text.dart';
import 'package:screen_brightness/screen_brightness.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:html/dom.dart' as dom;
import 'package:wechat_kit/wechat_kit.dart';
import '../../model/BookList.dart';
import 'data/book_chapter.dart';
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

  RxList<BookChapter> bookChapter =  RxList([]);

  final GlobalKey boundaryKey = GlobalKey();

  final ItemScrollController itemScrollController = ItemScrollController();
  final ScrollOffsetController scrollOffsetController =
      ScrollOffsetController();
  final ItemPositionsListener itemPositionsListener =
      ItemPositionsListener.create();
  final ScrollOffsetListener scrollOffsetListener =
      ScrollOffsetListener.create();

  late LoginLogic user;
  late int bookId;
  var currentIndex = 0.obs;
  var bottomNavigationBarCurrentIndex = 0.obs;
  var isJoin = 0.obs;
  String title = '';

  @override
  void onInit() {
    initBook();
    super.onInit();
    user = Get.find<LoginLogic>();
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
    bookChapter.value = Get.arguments as List<BookChapter>;
    bookId = int.parse('${Get.parameters['bookId']}');
    currentIndex.value = int.parse('${Get.parameters['index'] ?? 0}');
    isJoin.value = int.parse('${Get.parameters['isJoin'] ?? 0}');
    title = Get.parameters['title'] ?? '';
    if(bookChapter.length>=3){
      List.generate(3, (index) => findBookChapter(index));
    }
  }

  share(String  text){
    Get.bottomSheet(Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
          RepaintBoundary(
            key: boundaryKey,
            child: Container(
              margin: const EdgeInsets.all(15),
              padding: const EdgeInsets.only(left: 34,right: 34,top: 38,bottom: 18),
              width: double.infinity,
              decoration: BoxDecoration(
                image: DecorationImage(image: AssetImage(Imgs.bg_share),fit: BoxFit.fill)
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  StreamBuilder<UserModel>(
                      stream: user.userStream,
                    initialData: user.initUserModel,
                    builder: (context, snapshot) {
                      return Row(
                        children: [
                          ImgNet.net('${snapshot.data?.user?.avatar}',width: 40,height: 40,
                          boxShape: BoxShape.circle,
                            border: Border.all(color: Colors.white,width: 1)
                          ),
                          Column(
                            children: [
                              Row(
                                children: [
                                  Text(snapshot.data?.user?.nickName??'',style: Get.textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.w500) ,),
                                  if(snapshot.data?.user?.vip==1)
                                  Image.asset(Imgs.ic_vip,width: 24,height: 24,)
                                ],
                              ),
                              Text('隐藏个人信息',style: Get.textTheme.labelLarge ,),
                            ],
                          ),

                        ],
                      );
                    }
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Text('摘录于${DateUtil.formatDate(DateTime.now(),format: DateFormats.y_mo_d_h_m)}',style: Get.textTheme.labelLarge ,),
                  ),
                  Image.asset(Imgs.ic_quotes,width: 24,height: 24,),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Text(text,style: Get.textTheme.bodyLarge ,),
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Padding(
                      padding: const EdgeInsets.all(15),
                      child: Text('-《$title》',style: Get.textTheme.labelLarge,),
                    ),
                  ),

                  Text('我的感悟',style: Get.textTheme.bodyMedium,),
                  SizedBox(
                    height: 200,
                    width: double.infinity,
                    child: TextField(
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        isDense: true,
                        hintText:'畅想所谈吧～',
                        hintStyle: Get.textTheme.labelMedium
                      ),
                    ),
                  ),

                ],
              ),
            ),
          ),
        const SizedBox(height: 20,),
        Container(
          width: double.infinity,
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(topRight: Radius.circular(20),topLeft: Radius.circular(20)),
            color: Colors.white,
          ),
          child: Column(
            children: [
              const SizedBox(height: 11,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  GestureDetector(
                    onTap: ()async{
                      WxShare.shareWxSession(boundaryKey, description: text);
                    },
                    child: Column(
                      children: [
                        Image.asset(Imgs.ic_share_wx,width: 48,height: 48,),
                        const SizedBox(height: 6,),
                        Text('微信',style: Get.textTheme.labelLarge,)
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: (){
                      WxShare.shareWxTimeline(boundaryKey, description: text);
                    },
                    child: Column(
                      children: [
                        Image.asset(Imgs.ic_share_wx_2,width: 48,height: 48,),
                        const SizedBox(height: 6,),
                        Text('微信朋友圈',style: Get.textTheme.labelLarge,)
                      ],
                    ),
                  ),
                ],
              ),
            const Divider(),
              TextButton(onPressed: (){
                Get.back();
              }, child: Text('关闭'))
            ],
          ),
        )
      ],
    ),isScrollControlled: true);
  }

  toCurrentChapters(int index) {
    currentIndex.value = index;
    findBookChapter(currentIndex.value);
    itemScrollController.jumpTo(index: currentIndex.value);
  }

    Future<BookChapter>   findBookChapter(int index) async{
    BookChapter chapter= bookChapter[index];
    try{
      if (chapter.bookParagraph==null) {
       final paragraph = await addBookChapters(chapter);
          if(paragraph!=null){
            chapter.bookParagraph = paragraph;
          }
      }
      return chapter;
    }catch( e){
      final error = e as ApiResult;
     chapter.error = error.message;
     chapter.bookLoadingState.value = BookLoadingState.error;
     return  chapter;
    }
  }

  Future<BookParagraph? > addBookChapters(BookChapter  bookChapter) async {
    bookChapter.bookLoadingState.value = BookLoadingState.loading;
    try{
      final chapter=  await Api.book_Chapters(bookId: bookId, chaptersId: bookChapter.paragraphId);
      if(chapter.success){

        BookParagraph bookParagraph = BookParagraph(paragraphId: bookChapter.paragraphId,
            originalArticle: chapter.data!.cont,
            translationArticle: chapter.data!.translation,
            explinArticle: chapter.data!.chapters
        );

        bookChapter.bookLoadingState.value = BookLoadingState.success;
        return bookParagraph;
      }else{
        bookChapter.error = chapter.message;
        bookChapter.bookLoadingState.value = BookLoadingState.error;
        return null;
      }
    }catch(e){
      final error = e as ApiResult;
      bookChapter.error = error.message;
      bookChapter.bookLoadingState.value = BookLoadingState.error;
      return null;
    }

  }


  void addBook() {
    final c = AppLoading.loading();
    Api.book_shelf_add('$bookId').then((value) {
      c();
      if (value.success) {
        AppToast.toast('加入成功');
        final myBook = Get.find<MyBookLogic>();
        myBook.getData();
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
            share(text);
            //AppToast.toast('正在开发中...');
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
              Get.log("==onPressed=$text");
              String selectText = '<u>$text</u>';
              final book =  bookChapter[currentIndex.value];
              if(book.bookParagraph!=null){
                book.bookParagraph!.originalArticle =
                    book.bookParagraph!.originalArticle!.replaceFirst(text, selectText,textSelection.start);
                bookChapter.refresh();
              }


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
    bottomNavigationBarCurrentIndex.value = index;
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

  int _recordIndex = 0;
  void _changeListener() {
    final int itemIndex =  itemPositionsListener.itemPositions.value.first.index;
        if(_recordIndex!=itemIndex){
          _recordIndex=itemIndex;
          currentIndex.value = itemIndex;
          if(currentIndex.value<=bookChapter.length){
            List.generate(3, (index) {
              final findIndex=itemIndex+index;
              if(findIndex<bookChapter.length){
                findBookChapter(findIndex);
              }
            });
          }
        }

  }
}

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:huaxia/application/book_config/app_book_config.dart';
import 'package:huaxia/apps/book_store/book_details/book_reader/ui/book_appbar_menu.dart';
import 'package:huaxia/apps/book_store/book_details/book_reader/ui/book_bottom_menu.dart';
import 'package:huaxia/apps/book_store/book_details/book_reader/ui/book_menu.dart';
import 'package:huaxia/apps/book_store/book_details/book_reader/ui/book_screen_brightness.dart';
import 'package:huaxia/apps/book_store/book_details/book_reader/ui/book_text_style_menu.dart';
import 'package:huaxia/apps/book_store/book_details/book_reader/ui/book_translate_text.dart';
import 'package:huaxia/apps/book_store/book_details/book_reader/ui/introduce_menu.dart';
import 'package:huaxia/apps/book_store/model/Chapters.dart';

import 'package:huaxia/widgets/flutter_html/flutter_html.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import '../../../../config/http/api_service.dart';
import '../../model/BookList.dart';
import 'logic.dart';

class BookReaderPage extends StatefulWidget {
  const BookReaderPage({super.key});

  @override
  State<BookReaderPage> createState() => _BookReaderPageState();
}

class _BookReaderPageState extends State<BookReaderPage> {
   late BookReaderLogic logic ;
  late AppBookConfig appBookConfig ;
  String canUp='1';
  String tag='';
  @override
  void initState() {
    appBookConfig = Get.find<AppBookConfig>();

    final book = Get.arguments as BookList;
    canUp = Get.parameters['canUp']??'1';
    tag ='${ book.bookId}';
    if(Get.isRegistered<BookReaderLogic>(tag: tag)){
      logic = Get.find<BookReaderLogic>(tag:tag);
    }else{
      logic = Get.put<BookReaderLogic>(BookReaderLogic(),tag: tag);
    }
    super.initState();
  }

  @override
  void dispose() {
    if(canUp=="1"){
      Get.delete<BookReaderLogic>(tag: tag);
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BookBottomMenu(
        bookReaderLogic: logic,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      floatingActionButton: BookTranslateText(bookReaderLogic: logic,),
      body: Stack(
        fit: StackFit.expand,
        clipBehavior: Clip.none,
        children: [
          Positioned.fill(
            child: Container(
                width: Get.width,
                height: Get.height,
                decoration: const BoxDecoration(color: Colors.white),
                child: Obx(() {
                  return ScrollablePositionedList.builder(
                    itemCount: logic.catalogues.length,
                    itemScrollController: logic.itemScrollController,
                    scrollOffsetController: logic.scrollOffsetController,
                    itemPositionsListener: logic.itemPositionsListener,
                    scrollOffsetListener: logic.scrollOffsetListener,
                    itemBuilder: (BuildContext context, int index) {
                      final catalogue = logic.catalogues[index];
                      if (logic.catalogues.isEmpty) {
                        return const Center(child: Text('加载中'));
                      }
                      String title = '${catalogue
                          .firstCatalogue??''} ${catalogue
                          .secondCatalogue??'第${index+1}章'}';
                      return ValueListenableBuilder(
                          valueListenable: appBookConfig.bookConfigVN,
                          builder: (BuildContext context, bookConfig,
                              Widget? child) {
                            return AnimatedContainer(
                              duration: 300.milliseconds,
                              padding: EdgeInsets.symmetric(
                                  horizontal: bookConfig.padding),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(height: Get.statusBarHeight,),
                                  Padding(
                                    padding:
                                    const EdgeInsets.only(bottom: 20),
                                    child: Text(
                                      title,
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 4 + bookConfig.textSize,
                                          fontWeight: FontWeight.bold
                                      ),
                                    ),
                                  ),
                                  ValueListenableBuilder(valueListenable: catalogue.bookLoadingState,
                                    builder: (BuildContext context, BookLoadingState value, Widget? child) {
                                      if(value ==BookLoadingState.success){
                                        final Chapters data = logic.ccMap[catalogue]!;
                                        return Obx(() {
                                          String html;
                                          if(logic.translateText.value==0){
                                            html = data.cont??'当前无数据，请联系开发人员';
                                          }else if(logic.translateText.value ==1){
                                            html = data.translation??'当前无数据，请联系开发人员';
                                          }else{
                                            html = data.chapters??'当前无数据，请联系开发人员';
                                          }
                                          return SelectableHtml(
                                            data: html,
                                            items:
                                            logic.customSelectableTextItems,
                                            style: {
                                              'p': Style(
                                                  fontSize: FontSize(
                                                      bookConfig.textSize),
                                                  lineHeight: LineHeight(
                                                      bookConfig.textHight))
                                            },
                                            onSingleTapUp:
                                                (TapDragUpDetails tap) {
                                              final dx = tap.localPosition.dx;
                                              final cW = Get.width / 3;
                                              if (dx > (2 * cW)) {
                                                print("下一页");
                                                // logic.controller.nextPage(
                                                //     duration: 300.milliseconds,
                                                //     curve: Curves.linear);
                                              } else if (dx >= cW &&
                                                  dx <= (cW * 2)) {
                                                print("菜单");
                                                logic.onTapMenu();
                                              } else if (dx <= cW) {
                                                // logic.controller.previousPage(
                                                //     duration: 300.milliseconds,
                                                //     curve: Curves.linear);
                                                print("上一页");
                                              } else {
                                                // logic.controller.nextPage(
                                                //     duration: 300.milliseconds,
                                                //     curve: Curves.linear);
                                                print("下一页");
                                              }
                                            },
                                            onSelectionChanged:
                                                (TextSelection selection,
                                                SelectionChangedCause?
                                                cause) {},
                                          );
                                        });
                                      }else if(value ==BookLoadingState.loading){
                                        return const Expanded(child: Center(child: CircularProgressIndicator()));
                                      }else if(value == BookLoadingState.error){
                                          if(catalogue.error!=null){
                                            return  Expanded(child: Center(child:Text('${catalogue.error}')));
                                          }else{
                                            return  const Expanded(child: Center(child:Text('未知错误')));
                                          }
                                      }else{
                                        return  const SizedBox();
                                      }


                                    },),
                                ],
                              ),
                            );
                          });
                    },
                  );
                })),
          ),
          // BookBottomMenu(bookReaderLogic: logic),
          BookAppbarMenu(
            bookReaderLogic: logic,
          ),
          Obx(() {
            bool b = (logic.m1.value ||
                logic.m2.value ||
                logic.m3.value ||
                logic.m4.value);
            if (b) {
              return Positioned(
                  child: GestureDetector(
                    onTap: () {
                      logic.onTapMenu();
                    },
                    child: Container(
                      width: double.infinity,
                      height: Get.height,
                      color: Colors.black38,
                      margin:
                      const EdgeInsets.only(bottom: kBottomNavigationBarHeight),
                    ),
                  ));
            } else {
              return const SizedBox.shrink();
            }
          }),
          BookMenu(
            logic: logic,
          ),
          buildm2(),
          BookScreenBrightness(
            bookReaderLogic: logic,
          ),
          BookTextStyleMenu(bookReaderLogic: logic),
          IntroduceMenu(
            bookReaderLogic: logic,
          ),
        ],
      ),
    );
  }

  Obx buildm2() {
    return Obx(() {
      return AnimatedPositioned(
        left: 0,
        right: 0,
        bottom: logic.m2.value
            ? 0
            : -(Get.height * .75 + kBottomNavigationBarHeight),
        duration: 300.milliseconds,
        child: Container(
          margin: const EdgeInsets.only(bottom: kBottomNavigationBarHeight),
          width: double.infinity,
          height: Get.height * .75,
          color: Colors.red,
        ),
      );
    });
  }
}



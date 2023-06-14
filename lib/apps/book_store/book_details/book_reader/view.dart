import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:huaxia/apps/book_store/book_details/book_reader/ui/book_appbar_menu.dart';
import 'package:huaxia/apps/book_store/book_details/book_reader/ui/book_bottom_menu.dart';
import 'package:huaxia/apps/book_store/book_details/book_reader/ui/book_screen_brightness.dart';
import 'package:huaxia/apps/book_store/book_details/book_reader/ui/book_text_style_menu.dart';
import 'package:huaxia/apps/book_store/book_details/book_reader/ui/introduce_menu.dart';

import 'package:huaxia/config/assets/imgs.dart';
import 'package:huaxia/config/config.dart';
import 'package:huaxia/widgets/custom_selectable_text/custom_selectable_text.dart';
import 'package:huaxia/widgets/custom_selectable_text/src/custom_text_selection_controls.dart';

import 'logic.dart';

class BookReaderPage extends StatefulWidget {
  const BookReaderPage({super.key});

  @override
  State<BookReaderPage> createState() => _BookReaderPageState();
}

class _BookReaderPageState extends State<BookReaderPage> {
  final logic = Get.find<BookReaderLogic>();


  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BookBottomMenu(bookReaderLogic: logic,),

      body: Stack(
        fit: StackFit.expand,
        clipBehavior: Clip.none,
        children: [
          Positioned.fill(
            child: Container(
              width: Get.width,
              height: Get.height,
              decoration: const BoxDecoration(color: Colors.white),
              child: ListView(
                children: [
                  ValueListenableBuilder(
                      valueListenable: logic.docVN,
                      builder: (context, data, child) {
                        return TextSelectionGestureDetector(
                          onSingleTapUp: (des) {},
                          child: CustomSelectableText.rich(
                            TextSpan(text: data),
                            items: logic.customSelectableTextItems,
                            onSingleTapUp: (TapDragUpDetails tap) {
                              final dx = tap.localPosition.dx;
                              final cW = Get.width / 3;
                              if (dx > (2 * cW)) {
                                print("下一页");
                              } else if (dx >= cW && dx <= (cW * 2)) {
                                print("菜单");
                                logic.onTapMenu();
                              } else if (dx <= cW) {
                                print("上一页");
                              } else {
                                print("下一页");
                              }
                            },
                            onSelectionChanged: (TextSelection selection,
                                SelectionChangedCause? cause) {},
                          ),
                        );
                      }),
                ],
              ),
            ),
          ),
          // BookBottomMenu(bookReaderLogic: logic),
          BookAppbarMenu(bookReaderLogic: logic,),
          Obx(() {
            bool b = (logic.m1.value || logic.m2.value || logic.m3.value ||
                logic.m4.value);
            if (b) {
              return Positioned(child: GestureDetector(
                onTap: () {
                  logic.onTapMenu();
                },
                child: Container(
                  width: double.infinity,
                  height: Get.height,
                  color: Colors.black38,
                  margin: const EdgeInsets.only(
                      bottom: kBottomNavigationBarHeight),
                ),
              ));
            } else {
              return const SizedBox.shrink();
            }
          }),
          buildm1(),
          buildm2(),
          BookScreenBrightness(bookReaderLogic: logic,),
          BookTextStyleMenu(bookReaderLogic: logic),
          IntroduceMenu(bookReaderLogic: logic,),
        ],
      ),
    );
  }

  Obx buildm1() {
    return Obx(() {
      return AnimatedPositioned(
        left: 0,
        right: 0,
        bottom: logic.m1.value ? 0 : -(Get.height),
        duration: 300.milliseconds,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
          width: double.infinity,
          height: Get.height * .75,
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(20), topLeft: Radius.circular(20)
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  Container(
                    width: 68,
                    height: 88,
                    color: Colors.red,
                  ),
                  const SizedBox(width: 13,),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('三体', style: Get.textTheme.headlineMedium!
                            .copyWith(fontWeight: FontWeight.w500),),
                        Text('共112章', style: Get.textTheme.labelLarge!.copyWith(
                            fontSize: 14),),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('已读1%',
                              style: Get.textTheme.labelLarge!.copyWith(
                                  fontSize: 14),),
                            TextButton.icon(onPressed: () {

                            },
                              icon: Icon(Icons.arrow_drop_down_sharp),
                              label: Text('去当前'),)
                          ],
                        ),
                      ],
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      );
    });
  }

  Obx buildm2() {
    return Obx(() {
      return AnimatedPositioned(
        left: 0,
        right: 0,
        bottom: logic.m2.value ? 0 : -(Get.height * .75 +
            kBottomNavigationBarHeight),
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

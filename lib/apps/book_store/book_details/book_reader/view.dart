import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:huaxia/apps/book_store/book_details/book_reader/ui/book_text_style_menu.dart';

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

  var targetPath = "/your/sample/path";
  var targetFileName = "example_pdf_file";

  @override
  void initState() {
    // var document = parseFragment(data,generateSpans: true);
    //
    // el(document.nodes);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          buildMenuBar(),
          Obx(() {
            bool b = (logic.m1.value ||logic.m2.value||logic.m3.value||logic.m4.value);
            if(b){
              return Positioned(child: Container(
                width: double.infinity,
                height:  Get.height,
                color: Colors.black38,
                margin: const EdgeInsets.only(bottom: kBottomNavigationBarHeight),
              ));
            }else{
              return const SizedBox.shrink();
            }
          }),
          buildm1(),
          buildm2(),
          buildm3(),
          BookTextStyleMenu(bookReaderLogic: logic),
          buildMenuBottom()

        ],
      ),
    );
  }

  Obx buildm1() {
    return Obx(() {
          return AnimatedPositioned(
              left: 0,
              right: 0,
              bottom:logic.m1.value?0: -(Get.height),
              duration: 300.milliseconds,
              child:Container(
                padding: const EdgeInsets.symmetric(vertical: 20,horizontal: 16),
                width: double.infinity,
                height: Get.height*.75 ,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(topRight: Radius.circular(20),topLeft: Radius.circular(20)
                  ),
                ),
                child:  Column(
                  mainAxisSize: MainAxisSize.min ,
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
                              Text('三体',style: Get.textTheme.headlineMedium!.copyWith(fontWeight: FontWeight.w500),),
                              Text('共112章',style: Get.textTheme.labelLarge!.copyWith(fontSize: 14),),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('已读1%',style: Get.textTheme.labelLarge!.copyWith(fontSize: 14),),
                                  TextButton.icon(onPressed: (){

                                  }, icon: Icon(Icons.arrow_drop_down_sharp),label: Text('去当前'),)
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
              bottom:logic.m2.value?0: -(Get.height * .75 + kBottomNavigationBarHeight),
              duration: 300.milliseconds,
              child:Container(
                margin: const EdgeInsets.only(bottom: kBottomNavigationBarHeight),
                width: double.infinity,
                height: Get.height * .75,
                color: Colors.red,
              ),
          );
        });
  }
  Obx buildm3() {
    return Obx(() {
          return AnimatedPositioned(
              left: 0,
              right: 0,
              bottom:logic.m3.value?0: -(Get.height * .75 + kBottomNavigationBarHeight),
              duration: 300.milliseconds,
              child:Container(
                margin: const EdgeInsets.only(bottom: kBottomNavigationBarHeight),
                width: double.infinity,
                height: Get.height * .75,
                color: Colors.white,
              ),
          );
        });
  }


  Obx buildMenuBottom() {
    return Obx(() {
      return AnimatedPositioned(
          left: 0,
          right: 0,
          bottom: logic.menuBottomShow.value ? 0 : -kBottomNavigationBarHeight,
          child: Theme(
            data: Get.theme.copyWith(
                bottomNavigationBarTheme: BottomNavigationBarThemeData(
                  selectedItemColor: Color(0xff00BEBD),
                  unselectedItemColor: Color(0xff202329),
                  selectedIconTheme: IconThemeData(
                      color: Color(0xff00BEBD),
                      size: 24
                  ),
                  unselectedIconTheme: IconThemeData(
                      color: Color(0xff202329),
                      size: 24
                  ),
                  type: BottomNavigationBarType.fixed,
                  showSelectedLabels: true,
                  selectedLabelStyle: TextStyle(
                      fontSize: 10, color: Color(0xff00BEBD)),
                  unselectedLabelStyle: TextStyle(
                      fontSize: 10, color: Color(0xff202329)),

                )
            ),
            child: Obx(() {
              return BottomNavigationBar(
                currentIndex: logic.currentIndex.value,
                onTap: (i) {
                  logic.openMenuList(i);
                },
                items: [
                  BottomNavigationBarItem(
                      icon: ImageIcon(AssetImage(Imgs.ic_menu),),
                      label: '菜单'),
                  BottomNavigationBarItem(
                      icon: ImageIcon(AssetImage(Imgs.ic_me_notes),),
                      label: '笔记'),
                  BottomNavigationBarItem(
                      icon: ImageIcon(AssetImage(Imgs.ic_brightness),),
                      label: '亮度'),
                  BottomNavigationBarItem(
                      icon: ImageIcon(AssetImage(Imgs.ic_ta),),
                      label: '设置'),
                ],

              );
            }),
          ),
          duration: 300.milliseconds);
    });
  }

  Obx buildMenuBar() {
    return Obx(() {
      return AnimatedPositioned(
        duration: 300.milliseconds,
        top: logic.menuBarShow.value ? 0 : -Get.statusBarHeight,
        left: 0,
        right: 0,
        child: Container(
          color: Colors.white,
          height: Get.statusBarHeight,
          padding: const EdgeInsets.only(bottom: 3),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              BackButton(),
              TextButton.icon(
                onPressed: () {},
                icon: ImageIcon(
                  AssetImage(
                    Imgs.ic_sc,
                  ),
                  size: 24,
                ),
                label: Text('加入书架'),
              )
            ],
          ),
        ),
      );
    });
  }

  Obx buildObx() {
    return Obx(() {
      return Visibility(
          visible: logic.showFistPop.value,
          child: Row(
            children: [
              Container(
                width: Get.width / 3,
                height: Get.height,
                color: Colors.black.withOpacity(.5),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      Imgs.ic_pre,
                      width: 29,
                      height: 29,
                    ),
                    const Text(
                      '上一页',
                      style: TextStyle(
                          color: Colors.white,
                          decoration: TextDecoration.none,
                          fontSize: 16),
                    )
                  ],
                ),
              ),
              Container(
                width: Get.width / 3,
                height: Get.height,
                decoration: BoxDecoration(
                    color: Colors.black.withOpacity(.6),
                    border: Border(
                        left: BorderSide(color: Colors.white, width: .5),
                        right: BorderSide(color: Colors.white, width: .5))),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      '点击中间\n'
                          '弹出菜单',
                      style: TextStyle(
                          color: Colors.white,
                          decoration: TextDecoration.none,
                          fontSize: 18),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 20, bottom: 50),
                      child: Image.asset(
                        Imgs.ic_gesture,
                        width: 116,
                        height: 120,
                      ),
                    ),
                    ElevatedButton(
                        onPressed: () {
                          logic.showFistPop.value = false;
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.black),
                        child: const Text(
                          '知道了',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 13,
                              fontWeight: FontWeight.bold),
                        ))
                  ],
                ),
              ),
              Container(
                width: Get.width / 3,
                height: Get.height,
                color: Colors.black.withOpacity(.5),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      Imgs.ic_next,
                      width: 29,
                      height: 29,
                    ),
                    const Text(
                      '下一页',
                      style: TextStyle(
                          color: Colors.white,
                          decoration: TextDecoration.none,
                          fontSize: 16),
                    )
                  ],
                ),
              ),
            ],
          ));
    });
  }

}

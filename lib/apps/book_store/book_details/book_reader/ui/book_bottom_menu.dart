import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:huaxia/apps/book_store/book_details/book_reader/logic.dart';
import 'package:huaxia/config/config.dart';

import 'book_screen_brightness.dart';

class BookBottomMenu extends StatelessWidget {
  final BookReaderLogic bookReaderLogic;

  const BookBottomMenu({Key? key, required this.bookReaderLogic})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() {
     return bookReaderLogic.menuBottomShow.value
          ? Theme(
          data: Get.theme.copyWith(
              bottomNavigationBarTheme:
              const BottomNavigationBarThemeData(
                selectedItemColor: Color(0xff00BEBD),
                unselectedItemColor: Color(0xff202329),
                selectedIconTheme:
                IconThemeData(color: Color(0xff00BEBD), size: 24),
                unselectedIconTheme:
                IconThemeData(color: Color(0xff202329), size: 24),
                type: BottomNavigationBarType.fixed,
                showSelectedLabels: true,
                selectedLabelStyle:
                TextStyle(fontSize: 10, color: Color(0xff00BEBD)),
                unselectedLabelStyle:
                TextStyle(fontSize: 10, color: Color(0xff202329)),
              )),
          child: BottomNavigationBar(
            currentIndex: bookReaderLogic.currentIndex.value,
            onTap: (i) {
              bookReaderLogic.openMenuList(i);
            },
            items: [
              BottomNavigationBarItem(
                  icon: ImageIcon(
                    AssetImage(Imgs.ic_menu),
                  ),
                  label: '菜单'),
              BottomNavigationBarItem(
                  icon: ImageIcon(
                    AssetImage(Imgs.ic_me_notes),
                  ),
                  label: '笔记'),
              BottomNavigationBarItem(
                  icon: ImageIcon(
                    AssetImage(Imgs.ic_brightness),
                  ),
                  label: '亮度'),
              BottomNavigationBarItem(
                  icon: ImageIcon(
                    AssetImage(Imgs.ic_ta),
                  ),
                  label: '设置'),
            ],
          ))
          : SizedBox.fromSize();

      // return AnimatedPositioned(
      //     left: 0,
      //     right: 0,
      //     bottom: bookReaderLogic.menuBottomShow.value ? 0 : -kBottomNavigationBarHeight,
      //     duration: 300.milliseconds,
      //     child: Theme(
      //       data: Get.theme.copyWith(
      //           bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      //             selectedItemColor: Color(0xff00BEBD),
      //             unselectedItemColor: Color(0xff202329),
      //             selectedIconTheme: IconThemeData(
      //                 color: Color(0xff00BEBD),
      //                 size: 24
      //             ),
      //             unselectedIconTheme: IconThemeData(
      //                 color: Color(0xff202329),
      //                 size: 24
      //             ),
      //             type: BottomNavigationBarType.fixed,
      //             showSelectedLabels: true,
      //             selectedLabelStyle: TextStyle(
      //                 fontSize: 10, color: Color(0xff00BEBD)),
      //             unselectedLabelStyle: TextStyle(
      //                 fontSize: 10, color: Color(0xff202329)),
      //
      //           )
      //       ),
      //       child: Obx(() {
      //         return  BottomNavigationBar(
      //           currentIndex: bookReaderLogic.currentIndex.value,
      //           onTap: (i) {
      //             bookReaderLogic.openMenuList(i);
      //           },
      //           items: [
      //             BottomNavigationBarItem(
      //                 icon: ImageIcon(AssetImage(Imgs.ic_menu),),
      //                 label: '菜单'),
      //             BottomNavigationBarItem(
      //                 icon: ImageIcon(AssetImage(Imgs.ic_me_notes),),
      //                 label: '笔记'),
      //             BottomNavigationBarItem(
      //                 icon: ImageIcon(AssetImage(Imgs.ic_brightness),),
      //                 label: '亮度'),
      //             BottomNavigationBarItem(
      //                 icon: ImageIcon(AssetImage(Imgs.ic_ta),),
      //                 label: '设置'),
      //           ],
      //
      //         );
      //       }),
      //     ));
    });
  }
}

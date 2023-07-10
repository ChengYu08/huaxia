
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:huaxia/config/config.dart';

import '../logic.dart';

class  BookAppbarMenu extends StatelessWidget {
  final BookReaderLogic bookReaderLogic;

  const  BookAppbarMenu({Key? key, required this.bookReaderLogic}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return AnimatedPositioned(
        duration: 300.milliseconds,
        top: bookReaderLogic.menuBarShow.value ? 0 : -Get.statusBarHeight,
        left: 0,
        right: 0,
        child: AppBar(
          title: Text('${bookReaderLogic.book.value.name}'),
          actions: [
            if(bookReaderLogic.book.value.isJoin==0)
            TextButton.icon(
              onPressed: bookReaderLogic.addBook,
              icon: ImageIcon(
                AssetImage(
                  Imgs.ic_sc,
                ),
                size: 24,
              ),
              label: const Text('加入书架'),
            )
          ],
        )
      );
    });
  }

}



import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:huaxia/config/config.dart';

import '../logic.dart';
import '../my_book_logic.dart';

class ShelfBar extends StatelessWidget {
  const ShelfBar({
    super.key,
    required this.shelfLogic,
    required this.logic,
  });

  final MyBookLogic shelfLogic;
  final BookStoreLogic logic;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (shelfLogic.selectBook.value == 0) {
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            children: [
              Text('我的书架',
                  style: Get.textTheme.bodyLarge!
                      .copyWith(fontWeight: FontWeight.bold)),
              const SizedBox(
                width: 12,
              ),
              Obx(() {
                return Text('共${shelfLogic.allBooksOBX.length}本',
                    style: Get.textTheme.labelLarge);
              }),
              const Spacer(),
              TextButton.icon(
                onPressed: () {
                  shelfLogic.selectBook.value = 1;
                },
                icon: Image.asset(
                  Imgs.ic_check,
                  width: 20,
                  height: 20,
                ),
                label: Text(
                  '选择',
                  style: Get.textTheme.bodySmall,
                ),
              )
            ],
          ),
        );
      } else {
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton(
                  onPressed: () {
                    //全选【true】
                    // bool show =
                    //     logic.selectBooksOBX.length ==
                    //         logic.books.length;
                    //
                    // for (var element in logic.books) {
                    //   element.selectBook.value = !show;
                    // }
                    // logic.selectBooksOBX.clear();
                    // if (!show) {
                    //   logic.selectBooksOBX
                    //       .addAll(logic.books);
                    // }
                    shelfLogic.delect();
                  },
                  child: Text('删除', style: Get.textTheme.bodySmall)),
              Column(
                children: [
                  Text('选择书籍',
                      style: Get.textTheme.bodySmall!
                          .copyWith(fontWeight: FontWeight.bold)),
                  Obx(() {
                    return Text('已选择${shelfLogic.selectBooksOBX.length}本书籍',
                        style: Get.textTheme.labelLarge);
                  }),
                ],
              ),
              TextButton(
                onPressed: () {
                  shelfLogic.selectBook.value = 0;
                },
                child: Text(
                  '取消',
                  style: Get.textTheme.bodySmall,
                ),
              )
            ],
          ),
        );
      }
    });
  }
}
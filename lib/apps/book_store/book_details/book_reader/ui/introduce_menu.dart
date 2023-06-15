

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:huaxia/apps/book_store/book_details/book_reader/logic.dart';
import 'package:huaxia/config/config.dart';

class IntroduceMenu extends StatelessWidget {
  final BookReaderLogic bookReaderLogic;
  const IntroduceMenu({Key? key, required this.bookReaderLogic}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Visibility(
          visible: bookReaderLogic.showFistPop.value,
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
                          bookReaderLogic.showFistPop.value = false;
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

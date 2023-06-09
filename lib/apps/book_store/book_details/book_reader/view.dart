
import 'dart:io';


import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:huaxia/config/assets/imgs.dart';
import 'package:huaxia/config/config.dart';
import 'package:huaxia/widgets/custom_selectable_text/custom_selectable_text.dart';



import 'logic.dart';

class BookReaderPage extends StatefulWidget {
  const BookReaderPage({super.key});

  @override
  State<BookReaderPage> createState() => _BookReaderPageState();
}

class _BookReaderPageState extends State<BookReaderPage> {
  final logic = Get.find<BookReaderLogic>();
   String d='';
  String data =
      '历时1年的时间，整理完成了330+组件的详细用法，不仅包含UI组件，还包含了功能性的组件（文末有获取方式）。虽然整理了 330+的组件基本用法，但并不是让你每一个都学习一遍，任何技术基本都是掌握 20%就可以解决 80%的问题，因此只需学会基础组件就可以上手项目了，至于其他的控件只需大概浏览一下，做项目的时候遇到一些功能能够想起 Flutter 已经提供了此组件就可以了。因此不要看到330+个组件就心生恐惧，这不是一篇让你从入门到放弃的文章，而是一篇让你更快入门的文章。希望你把此当成一本工具书，当用到的时候再来查阅。那应该学哪些控件呢？不要着急，接下来我将会在我的公众号（文末有二维码，或者直接搜索【老孟Flutter】）分享《Flutter 实战》系列的文章，此系列文章包含大量的实际项目中常用的案例和效果，让你尽快进入Flutter大门。';



  var targetPath = "/your/sample/path";
  var targetFileName = "example_pdf_file";

  @override
  void initState() {
  List.generate(10, (index) => d+=data);

    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      bottom: false,
      left: false,
      right: false,
      child: Stack(
        children: [
          Positioned.fill(
            child:Container(
              width: Get.width,
              height: Get.height,
              decoration: const BoxDecoration(
                color: Colors.white
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                        top: kToolbarHeight, left: 20, right: 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '第一章—易经的秘密',
                          style: Get.textTheme.labelLarge,
                        ),
                        IconButton(
                            onPressed: () {},
                            icon: Image.asset(
                              Imgs.ic_sc,
                              width: 21,
                              height: 21,
                            ))
                      ],
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: LayoutBuilder(
                        builder:
                            (BuildContext context, BoxConstraints constraints) {
                          return ListView(
                            children: [
                              ...List.generate(20, (index) =>   SizedBox(
                                width: constraints.maxWidth,
                                height: constraints.maxHeight,
                                child: CustomSelectableText.rich(
                                  TextSpan(
                                      text: d, style: Get.textTheme.bodySmall),
                                  textAlign: TextAlign.start,
                                  items: logic.customSelectableTextItems,
                                ),
                              ),)
                            ],
                          );
                        },
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          buildGuide()
        ],
      ),
    );
  }

  Obx buildGuide() {
    return Obx(() {
      if (!logic.showFistPop.value) {
        return const SizedBox();
      }
      return Positioned.fill(
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
                    style:
                        ElevatedButton.styleFrom(backgroundColor: Colors.black),
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

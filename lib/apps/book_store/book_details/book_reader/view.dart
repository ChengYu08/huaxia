import 'package:bookfx/bookfx.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'logic.dart';

class BookReaderPage extends StatefulWidget {

  const BookReaderPage({super.key});

  @override
  State<BookReaderPage> createState() => _BookReaderPageState();
}

class _BookReaderPageState extends State<BookReaderPage> {
  final logic = Get.find<BookReaderLogic>();
  String data = '历时1年的时间，整理完成了330+组件的详细用法，不仅包含UI组件，还包含了功能性的组件（文末有获取方式）。虽然整理了 330+的组件基本用法，但并不是让你每一个都学习一遍，任何技术基本都是掌握 20%就可以解决 80%的问题，因此只需学会基础组件就可以上手项目了，至于其他的控件只需大概浏览一下，做项目的时候遇到一些功能能够想起 Flutter 已经提供了此组件就可以了。因此不要看到330+个组件就心生恐惧，这不是一篇让你从入门到放弃的文章，而是一篇让你更快入门的文章。希望你把此当成一本工具书，当用到的时候再来查阅。那应该学哪些控件呢？不要着急，接下来我将会在我的公众号（文末有二维码，或者直接搜索【老孟Flutter】）分享《Flutter 实战》系列的文章，此系列文章包含大量的实际项目中常用的案例和效果，让你尽快进入Flutter大门。';


  EBookController eBookController = EBookController();
  BookController bookController = BookController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: EBook(
          eBookController: eBookController,
          bookController: bookController,
          data: data,

          fontSize: eBookController.fontSize,
          padding: const EdgeInsetsDirectional.all(15),
          maxHeight:600, maxWidth: Get.width,),
    );

  }
}

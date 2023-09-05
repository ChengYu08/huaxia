import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:huaxia/apps/book_store/model/BookList.dart';
import 'package:huaxia/apps/book_store/my_book_logic.dart';
import 'package:huaxia/apps/book_store/widget/book_list_widget.dart';
import 'package:huaxia/config/assets/imgs.dart';
import 'package:huaxia/config/config.dart';
import 'package:huaxia/widgets/book_cover.dart';
import 'widget/book_flex_space_bar.dart';
import 'logic.dart';
import 'package:html/parser.dart' as htmlparser;

import 'model/ShelfBook.dart';
import 'widget/shelf_bar.dart';
import 'widget/shelf_view.dart';

class BookStorePage extends StatefulWidget {
  @override
  State<BookStorePage> createState() => _BookStorePageState();
}

class _BookStorePageState extends State<BookStorePage>
    with SingleTickerProviderStateMixin {
  final logic = Get.find<BookStoreLogic>();
  final shelfLogic = Get.find<MyBookLogic>();
  late TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(vsync: this, length: 4);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return [
            Obx(() {
              return SliverAppBar(
                expandedHeight: logic.changedBook.value == 0 ? 290 : 0,
                actions: [
                  IconButton(
                      onPressed: () {
                        Get.toNamed(Routers.bookSearchPage);
                      },
                      icon: Image.asset(
                        Imgs.ic_search,
                        width: 24,
                        height: 24,
                      ))
                ],
                title: Row(
                  children: [
                    TextButton(
                        onPressed: () {
                          logic.changedBook.value = 0;
                        },
                        child: Text(
                          '书城',
                          style: logic.changedBook.value == 0
                              ? Get.textTheme.titleLarge!
                              .copyWith(fontWeight: FontWeight.bold)
                              : Get.textTheme.titleSmall,
                        )),
                    TextButton(
                        onPressed: () {
                          logic.changedBook.value = 1;
                        },
                        child: Text(
                          '书架',
                          style: logic.changedBook.value == 1
                              ? Get.textTheme.titleLarge!
                              .copyWith(fontWeight: FontWeight.bold)
                              : Get.textTheme.titleSmall,
                        )),
                  ],
                ),
                pinned: true,
                flexibleSpace: logic.changedBook.value == 0
                    ? BookFlexSpaceBar(tabController: _tabController)
                    : null,
                bottom: logic.changedBook.value == 0
                    ? PreferredSize(
                    preferredSize: const Size.fromHeight(50),
                    child: Container(
                      padding:
                      const EdgeInsets.only(left: 24, top: 20, bottom: 3),
                      decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                              topRight: Radius.circular(20),
                              topLeft: Radius.circular(20))),
                      alignment: Alignment.bottomLeft,
                      child: Text('推荐古籍', style: Get.textTheme.bodyLarge),
                    ))
                    : PreferredSize(
                    preferredSize: const Size.fromHeight(50),
                    child: ShelfBar(shelfLogic: shelfLogic, logic: logic)),
              );
            }),

          ];
        },
          body:  Padding(
            child: Obx(() {
              final bookStore = BookListWidget(controller: _tabController,);
              final books = ShelfView(shelfLogic: shelfLogic, logic: logic);
              if (logic.changedBook.value == 0) {
                return bookStore;
              } else {
                return books;
              }
            }),
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
          ),
      ),
    );
  }
}








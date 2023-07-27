import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:huaxia/apps/book_store/model/BookList.dart';
import 'package:huaxia/apps/book_store/my_book_logic.dart';
import 'package:huaxia/config/assets/imgs.dart';
import 'package:huaxia/config/config.dart';
import 'package:huaxia/widgets/book_cover.dart';
import 'book_flex_space_bar.dart';
import 'logic.dart';
import 'package:html/parser.dart' as htmlparser;

import 'model/ShelfBook.dart';

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
    _tabController.addListener(() {
      logic.intBookList(_tabController.index);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: [
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
          SliverPadding(
            sliver: Obx(() {
              final bookStore = BookListWidget(
                controller: _tabController,
                rxMap: logic.bookList,
              );
              final books = ShelfView(shelfLogic: shelfLogic, logic: logic);
              if (logic.changedBook.value == 0) {
                return bookStore;
              } else {
                return books;
              }
            }),
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
          )
        ],
      ),
    );
  }
}

class ShelfView extends StatelessWidget {
  const ShelfView({
    super.key,
    required this.shelfLogic,
    required this.logic,
  });

  final MyBookLogic shelfLogic;
  final BookStoreLogic logic;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      bool isShow = shelfLogic.selectBook.value == 1;
      List<ShelfBook> shelfData = shelfLogic.allBooksOBX.value;
      return SliverGrid(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 30,
            childAspectRatio: 9 / 18,
            // mainAxisExtent: ,
            mainAxisSpacing: 8),
        delegate: SliverChildBuilderDelegate((context, index) {
          final ShelfBook book = shelfData[index];
          return InkWell(
            onTap: () {
              Get.toNamed(Routers.bookDetailsPage,
                  arguments: book.bookId, parameters: {
                    'bookId': '${book.bookId}'
                  });
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AspectRatio(
                  aspectRatio: 9 / 15,
                  child: Container(
                    width: double.infinity,
                    child: LayoutBuilder(
                      builder: (BuildContext context,
                          BoxConstraints constraints) {
                        return Stack(
                          children: [
                            BookCover(
                              title: book.bookName ?? '',
                              width: constraints.maxWidth,
                              height: constraints.maxHeight,
                            ),
                            Positioned(
                              right: 0,
                              top: 0,
                              child: ClipPath(
                                clipper: TrianglePath(),
                                child: Container(
                                  width: 22,
                                  height: 24,
                                  color: const Color(0xffF5A740),
                                  child: Center(
                                      child: Text(
                                        '${book.percentage??0}%',
                                        style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 10),
                                      )),
                                ),
                              ),
                            ),
                            if (isShow)
                              ValueListenableBuilder(
                                valueListenable: book.selectBook,
                                builder: (BuildContext context,
                                    bool value, Widget? child) {
                                  return GestureDetector(
                                    onTap: () {
                                      book.selectBook.value =
                                      !book.selectBook.value;
                                      if (book.selectBook.value) {
                                        shelfLogic.selectBooksOBX
                                            .add(book);
                                      } else {
                                        shelfLogic.selectBooksOBX
                                            .remove(book);
                                      }
                                    },
                                    behavior:
                                    HitTestBehavior.translucent,
                                    child: Container(
                                      color: value
                                          ? Colors.black.withOpacity(
                                          .5)
                                          : null,
                                      alignment: Alignment
                                          .bottomRight,
                                      padding: const EdgeInsets.all(
                                          8),
                                      child: AnimatedSwitcher(
                                        duration: 300.milliseconds,
                                        child: value
                                            ? Icon(
                                          key: ValueKey(1),
                                          Icons
                                              .check_circle_rounded,
                                          color: Get
                                              .theme.primaryColor,
                                        )
                                            : const Icon(
                                          Icons
                                              .check_circle_outlined,
                                          key: ValueKey(2),
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              )
                          ],
                        );
                      },
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 9, left: 8),
                  child: Text(
                    book.bookName ?? '',
                    style: Get.textTheme.bodySmall,
                  ),
                )
              ],
            ),
          );
        }, childCount: shelfData.length),
      );
    });
  }
}

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

class BookListWidget extends StatefulWidget {
  final RxMap rxMap;
  final TabController controller;

  const BookListWidget({
    super.key,
    required this.rxMap,
    required this.controller,
  });

  @override
  State<BookListWidget> createState() => _BookListWidgetState();
}

class _BookListWidgetState extends State<BookListWidget> {
  @override
  void initState() {
    widget.controller.addListener(() {
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<ApiResult<List<BookList>>>(
        future: widget.rxMap[widget.controller.index],
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            final ApiResult result = snapshot.error as ApiResult;
            return SliverToBoxAdapter(child: Text(result.message));
          }

          if (snapshot.hasData) {
            final listData = snapshot.data?.data ?? [];

            return SliverPrototypeExtentList(
                delegate: SliverChildBuilderDelegate((context, index) {
                  final data = listData[index];
                  return GestureDetector(
                    onTap: () {
                      Get.toNamed(Routers.bookDetailsPage, arguments: data,
                          parameters: {
                            'bookId': '${data.bookId}'
                          });
                    },
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 8),
                      padding: const EdgeInsets.symmetric(
                          vertical: 12, horizontal: 14),
                      child: Row(
                        children: [
                          BookCover(
                            title: '${data.name}',
                          ),
                          const SizedBox(
                            width: 16,
                          ),
                          Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text(
                                    data.author ?? '--',
                                    style: Get.textTheme.bodyMedium!
                                        .copyWith(fontWeight: FontWeight.bold),
                                  ),
                                  const SizedBox(
                                    height: 3,
                                  ),
                                  Expanded(
                                      child: Text(
                                        '${htmlparser
                                            .parse(data.synopsis)
                                            .body
                                            ?.text}',
                                        maxLines: 3,
                                        overflow: TextOverflow.ellipsis,
                                        style: Get.textTheme.labelLarge,
                                      ))
                                ],
                              ))
                        ],
                      ),
                    ),
                  );
                }, childCount: listData.length),
                prototypeItem: const SizedBox(
                  width: double.infinity,
                  height: 120,
                ));
          }
          return const SliverToBoxAdapter(
              child: Center(child: CircularProgressIndicator()));
        });
  }
}

class TrianglePath extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path()
      ..relativeLineTo(size.width, 0)..relativeLineTo(0, size.height)
      ..relativeCubicTo(
        0,
        0,
        -size.width / 2,
        -8,
        -size.width,
        0,
      )
      ..close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}

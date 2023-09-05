import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:huaxia/apps/book_store/logic.dart';
import 'package:huaxia/apps/book_store/model/ShelfBook.dart';
import 'package:huaxia/apps/book_store/my_book_logic.dart';
import 'package:huaxia/widgets/book_cover.dart';

import '../../../config/config.dart';

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
      return GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 30,
            childAspectRatio: 9 / 18,
            // mainAxisExtent: ,
            mainAxisSpacing: 8),
        itemCount: shelfData.length,
        itemBuilder: (BuildContext context, int index) {
          final ShelfBook book = shelfData[index];
          return InkWell(
            onTap: () {
              Get.toNamed(Routers.bookDetailsPage,
                  arguments: book.bookId,
                  parameters: {'bookId': '${book.bookId}'});
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AspectRatio(
                  aspectRatio: 9 / 15,
                  child: Container(
                    width: double.infinity,
                    child: LayoutBuilder(
                      builder:
                          (BuildContext context, BoxConstraints constraints) {
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
                                    '${book.percentage ?? 0}%',
                                    style: const TextStyle(
                                        color: Colors.white, fontSize: 10),
                                  )),
                                ),
                              ),
                            ),
                            if (isShow)
                              ValueListenableBuilder(
                                valueListenable: book.selectBook,
                                builder: (BuildContext context, bool value,
                                    Widget? child) {
                                  return GestureDetector(
                                    onTap: () {
                                      book.selectBook.value =
                                          !book.selectBook.value;
                                      if (book.selectBook.value) {
                                        shelfLogic.selectBooksOBX.add(book);
                                      } else {
                                        shelfLogic.selectBooksOBX.remove(book);
                                      }
                                    },
                                    behavior: HitTestBehavior.translucent,
                                    child: Container(
                                      color: value
                                          ? Colors.black.withOpacity(.5)
                                          : null,
                                      alignment: Alignment.bottomRight,
                                      padding: const EdgeInsets.all(8),
                                      child: AnimatedSwitcher(
                                        duration: 300.milliseconds,
                                        child: value
                                            ? Icon(
                                                key: ValueKey(1),
                                                Icons.check_circle_rounded,
                                                color: Get.theme.primaryColor,
                                              )
                                            : const Icon(
                                                Icons.check_circle_outlined,
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
        },
      );
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
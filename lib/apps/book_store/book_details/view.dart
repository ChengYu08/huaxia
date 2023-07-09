import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:huaxia/apps/book_store/book_details/ebook.dart';
import 'package:huaxia/apps/book_store/book_details/test.dart';
import 'package:huaxia/config/assets/imgs.dart';
import 'package:huaxia/config/config.dart';
import 'package:huaxia/widgets/book_cover.dart';
import 'package:huaxia/widgets/drop_shadow_image.dart';

import 'logic.dart';

class BookDetailsPage extends StatelessWidget {
  final logic = Get.find<BookDetailsLogic>();



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Get.theme.scaffoldBackgroundColor,
        actions: [
          if(logic.book.isJoin==0)
          TextButton.icon(
            onPressed: () {},
            icon: Image.asset(
              Imgs.ic_add_book,
              width: 24,
              height: 24,
            ),
            label: Text(
              '加入书架',
              style: Get.textTheme.bodySmall,
            ),
          ),
          IconButton(
              onPressed: () {},
              icon: Image.asset(
                Imgs.ic_share,
                width: 24,
                height: 24,
              ))
        ],
      ),
      body: SizedBox(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 8,
            ),
            SizedBox(
             width: 125,height: 170,
              child: DropShadowImage(
                  offset: Offset.zero,
                  scale: 1,
                  blurRadius: 5,
                  borderRadius: 3,
                  image:  BookCover(title: "${logic.book.name}",
                    width: 120,height: 164,
                  )),
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              '${logic.book.name}',
              style: Get.textTheme.displaySmall!.copyWith(fontWeight: FontWeight.w500),
            ),
            const SizedBox(
              height: 7,
            ),
            Text(
              '${logic.book.author}',
              style: Get.textTheme.bodySmall,
            ),
            const SizedBox(
              height: 20,
            ),
            Expanded(
                child: Column(
              children: [
                Container(
                  width: double.infinity,
                  height: 25,
                  margin: const EdgeInsets.symmetric(horizontal: 18),
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20))),
                ),
                Expanded(
                  child: Container(
                    width: double.infinity,
                    height: double.infinity,
                    decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20))),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 24, top: 24, right: 24, bottom: 21),
                          child: Row(
                            children: [
                              mue('目录', '7.2', 'w'),
                              const SizedBox(
                                width: 16,
                              ),
                              mue('全文', '81', '章节'),
                            ],
                          ),
                        ),
                        Expanded(
                            child: ListView(
                          padding: const EdgeInsets.symmetric(horizontal: 14),
                          children: [
                            Text(
                              '${logic.book.synopsis}',
                              style: Get.textTheme.labelLarge!
                                  .copyWith(fontSize: 14, height: 1.5),
                            ),
                          ],
                        )),
                        Padding(
                          padding: const EdgeInsets.only(
                              bottom: 30, left: 18, right: 18, top: 20),
                          child: Row(
                            children: [
                              Expanded(
                                child: SizedBox(
                                  height: 44,
                                  child: OutlinedButton.icon(
                                      onPressed: () {
                                        Get.to(()=>Test());

                                      },
                                      icon: Image.asset(
                                        Imgs.ic_earphone,
                                        width: 20,
                                        height: 20,
                                      ),
                                      label: Text(
                                        '听书',
                                        style: Get.textTheme.bodySmall,
                                      )),
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                  child: SizedBox(
                                    height: 44,
                                    child: ElevatedButton(
                                        onPressed: () {
                                          // Get.toNamed(Routers.bookReaderPage,arguments: logic.book);
                                          Get.to(()=>Ebooks());
                                        },
                                        child: Text('阅读全文')),
                                  ))
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ))
          ],
        ),
      ),
    );
  }

  Widget mue(String title, String s1, String s2) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
        decoration: BoxDecoration(
            color: Color(0xffF4F5F7), borderRadius: BorderRadius.circular(8)),
        child: Row(
          children: [
            Text(
              title,
              style: Get.textTheme.bodySmall,
            ),
            const Spacer(),
            Text(
              s1,
              style: Get.textTheme.bodyMedium,
            ),
            Text(
              s2,
              style: Get.textTheme.bodySmall!
                  .copyWith(fontSize: 12, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }


}

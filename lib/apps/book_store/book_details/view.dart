import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:huaxia/application/tts/tts_app.dart';
import 'package:huaxia/apps/book_store/book_details/ebook.dart';
import 'package:huaxia/apps/book_store/book_details/test.dart';
import 'package:huaxia/apps/book_store/model/Catalogue.dart';
import 'package:huaxia/config/assets/imgs.dart';
import 'package:huaxia/config/config.dart';
import 'package:huaxia/widgets/book_cover.dart';
import 'package:huaxia/widgets/drop_shadow_image.dart';
import 'package:huaxia/widgets/flutter_html/flutter_html.dart';

import 'book_reader/data/book_chapter.dart';
import 'logic.dart';

class BookDetailsPage extends StatelessWidget {
  final logic = Get.find<BookDetailsLogic>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Get.theme.scaffoldBackgroundColor,
        actions: [
          Obx(() {
            if (logic.book.value.isJoin == 0) {
              return TextButton.icon(
                onPressed: logic.addBook,
                icon: Image.asset(
                  Imgs.ic_add_book,
                  width: 24,
                  height: 24,
                ),
                label: Text(
                  '加入书架',
                  style: Get.textTheme.bodySmall,
                ),
              );
            } else {
              return const SizedBox.shrink();
            }
          }),
          IconButton(
              onPressed: () {},
              icon: Image.asset(
                Imgs.ic_share,
                width: 24,
                height: 24,
              ))
        ],
      ),
      body: FutureBuilder<ApiResult<List<Catalogue>>>(
          future: logic.bookCatalogue,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasError) {
              final error = snapshot.error as ApiResult;
              return Center(child: Text(error.message));
            }
            if (snapshot.hasData) {
              return SizedBox(
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 8,
                    ),
                    SizedBox(
                      width: 125,
                      height: 170,
                      child: DropShadowImage(
                          offset: Offset.zero,
                          scale: 1,
                          blurRadius: 5,
                          borderRadius: 3,
                          image: BookCover(
                            title: "${logic.book.value.name}",
                            width: 120,
                            height: 164,
                          )),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      '${logic.book.value.name}',
                      style: Get.textTheme.displaySmall!
                          .copyWith(fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(
                      height: 7,
                    ),
                    Text(
                      '${logic.book.value.author}',
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
                                      mue(
                                          '目录',
                                          '${logic.book.value.catalogueNum}',
                                          '章节'),
                                      const SizedBox(
                                        width: 16,
                                      ),
                                      mue(
                                          '全文',
                                          '${logic.book.value.sizeNum ?? 0}',
                                          '字'),
                                    ],
                                  ),
                                ),
                                Expanded(
                                    child: SingleChildScrollView(
                                        child: Html(
                                  data: '${logic.book.value.synopsis}',
                                  style: {
                                    'p': Style(
                                        fontSize: const FontSize(14),
                                        lineHeight: const LineHeight(1.5),
                                        color: Get.textTheme.labelLarge!.color)
                                  },
                                ))),
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
                                                final tts = Get.find<TTSApp>();
                                                tts.showSpeak(logic.book.value,
                                                    context: context);
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
                                              logic.goBook(snapshot.data?.data??[]);
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
              );
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          }),
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

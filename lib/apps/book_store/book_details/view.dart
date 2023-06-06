import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:huaxia/config/assets/imgs.dart';
import 'package:huaxia/config/config.dart';
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
            AspectRatio(
              aspectRatio: 16 / 9,
              child: DropShadowImage(
                  offset: Offset.zero,
                  scale: 1,
                  blurRadius: 8,
                  borderRadius: 3,
                  image: Image.network(
                      'https://img.newmediamax.com.tw/large/7f49bd584a6b4487a2c358893d6bc477')),
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              '道德家',
              style: Get.textTheme.displaySmall,
            ),
            const SizedBox(
              height: 7,
            ),
            Text(
              '老子',
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
                              '简介：《道德真经》即《道德经》，又称《老子》、《老子五千文》。共81章，5000余言，分上下篇。老子著。 老子姓李名耳，字聃，一字伯阳，或曰谥伯阳，春秋时期人，生卒年不详，籍贯也多有争议。老子为道家学派创始人和主要代表人物，与庄子并称“老庄”。在道教中被尊为道祖，称“太上老君”。在道教中，《庄子》又称《南华真经》，《列子》又称《冲虚真经》，与《道德真经》合称三真经，被道教奉为主要经典。简介：《道德真经》即《道德经》，又称《老子》、《老子五千文》。共81章，5000余言，分上下篇。老子著。 老子姓李名耳，字聃，一字伯阳，或曰谥伯阳，春秋时期人，生卒年不详，籍贯也多有争议。老子为道家学派创始人和主要代表人物，与庄子并称“老庄”。在道教中被尊为道祖'
                              ' ，称“太上老君”。在道教中，《庄子》又称《南华真经》，《列子》又称《冲虚真经》，与《道德真经》合称三真经，被道教奉为主要经典。',
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
                                      onPressed: () {},
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
                                          Get.toNamed(Routers.bookReaderPage);
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

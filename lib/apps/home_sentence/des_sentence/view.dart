import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:huaxia/config/config.dart';
import 'package:huaxia/widgets/persistent_header_builder.dart';

import 'logic.dart';

class DesSentencePage extends StatelessWidget {
  final logic = Get.find<DesSentenceLogic>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('句子详情'),
        backgroundColor: Colors.white,
        actions: [
          IconButton(
              onPressed: () {
                Get.toNamed(Routers.addSentencePage);
              },
              icon: Image.asset(
                Imgs.ic_push,
                width: 24,
                height: 24,
              ))
        ],
      ),
      bottomSheet: Container(
        height: 100,
        color: Colors.white,
        padding:
            const EdgeInsets.only(left: 16, right: 16, bottom: 30, top: 12),
        child: Row(
          children: [
            Expanded(
              child: SizedBox(
                child: TextField(
                  decoration: InputDecoration(
                      fillColor: Color(0xffF2F3F5),
                      filled: true,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide: BorderSide.none),
                      contentPadding: const EdgeInsets.only(left: 15),
                      prefix: Padding(
                        padding: const EdgeInsets.only(right: 8),
                        child: Image.asset(
                          Imgs.ic_edit,
                          width: 20,
                          height: 20,
                        ),
                      ),
                      hintText: '我也想说说…'),
                ),
              ),
            ),
            const SizedBox(
              width: 28,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  Imgs.ic_like_no,
                  width: 24,
                  height: 24,
                ),
                Text(
                  '123',
                  style: Get.textTheme.labelLarge,
                )
              ],
            ),
            const SizedBox(
              width: 28,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  Imgs.ic_review,
                  width: 24,
                  height: 24,
                  color: Colors.black,
                ),
                Text(
                  '123',
                  style: Get.textTheme.labelLarge,
                )
              ],
            ),
            const SizedBox(
              width: 28,
            ),
            CircleAvatar(
              backgroundColor: AppTheme.mainColor,
              child: const Text(
                '桌面\n显示',
                style: TextStyle(color: Colors.white, fontSize: 10),
              ),
            )
          ],
        ),
      ),
      body: Container(
        margin: const EdgeInsets.only(top: 16, right: 11, left: 11),
        padding: const EdgeInsets.all(12),
        decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20), topRight: Radius.circular(20))),
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Card(
                color: Colors.white,
                surfaceTintColor: Colors.white,
                elevation: 6,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                child: Padding(
                  padding: const EdgeInsets.only(top: 17, left: 12, right: 12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '《周易》-象传',
                        style: Get.textTheme.bodyMedium!,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 12),
                        child: Image.asset(
                          Imgs.ic_quotes,
                          width: 32,
                          height: 32,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10, right: 10),
                        child: Text(
                          '天行健，君子以自强不息。地势坤，君子以厚德载物。',
                          style: Get.textTheme.displaySmall,
                        ),
                      ),
                      Row(
                        children: [
                          TextButton.icon(
                            onPressed: () {},
                            icon: Image.asset(
                              Imgs.ic_like_no,
                              width: 20,
                              height: 20,
                            ),
                            label:
                                Text('6474', style: Get.textTheme.labelLarge),
                          ),
                          const Spacer(),
                          ElevatedButton.icon(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                                padding: EdgeInsets.symmetric(
                                    vertical: 4, horizontal: 10),
                                backgroundColor: Color(0xffF4F5F7)),
                            icon: Image.asset(
                              Imgs.ic_wach,
                              width: 20,
                              height: 20,
                            ),
                            label: Text(
                              '查看出处',
                              style: Get.textTheme.labelLarge,
                            ),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          ElevatedButton.icon(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                                padding: EdgeInsets.symmetric(horizontal: 10),
                                backgroundColor: Color(0xffF4F5F7)),
                            icon: Image.asset(
                              Imgs.ic_text_copy,
                              width: 20,
                              height: 20,
                            ),
                            label: Text(
                              '复制句子',
                              style: Get.textTheme.labelLarge,
                            ),
                          ),
                          const SizedBox(
                            width: 16,
                          )
                        ],
                      ),
                      const Padding(
                        padding: EdgeInsets.only(top: 15, bottom: 27),
                        child: DottedLine(
                          direction: Axis.horizontal,
                          lineLength: double.infinity,
                          lineThickness: .5,
                          dashLength: 3.0,
                          dashColor: Color(0xffE1E2E8),
                        ),
                      ),
                      Text(
                        '【译文】',
                        style: Get.textTheme.bodySmall!
                            .copyWith(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Text(
                        '天的运动刚强劲健，相应于此，君子处事，应像天一样，自我力求进步，刚毅坚卓，发奋图强，永不停息；大地的气势厚实和顺，君子应增厚美德，容载万物。',
                        style: Get.textTheme.bodySmall,
                      ),
                      const SizedBox(
                        height: 50,
                      )
                    ],
                  ),
                ),
              ),
            ),
            const SliverToBoxAdapter(
              child: SizedBox(
                height: 20,
              ),
            ),
            SliverPersistentHeader(
                pinned: true,
                floating: true,
                delegate: PersistentHeaderBuilder(
                    max: 80,
                    min: 60,
                    builder: (context, offset) {
                      return Container(
                        color: Colors.white,
                        child: Row(
                          children: [
                            const SizedBox(
                              width: 12,
                            ),
                            Text(
                              '全部评论',
                              style: Get.textTheme.bodySmall!
                                  .copyWith(fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(
                              width: 8,
                            ),
                            Text(
                              '123',
                              style: Get.textTheme.labelLarge,
                            ),
                            const Spacer(),
                            TextButton(
                                onPressed: () {},
                                child: Text(
                                  '最新',
                                  style: Get.textTheme.bodySmall!
                                      .copyWith(fontSize: 13),
                                )),
                            Container(
                              width: 1,
                              height: 10,
                              color: Color(0xffE1E2E8),
                            ),
                            TextButton(
                                onPressed: () {},
                                child: Text(
                                  '最热',
                                  style: Get.textTheme.labelLarge!.copyWith(
                                      fontSize: 13, color: Color(0xff83888f)),
                                )),
                          ],
                        ),
                      );
                    })),
            SliverPadding(
              sliver: SliverList(delegate: SliverChildBuilderDelegate((context, index) {
                return Container(
                  padding: const EdgeInsets.only(bottom: 12),
                  margin: const EdgeInsets.only(bottom: 8),
                  decoration: BoxDecoration(
                    // border: Border(bottom: BorderSide(color: Get.theme.dividerColor.withOpacity(.8),width: .5))
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          ImgNet.net(
                            'https://pica.zhimg.com/v2-3b4fc7e3a1195a081d0259246c38debc_720w.jpg?source=172ae18b',
                            width: 38,
                            fit: BoxFit.cover,
                            height: 38,
                            boxShape: BoxShape.circle,
                          ),
                          const SizedBox(width:12 ,),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('素迹',style: Get.textTheme.bodySmall!.copyWith(fontWeight: FontWeight.w600),),
                              Text('2023.03.10 15:02:45',style: Get.textTheme.labelMedium,),
                            ],
                          ),
                          const Spacer(),
                          Text('112',style: Get.textTheme.bodySmall!.copyWith(fontSize: 11),),
                          Image.asset(Imgs.ic_like,width: 24,height: 24,)
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 6,left: 50),
                        child: Text('如果我的能力只能让我穷困潦倒，那穷困潦倒就是我的价值。',style: Get.textTheme.bodySmall,),
                      )
                    ],
                  ),
                );
              })), padding: const EdgeInsets.only(bottom: 120),
            )
          ],
        ),
      ),
    );
  }
}

import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:huaxia/config/assets/imgs.dart';
import 'package:huaxia/config/config.dart';
import 'package:huaxia/widgets/card/flutter_card_swiper.dart';
import 'package:huaxia/widgets/card/src/enums.dart';

import '../../widgets/card/src/card_swiper.dart';
import 'logic.dart';

class HomeSentencePage extends StatelessWidget {
  final logic = Get.find<HomeSentenceLogic>();

  List<Container> cards = [
    Container(
      alignment: Alignment.center,
      child: const Text('1'),
      color: Colors.blue,
    ),
    Container(
      alignment: Alignment.center,
      child: const Text('2'),
      color: Colors.red,
    ),
    Container(
      alignment: Alignment.center,
      child: const Text('3'),
      color: Colors.purple,
    )
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '句子',
          style: Get.textTheme.titleLarge,
        ),
        centerTitle: false,
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
      body: Column(
        children: [
          Expanded(
            child: SizedBox(
              width: double.infinity,
              child: CardSwiper(
                controller: logic.cardSwiperController,
                cardsCount: 10,
                padding: const EdgeInsets.only(
                    top: 50, bottom: 0, left: 16, right: 16),
                numberOfCardsDisplayed: 3,
                scale: .9,
                allowedSwipeDirection: AllowedSwipeDirection.symmetric(horizontal: true),
                backCardOffset: const Offset(0, -50),
                onLike: (like) {
                  logic.like.value = like;
                },
                onSwipe: (previousIndex, currentIndex, direction) {
                  switch (direction) {
                    case CardSwiperDirection.left:
                      break;
                    case CardSwiperDirection.right:
                      break;
                    default:
                      break;
                  }
                  return true;
                },
                cardBuilder: (context, index,current) {
                  return Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    color: Colors.white,
                    child: ValueListenableBuilder(
                      valueListenable: logic.like,
                      builder:
                          (BuildContext context, int value, Widget? child) {
                        Widget c;
                        if (value == 1) {
                          c = Positioned(
                              top: 0,
                              left: 0,
                              child: Image.asset(
                                Imgs.ic_like_text,
                                width: 106,
                                height: 88,
                              ));
                        } else if (value == 2) {
                          c = Positioned(
                              top: 0,
                              right: 0,
                              child: Image.asset(
                                Imgs.ic_like_no_text,
                                width: 106,
                                height: 88,
                              ));
                        } else {
                          c = const SizedBox();
                        }
                        return Stack(
                          children: [child!,
                            if(current)
                            c],
                        );
                      },
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                width: 40,
                              ),
                              Text(
                                '《周易》-象传',
                                style: Get.textTheme.bodyMedium!
                                    .copyWith(fontWeight: FontWeight.bold),
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
                          Padding(
                            padding: const EdgeInsets.only(left: 20, top: 32),
                            child: Image.asset(
                              Imgs.ic_quotes,
                              width: 32,
                              height: 32,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 30, right: 30),
                            child: Text(
                              '天行健，君子以自强不息。地势坤，君子以厚德载物。',
                              style: Get.textTheme.displaySmall,
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.only(
                                left: 16, right: 16, top: 40, bottom: 21),
                            child: DottedLine(
                              direction: Axis.horizontal,
                              lineLength: double.infinity,
                              lineThickness: .5,
                              dashLength: 3.0,
                              dashColor: Color(0xffE1E2E8),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(23.0),
                            child: Text(
                              '【译文】',
                              style: Get.textTheme.bodySmall!
                                  .copyWith(fontWeight: FontWeight.bold),
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 30),
                              child: Text(
                                '天的运动刚强劲健，相应于此，君子处事，应像天一样，自我力求进步，刚毅坚卓，发奋图强，永不停息；大地的气势厚实和顺，君子应增厚美德，容载万物。',
                                style: Get.textTheme.bodySmall,
                              ),
                            ),
                          ),
                          Row(
                            children: [
                              TextButton.icon(
                                  onPressed: () {
                                    Get.toNamed(Routers.desSentencePage);
                                  },
                                  icon: Image.asset(
                                    Imgs.ic_review,
                                    width: 20,
                                    height: 20,
                                  ),
                                  label: Text('123评论',
                                      style: Get.textTheme.labelLarge)),
                              TextButton.icon(
                                onPressed: () {},
                                icon: Image.asset(
                                  Imgs.ic_like_no,
                                  width: 20,
                                  height: 20,
                                ),
                                label: Text('6474',
                                    style: Get.textTheme.labelLarge),
                              ),
                              const Spacer(),
                              ElevatedButton.icon(
                                onPressed: () {},
                                style: ElevatedButton.styleFrom(
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
                                width: 16,
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 12,
                          )
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 16, bottom: 20),
            child: Text(
              '短句见真理,喜欢请右滑动',
              style: Get.textTheme.labelLarge,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () {},
                child: CircleAvatar(
                  radius: 36,
                  backgroundColor: Colors.white,
                  child: Image.asset(
                    Imgs.ic_ting,
                    width: 28,
                    height: 28,
                  ),
                ),
              ),
              const SizedBox(
                width: 40,
              ),
              GestureDetector(
                onTap: () {
                  logic.cardSwiperController.swipeRight();
                },
                child: CircleAvatar(
                  maxRadius: 36,
                  backgroundColor: Colors.white,
                  child: Image.asset(
                    Imgs.ic_like,
                    width: 28,
                    height: 28,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 32,
          )
        ],
      ),
    );
  }
}
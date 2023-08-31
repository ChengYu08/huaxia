import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:huaxia/config/assets/imgs.dart';
import 'package:huaxia/config/config.dart';
import 'package:huaxia/widgets/card/flutter_card_swiper.dart';
import 'package:huaxia/widgets/card/src/enums.dart';

import '../../widgets/card/src/card_swiper.dart';
import 'logic.dart';
import 'model/Entence.dart';

class HomeSentencePage extends StatelessWidget {
  final logic = Get.find<HomeSentenceLogic>();



  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand  ,
      children: [
        Positioned.fill(
          child: Column(
            children: [
              Image.asset(Imgs.bg_home,width: double.infinity,fit: BoxFit.fitWidth,),
              Expanded(
                child: Container(
                  color: Get.theme.scaffoldBackgroundColor,
                  width: double.infinity,
                ),
              )
            ],
          ),
        ),
        Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.transparent,
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
          backgroundColor: Colors.transparent,
          body: Column(
            children: [
              const SizedBox(height: 10,),
              Expanded(
                child: SizedBox(
                  width: double.infinity,
                  child: AsyncBuilder<ApiResult<List<Entence>>>(
                    future: logic.futureEntence,
                    builder: (context, snapshot) {
                      final data = snapshot?.data??[];
                      if(data.isEmpty){
                        return const Center(child:  Text('当前无数据'));
                      }
                      return CardSwiper(
                        controller: logic.cardSwiperController,
                        cardsCount: data.length,
                        padding: const EdgeInsets.only(
                            top: 70, bottom: 0, left: 16, right: 16),
                        numberOfCardsDisplayed: 3,
                        scale: .9,
                        allowedSwipeDirection: AllowedSwipeDirection.symmetric(horizontal: true),
                        backCardOffset: const Offset(0, -70),
                        onLike: (like) {
                          logic.like.value = like;
                        },
                        onSwipe: (previousIndex, currentIndex, direction) {
                          final previous = data[previousIndex];
                          switch (direction) {
                            case CardSwiperDirection.left:
                              logic.entence_like('${previous.entenceId}', '0');
                              break;
                            case CardSwiperDirection.right:
                              logic.entence_like('${previous.entenceId}', '1');
                              break;
                            default:
                              break;
                          }
                          return true;
                        },
                        cardBuilder: (context, index,current) {
                          final v= data[index];
                          return Card(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20)),
                            color: Colors.white,
                            child: ValueListenableBuilder(
                              valueListenable: logic.like,
                              builder: (BuildContext context, int value, Widget? child) {
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
                                  children: [
                                    child!,
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
                                        '${v.sourceCont}',
                                        style: Get.textTheme.bodyMedium!
                                            .copyWith(fontWeight: FontWeight.bold,fontFamily: 'MaShanZheng'),
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
                                    padding: const EdgeInsets.only(left: 20, ),
                                    child: Image.asset(
                                      Imgs.ic_quotes,
                                      width: 32,
                                      height: 32,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 30, right: 30),
                                    child: Text(
                                      v.sentence??'',
                                      style: Get.textTheme.displaySmall!,
                                    ),
                                  ),
                                  const Spacer(
                                    flex: 1,
                                  ),
                                  const Padding(
                                    padding: EdgeInsets.only(
                                        left: 16, right: 16,),
                                    child: DottedLine(
                                      direction: Axis.horizontal,
                                      lineLength: double.infinity,
                                      lineThickness: .5,
                                      dashLength: 3.0,
                                      dashColor: Color(0xffE1E2E8),
                                    ),
                                  ),
                                  const Spacer(
                                    flex: 1,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 23,right: 23),
                                    child: Text(
                                      '【译文】',
                                      style: Get.textTheme.bodySmall!
                                          .copyWith(fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 10,
                                    child: Padding(
                                      padding:
                                          const EdgeInsets.symmetric(horizontal: 30),
                                      child: SingleChildScrollView(
                                        child: Text(
                                          v.interpretation??'暂无译文',
                                          style: Get.textTheme.bodySmall!.copyWith(fontFamily: 'ZCOOLXiaoWei'),
                                        ),
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
                                          label: Text('${v.commentNum}评论',
                                              style: Get.textTheme.labelLarge)),
                                      TextButton.icon(
                                        onPressed: () {},
                                        icon: Image.asset(
                                          Imgs.ic_like_no,
                                          width: 20,
                                          height: 20,
                                        ),
                                        label: Text('${v.likeNum}',
                                            style: Get.textTheme.labelLarge),
                                      ),
                                      const Spacer(),
                                      ElevatedButton.icon(
                                        onPressed: () {},
                                        style: ElevatedButton.styleFrom(
                                          padding: EdgeInsets.zero,
                                         fixedSize: Size(92, 28),
                                         minimumSize: Size(92, 28),
                                         maximumSize: Size(92, 28),

                                            backgroundColor: Color(0xffF4F5F7)),
                                        icon: Image.asset(
                                          Imgs.ic_wach,
                                          width: 20,
                                          height: 20,
                                        ),
                                        label: Text(
                                          '查看出处',
                                          style: Get.textTheme.labelLarge!.copyWith(color: Color(0xff222429)),
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
                      );
                    }
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
                    onTap: () {

                    },
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
        ),

      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:huaxia/application/tts/tts_app.dart';
import 'package:huaxia/config/assets/imgs.dart';
import 'package:huaxia/config/config.dart';
import 'package:huaxia/widgets/book_cover.dart';
import 'package:huaxia/widgets/drop_shadow_image.dart';
import 'package:slide_countdown/slide_countdown.dart';

import 'logic.dart';

class BookSpeakPage extends StatelessWidget {
  final logic = Get.find<BookSpeakLogic>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${logic.book.value.name}'),
      ),
      body: FutureBuilder(
          future: logic.book_Catalogue,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasError) {
                final f = snapshot.error as ApiResult;
                return Text(f.message);
              }
              return Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 28),
                    child: Obx(() {
                      return Text(
                        '${logic.catalogues[logic.index.value].secondCatalogue}',
                        style: Get.textTheme.displaySmall,
                      );
                    }),
                  ),
                  Container(
                    margin: const EdgeInsets.only(bottom: 20),
                    decoration: const BoxDecoration(boxShadow: [
                      BoxShadow(
                          offset: Offset(0, 2),
                          color: Colors.black26,
                          blurRadius: 10,
                          spreadRadius: 6)
                    ]),
                    child: Obx(() {
                      return BookCover(
                        title: '${logic.book.value.name}',
                        width: 165,
                        height: 226,
                      );
                    }),
                  ),
                  ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xffE1E2E8),
                          minimumSize: Size(96, 28),
                          maximumSize: Size(120, 32)),
                      child: Text(
                        '查看原文',
                        style: Get.textTheme.labelLarge,
                      )),
                  const Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      buildColumn(
                          url: Imgs.ic_time,
                          title:   ValueListenableBuilder(
                            valueListenable: logic.timeIndex,
                            builder: (BuildContext context, int value, Widget? child) {
                              if(value==0){
                                return child!;
                              }
                              return SlideCountdown(
                                streamDuration: logic.streamDuration,
                                separatorStyle: Get.textTheme.labelSmall!,
                                textStyle: Get.textTheme.labelSmall!,
                                padding: EdgeInsets.zero,
                                separatorPadding: EdgeInsets.zero,
                                decoration:BoxDecoration() ,
                                replacement: child!
                              );
                            },
                            child: Text('定时',style: Get.textTheme.labelSmall,),
                          ),function: logic.timeSetting),
                      buildColumn(
                          url: Imgs.ic_speed,
                          title: ValueListenableBuilder(
                            valueListenable: logic.ttsApp.rate,
                            builder:
                                (BuildContext context, value, Widget? child) {
                              return Text(
                                '语速${value}x',
                                style: Get.textTheme.labelSmall,
                              );
                            },
                          ),function: logic.rateSetting),
                      buildColumn(
                          url: Imgs.ic_voice,
                          title: ValueListenableBuilder(
                            valueListenable: logic.ttsApp.pitch,
                            builder: (BuildContext context,  value, Widget? child) {
                              return  Text(
                                value==0.5?'AI男声':'AI女声',
                                style: Get.textTheme.labelSmall,
                              );
                            },

                          ),function: logic.voiceSetting),

                      Obx(() {
                        if (logic.book.value.isJoin == 0) {
                          return buildColumn(
                              url: Imgs.ic_add_book,
                              title: Text(
                                '加入书架',
                                style: Get.textTheme.labelSmall,
                              ),
                              function: logic.addBook);
                        } else {
                          return const SizedBox.shrink();
                        }
                      }),
                    ],
                  ),
                  const Spacer(),
                  ValueListenableBuilder(
                    valueListenable: logic.state,
                    builder: (BuildContext context, LoadingState state,
                        Widget? child) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          buildColumn(
                              url: Imgs.ic_book,
                              title: Text(
                                '原文',
                                style: Get.textTheme.labelSmall,
                              )),
                          IconButton(
                              onPressed: state == LoadingState.suc
                                  ? logic.previous
                                  : null,
                              icon: ImageIcon(
                                AssetImage(
                                  Imgs.ic_previous,
                                ),
                                color: Colors.black,
                              )),
                          ValueListenableBuilder(
                            valueListenable: logic.ttsApp.ttsState,
                            builder:
                                (BuildContext context, value, Widget? child) {
                              return SizedBox(
                                height: 64,
                                width: 64,
                                child: Stack(
                                  children: [
                                    IconButton(
                                        onPressed: () {
                                          if (value == TtsState.playing) {
                                            logic.pause();
                                          } else {
                                            logic.play();
                                          }
                                        },
                                        icon: Image.asset(
                                          value == TtsState.playing
                                              ? Imgs.ic_pause
                                              : Imgs.ic_play,
                                          width: 64,
                                          height: 64,
                                        )),
                                    if(state!=LoadingState.suc)
                                     SizedBox(
                                        width: 64,
                                        height: 64,
                                        child: CircularProgressIndicator(strokeWidth: 2,backgroundColor:state==LoadingState.error?Colors.red:null ,))
                                  ],
                                ),
                              );
                            },
                          ),
                          IconButton(
                              onPressed: state == LoadingState.suc
                                  ?logic.next
                                  : null,
                              icon: ImageIcon(
                                AssetImage(
                                  Imgs.ic_next,
                                ),
                                color: Colors.black,
                              )),
                          buildColumn(
                              url: Imgs.ic_menu,
                              title: Text(
                                '目录',
                                style: Get.textTheme.labelSmall,
                              )),
                        ],
                      );
                    },
                  ),
                  const Spacer(
                    flex: 2,
                  ),
                ],
              );
            }
            throw ('${snapshot.error}');
          }),
    );
  }

  Widget buildColumn(
      {required String url,
      required Widget title,
      GestureTapCallback? function}) {
    return GestureDetector(
      onTap: function,
      child: Column(
        children: [
          Image.asset(
            url,
            width: 24,
            height: 24,
          ),
          title,
        ],
      ),
    );
  }
}

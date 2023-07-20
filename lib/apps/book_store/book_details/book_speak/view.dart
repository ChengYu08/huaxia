import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:huaxia/application/tts/tts_app.dart';
import 'package:huaxia/apps/book_store/book_details/book_reader/data/book_chapter.dart';
import 'package:huaxia/config/assets/imgs.dart';
import 'package:huaxia/config/config.dart';
import 'package:huaxia/widgets/book_cover.dart';
import 'package:slide_countdown/slide_countdown.dart';
import '../../model/BookList.dart';
import '../book_reader/logic.dart';
import 'logic.dart';

class BookSpeakPage extends StatefulWidget {
  final List<BookChapter> bookChapter;
  final int index;
  final String tag;
  final int bookId;
  final int isJoin;
  final String title;
  final String author;

  const BookSpeakPage(
      {required this.bookChapter, super.key, required this.tag, this.index=0, required this.bookId, this.isJoin = 0, required this.title, required this.author});

  @override
  State<BookSpeakPage> createState() => _BookSpeakPageState();
}

class _BookSpeakPageState extends State<BookSpeakPage> {
  late BookSpeakLogic logic;
  String tag = '';

  @override
  void initState() {
    final book = widget.bookChapter;
    tag = widget.tag;
    if (Get.isRegistered<BookSpeakLogic>(tag: tag)) {
      logic = Get.find<BookSpeakLogic>(tag: tag);
    } else {
      logic = Get.put<BookSpeakLogic>(BookSpeakLogic(bookChapter: book,
          bookId: widget.bookId,
          title: widget.title,
          cutterIndex: widget.index,
          author:widget.author,
          isJoin: widget.isJoin), tag: tag);
    }
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        buildPositioned(),
        Obx(() {
          return AnimatedPositioned(
            right: 0,
            left: 0,
            bottom: logic.ttsApp.showPages.value ? 0 : -Get.height,
            duration: 300.milliseconds,
            child: SizedBox(
              width: Get.width,
              height: Get.height,
              child: Scaffold(
                  appBar: AppBar(
                    leading: IconButton(onPressed: () {
                      logic.ttsApp.showPages.value = false;
                    }, icon: const Icon(Icons.keyboard_arrow_down_rounded),),
                    title: Text(widget.title),
                  ),
                  body: Obx(() {
                    final book = logic.bookChapters[logic.index.value];
                    return Column(
                      children: [
                        Padding(
                            padding: const EdgeInsets.symmetric(vertical: 28),
                            child: Text(
                              '${book.title} ${book.bookParagraph?.title ?? ''}',
                              style: Get.textTheme.displaySmall,
                            )
                        ),
                        Obx(() {
                          return IndexedStack(
                            index: logic.showBookText.value ? 1 : 0,
                            children: [
                              Center(
                                child: Container(
                                  margin: const EdgeInsets.only(bottom: 20),
                                  decoration: const BoxDecoration(boxShadow: [
                                    BoxShadow(
                                        offset: Offset(0, 2),
                                        color: Colors.black26,
                                        blurRadius: 10,
                                        spreadRadius: 6)
                                  ]),
                                  child:BookCover(
                                    title: '${book.title}',
                                    width: 165,
                                    height: 226,
                                  )
                                ),
                              ),
                              SizedBox(
                                height: 350,
                                width: double.infinity,
                                child: ValueListenableBuilder(
                                  valueListenable: logic.ttsApp.currentIndex,
                                  builder: (BuildContext context, int value,
                                      Widget? child) {
                                    return ValueListenableBuilder(
                                      valueListenable: book.bookLoadingState,
                                      builder: (BuildContext context, BookLoadingState bookState, Widget? child) {
                                        return SingleChildScrollView(
                                            controller: logic.controller,
                                            child: Builder(builder: (BuildContext context) {
                                              if (bookState ==BookLoadingState.success) {
                                                final data = book.bookParagraph!.originalArticleElement.body!.children.map((e) {
                                                  final b =
                                                      logic.ttsApp
                                                          .currentPlayText ==
                                                          e.text;
                                                  return TextSpan(
                                                      text: '${e.text}\n',
                                                      style: Get.textTheme
                                                          .bodySmall!
                                                          .copyWith(
                                                          backgroundColor: b
                                                              ? Get.theme
                                                              .primaryColor
                                                              .withOpacity(.5)
                                                              : null));
                                                }).toList();
                                                return RichText(
                                                    text: TextSpan(
                                                        children: data));
                                              } else  if(bookState ==BookLoadingState.loading){
                                                return const Center(child: CircularProgressIndicator());
                                              }else{
                                                return  Column(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  children: [
                                                    Text('${book.error}'),
                                                    TextButton(onPressed: (){logic.findBookChapter(value);
                                                    }, child: const Text('重新加载'))
                                                  ],
                                                );
                                              }
                                            },

                                            ));
                                      },

                                    );
                                  },
                                ),
                              )
                            ],
                          );
                        }),
                        Obx(() {
                          return ElevatedButton(
                              onPressed: () {
                                logic.showBookText.value =
                                !logic.showBookText.value;
                              },
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Color(0xffE1E2E8),
                                  minimumSize: Size(96, 28),
                                  maximumSize: Size(120, 32)),
                              child: Text(
                                logic.showBookText.value ? '返回' : '查看原文',
                                style: Get.textTheme.labelLarge,
                              ));
                        }),
                        const Spacer(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            buildColumn(
                                url: Imgs.ic_time,
                                title: ValueListenableBuilder(
                                  valueListenable: logic.timeIndex,
                                  builder: (BuildContext context, int value,
                                      Widget? child) {
                                    if (value == 0) {
                                      return child!;
                                    }
                                    return SlideCountdown(
                                        streamDuration: logic.streamDuration,
                                        separatorStyle: Get.textTheme
                                            .labelSmall!,
                                        textStyle: Get.textTheme.labelSmall!,
                                        padding: EdgeInsets.zero,
                                        separatorPadding: EdgeInsets.zero,
                                        decoration: BoxDecoration(),
                                        replacement: child!);
                                  },
                                  child: Text(
                                    '定时',
                                    style: Get.textTheme.labelSmall,
                                  ),
                                ),
                                function: logic.timeSetting),
                            buildColumn(
                                url: Imgs.ic_speed,
                                title: ValueListenableBuilder(
                                  valueListenable: logic.ttsApp.rate,
                                  builder:
                                      (BuildContext context, value,
                                      Widget? child) {
                                    return Text(
                                      '语速${value}x',
                                      style: Get.textTheme.labelSmall,
                                    );
                                  },
                                ),
                                function: logic.rateSetting),
                            buildColumn(
                                url: Imgs.ic_voice,
                                title: ValueListenableBuilder(
                                  valueListenable: logic.ttsApp.pitch,
                                  builder:
                                      (BuildContext context, value,
                                      Widget? child) {
                                    return Text(
                                      value == 0.5 ? 'AI男声' : 'AI女声',
                                      style: Get.textTheme.labelSmall,
                                    );
                                  },
                                ),
                                function: logic.voiceSetting),
                            Obx(() {
                              if (logic.join.value== 0) {
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
                          valueListenable: book.bookLoadingState,
                          builder: (BuildContext context,  state,
                              Widget? child) {
                            return Row(
                              mainAxisAlignment: MainAxisAlignment
                                  .spaceAround,
                              children: [
                                buildColumn(
                                    url: Imgs.ic_book,
                                    title: Text(
                                      '原文',
                                      style: Get.textTheme.labelSmall,
                                    ), function: logic.goBook),
                                IconButton(
                                    onPressed: state == BookLoadingState.success
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
                                      (BuildContext context, value,
                                      Widget? child) {
                                    return SizedBox(
                                      height: 64,
                                      width: 64,
                                      child: Stack(
                                        children: [
                                          IconButton(
                                              onPressed: () {
                                                if (value ==
                                                    TtsState.playing) {
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
                                          if (state != BookLoadingState.success)
                                            SizedBox(
                                                width: 64,
                                                height: 64,
                                                child: CircularProgressIndicator(
                                                  strokeWidth: 2,
                                                  backgroundColor:
                                                  state == BookLoadingState.error
                                                      ? Colors.red
                                                      : null,
                                                ))
                                        ],
                                      ),
                                    );
                                  },
                                ),
                                IconButton(
                                    onPressed:
                                    state == BookLoadingState.success
                                        ? logic.next
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
                  })
              ),
            ),
          );
        }),

      ],
    );
  }

  Positioned buildPositioned() {
    return Positioned(
        bottom: 80,
        left: 20,
        child: Container(
          height: 40,
          decoration: BoxDecoration(
              color: Colors.black87,
              borderRadius: BorderRadius.circular(20)
          ),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(6.0),
                child: GestureDetector(
                    onTap: () {
                      logic.ttsApp.showPages.value = true;
                    },
                    child: Image.asset(Imgs.ic_listen, width: 40, height: 40,)),
              ),
              ValueListenableBuilder(
                  valueListenable: logic.ttsApp.ttsState,
                  builder: (BuildContext context, TtsState value,
                      Widget? child) {
                    return IconButton(
                        onPressed: () {
                          if (value == TtsState.playing) {
                            logic.pause();
                          } else {
                            logic.play();
                          }
                        },
                        icon: value == TtsState.playing ? const Icon(
                          Icons.pause, color: Colors.white,) : const Icon(
                          Icons.play_arrow_rounded, color: Colors.white,));
                  }
              ),
              IconButton(onPressed: () {
                logic.ttsApp.remove();
              }, icon: const Icon(Icons.close_rounded, color: Colors.white,))
            ],
          ),
        ));
  }

  Widget buildColumn({required String url,
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

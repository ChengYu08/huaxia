import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:huaxia/application/tts/tts_app.dart';
import 'package:huaxia/apps/book_store/book_details/book_reader/data/book_chapter.dart';

import 'package:huaxia/apps/book_store/model/Chapters.dart';
import 'package:huaxia/config/config.dart';
import 'package:html/parser.dart' as htmlparser;
import 'package:html/dom.dart' as dom;
import 'package:slide_countdown/slide_countdown.dart';

import '../book_reader/data/book_paragraph.dart';
import '../book_reader/logic.dart';


class BookSpeakLogic extends GetxController {
  final int  cutterIndex;
  final List<BookChapter> bookChapter;
  final int bookId;
  final int isJoin;
  final String title;
  final String author;

  BookSpeakLogic(  {required this.bookChapter,required this.cutterIndex,required this.title,required this.bookId, required this.isJoin, required this.author});

  var index = 0.obs;


  var join = 0.obs;

  late TTSApp ttsApp;

  late final StreamDuration streamDuration;

  final ValueNotifier<int> timeIndex = ValueNotifier(0);

  var showBookText = false.obs;

  final ScrollController controller = ScrollController();

  RxList<BookChapter> bookChapters =  RxList([]);
  @override
  void onInit() {
    ttsApp = Get.find<TTSApp>();
    bookChapters.value = bookChapter;
    index.value = cutterIndex;
    if(bookChapters.length>=3){
      List.generate(3, (index) => findBookChapter(index));
    }
    ///当前全部播放完成
    ttsApp.setDownCallback(() {
      next();
    });

    ///当前一段播放中的文字
    ttsApp.setCurrentCallback((int index, String speakText) {
      Get.log('=当前播放index:$index==speakText:$speakText');
      if(controller.position.haveDimensions) {
        double max =  controller.position.maxScrollExtent/ttsApp.playList.length;
        controller.jumpTo(1);
        controller.animateTo(max*index, duration: 400.milliseconds, curve: Curves.linear);
      }

    });
    super.onInit();
  }

  @override
  void onClose() {
    ttsApp.stop();
    super.onClose();
  }

  void addBook() {
    final c = AppLoading.loading();
    Api.book_shelf_add('$bookId').then((value) {
      c();
      if (value.success) {
        AppToast.toast('加入成功');
        join.value = 1;
      } else {
        AppToast.toast(value.message);
      }
    }).catchError((e) {
      AppToast.toast(e.message);
      c();
    });
  }

  void goBook() {
   ttsApp.colsePages();
    if (Get.currentRoute != Routers.bookReaderPage && !Get.isRegistered<BookReaderLogic>(tag: '$bookId')) {
      Get.toNamed(Routers.bookReaderPage, arguments: bookChapters.value, parameters: {
        'bookId': '$bookId',
        'title': title,
        'author': author,
        'isJoin': '${join.value}',
        'index': '${index.value}',
      });
    }

  }
  timeSetting(){
    Get.bottomSheet(
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const SizedBox(
                  width: 50,
                ),
                Text(
                  '时间设置',
                  style: Get.textTheme.titleSmall,
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: IconButton(
                      onPressed: () {
                        if (Get.isOverlaysOpen) {
                          Get.back();
                        }
                      },
                      icon: const Icon(Icons.close_rounded)),
                )
              ],
            ),
            ListTile(
              onTap: () async{
                timeIndex.value =30;
                 streamDuration.change(30.minutes);
                 streamDuration.play();
                if (Get.isOverlaysOpen) {
                  Get.back();
                }
              },
              title: const Text('30分钟'),

            ),
            ListTile(
              onTap: () async{
                timeIndex.value =60;
                streamDuration.change(60.minutes);
                streamDuration.play();
                if (Get.isOverlaysOpen) {
                  Get.back();
                }
              },
              title: const Text('60分钟'),

            ),
            ListTile(
              onTap: () async{
                timeIndex.value =90;
                streamDuration.change(90.minutes);
                streamDuration.play();
                if (Get.isOverlaysOpen) {
                  Get.back();
                }
              },
              title: const Text('90分钟'),

            ),
          ],
        ),
        backgroundColor: Colors.white);
  }

  voiceSetting() {
    Get.bottomSheet(
        ValueListenableBuilder(
          valueListenable: ttsApp.pitch,
          builder: (BuildContext context, value, Widget? child) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: 50,
                    ),
                    Text(
                      '声音设置',
                      style: Get.textTheme.titleSmall,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: IconButton(
                          onPressed: () {
                            if (Get.isOverlaysOpen) {
                              Get.back();
                            }
                          },
                          icon: const Icon(Icons.close_rounded)),
                    )
                  ],
                ),
                ListTile(
                  onTap: () async{
                    ttsApp.pitch.value = 0.5;
                    await ttsApp.setPitch();
                    await ttsApp.pause();
                    await play();
                    if (Get.isOverlaysOpen) {
                      Get.back();
                    }
                  },
                  title: const Text('AI男声'),
                  trailing: value ==0.5
                      ? Icon(
                          Icons.check,
                          color: Get.theme.primaryColor,
                        )
                      : null,
                ),
                ListTile(
                  onTap: () async{
                    ttsApp.pitch.value = 2.0;
                   await ttsApp.setPitch();
                    await ttsApp.pause();
                    await play();
                    if (Get.isOverlaysOpen) {
                      Get.back();
                    }
                  },
                  title: const Text('AI女声'),
                  trailing: value ==2.0
                      ? Icon(
                          Icons.check,
                          color: Get.theme.primaryColor,
                        )
                      : null,
                ),
              ],
            );
          },
        ),
        backgroundColor: Colors.white);
  }

  rateSetting() {
    Get.bottomSheet(
        ValueListenableBuilder(
          valueListenable: ttsApp.rate,
          builder: (BuildContext context, double value, Widget? child) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: 50,
                    ),
                    Text(
                      '语速设置',
                      style: Get.textTheme.titleSmall,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: IconButton(
                          onPressed: () {
                            if (Get.isOverlaysOpen) {
                              Get.back();
                            }
                          },
                          icon: const Icon(Icons.close_rounded)),
                    )
                  ],
                ),
                for (double i = ttsApp.minRate; i <= ttsApp.maxRate; i += 0.25)
                  _listTitle(i),
              ],
            );
          },
        ),
        backgroundColor: Colors.white);
  }

  Container _listTitle(double v) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
          border: Border(
              bottom: BorderSide(
                  color: Get.theme.dividerColor.withOpacity(.5), width: .5))),
      child: ListTile(
          onTap: () async {
            await ttsApp.setSpeechRate(v);
            await ttsApp.pause();
            await play();
            if (Get.isOverlaysOpen) {
              Get.back();
            }
          },
          leading: Text(
            '${v}X',
            style: Get.textTheme.bodySmall,
          ),
          trailing: ttsApp.rate.value == v
              ? Icon(
                  Icons.check,
                  color: Get.theme.primaryColor,
                )
              : null),
    );
  }




  previous() {
    if (index.value > 0) {
      index--;
      ttsApp.cleanPlayList();
      play();
    } else {
      AppToast.toast('当前已经是第一页');
    }
  }
  next() {
    if (index < bookChapters.length) {
      index++;
      ttsApp.cleanPlayList();
      play();
    } else {
      AppToast.toast('当前已经是最后一页');
    }
  }

  Future pause() async {

    final d = await ttsApp.pause();
    return d;
  }

  play() async {
    final speakText =await findBookChapter(index.value).catchError((e){
      AppToast.toast('${e.message}');
    });
      if(speakText.bookParagraph!=null){
        List<String>  textList= speakText.bookParagraph!.originalArticleElement.body?.children.map((e) => e.text).toList()??[];
        ttsApp.playList = textList;
        await ttsApp.speak();
      }
  }



  Future<BookChapter>   findBookChapter(int index) async{
    BookChapter chapter= bookChapter[index];
    try{
      if (chapter.bookParagraph==null) {
        final paragraph = await addBookChapters(chapter);
        if(paragraph!=null){
          chapter.bookParagraph = paragraph;
        }
      }
      return chapter;
    }catch( e){
      final error = e as ApiResult;
      chapter.error = error.message;
      chapter.bookLoadingState.value = BookLoadingState.error;
      return  chapter;
    }
  }

  Future<BookParagraph? > addBookChapters(BookChapter  bookChapter) async {
    bookChapter.bookLoadingState.value = BookLoadingState.loading;
    try{
      final chapter=  await Api.book_Chapters(bookId: bookId, chaptersId: bookChapter.paragraphId);
      if(chapter.success){
        BookParagraph bookParagraph = BookParagraph(paragraphId: bookChapter.paragraphId,
            originalArticle: chapter.data!.cont,
            translationArticle: chapter.data!.translation,
            explinArticle: chapter.data!.chapters
        );

        bookChapter.bookLoadingState.value = BookLoadingState.success;
        return bookParagraph;
      }else{
        bookChapter.error = chapter.message;
        bookChapter.bookLoadingState.value = BookLoadingState.error;
        return null;
      }
    }catch(e){
      final error = e as ApiResult;
      bookChapter.error = error.message;
      bookChapter.bookLoadingState.value = BookLoadingState.error;
      return null;
    }

  }


}

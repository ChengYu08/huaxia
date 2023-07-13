import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:huaxia/application/tts/tts_app.dart';
import 'package:huaxia/apps/book_store/model/BookList.dart';
import 'package:huaxia/apps/book_store/model/Catalogue.dart';
import 'package:huaxia/apps/book_store/model/Chapters.dart';
import 'package:huaxia/config/config.dart';
import 'package:html/parser.dart' as htmlparser;
import 'package:html/dom.dart' as dom;
import 'package:slide_countdown/slide_countdown.dart';

enum LoadingState { suc, loading, error }

class BookSpeakLogic extends GetxController {
  var book = BookList().obs;
  RxList<Catalogue> catalogues = RxList([]);
  final ValueNotifier<LoadingState> state = ValueNotifier(LoadingState.loading);
  RxMap<int, List<dom.Element>> speakMap = RxMap({});
  var index = 0.obs;
  late Future book_Catalogue;
  late TTSApp ttsApp;
  late final StreamDuration streamDuration;
  final ValueNotifier<int> timeIndex = ValueNotifier(0);
  var showBookText = false.obs;
  final ScrollController controller = ScrollController();
  @override
  void onInit() {
    initTTS();
    book.value = Get.arguments as BookList;

    streamDuration = StreamDuration(
      30.minutes,
      autoPlay: false,
      onDone: (){
        ttsApp.stop();
        ttsApp.cleanPlayList();
        timeIndex.value =0;
      }
    );

    initBook();
    super.onInit();
  }

  void initTTS() {
    ttsApp = Get.find<TTSApp>();
    ttsApp.setDownCallback(() {
      next();
    });
    ttsApp.setCurrentCallback((int index, String speakText) {
        Get.log('=当前播放index:$index==speakText:$speakText');
        if(controller.position.haveDimensions) {
          double max =  controller.position.maxScrollExtent/ttsApp.playList.length;
          controller.jumpTo(1);
          controller.animateTo(max*index, duration: 400.milliseconds, curve: Curves.linear);
        }

    });
  }

  @override
  void onClose() {
    ttsApp.stop();
    super.onClose();
  }

  void addBook() {
    final c = AppLoading.loading();
    Api.book_shelf_add('${book.value.bookId}').then((value) {
      c();
      if (value.success) {
        AppToast.toast('加入成功');
        book.update((val) {
          val?.isJoin = 1;
        });
      } else {
        AppToast.toast(value.message);
      }
    }).catchError((e) {
      AppToast.toast(e.message);
      c();
    });
  }
  timeSetting(){
    Get.bottomSheet(
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
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

  void initBook() {
    book_Catalogue = Api.book_Catalogue(book.value.bookId!).then((value) {
      if (value.success) {
        catalogues.value = value.data ?? [];
        if (catalogues.first.bookCatalogueId != null) {
          Api.book_Chapters(
                  bookId: book.value.bookId!,
                  chaptersId: catalogues.first.bookCatalogueId!)
              .then((value) {
            state.value = LoadingState.suc;
            _asyncMap(value.data?.cont ?? '');
          }).catchError((e) {
            AppToast.toast(e.message);
            state.value = LoadingState.error;
          });
        }
      } else {
        AppToast.toast(value.message);
        Get.back();
      }
      return value;
    }).catchError((e) {
      AppToast.toast(e.message);
      return e;
    });
  }

  List<dom.Element> _asyncMap(String text) {
    final  speakText = htmlparser.parse(text).body;
    speakMap[index.value] = speakText?.children??[];
    return speakText?.children??[];
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
    if (index < catalogues.length) {
      index++;
      ttsApp.cleanPlayList();
      play();
    } else {
      AppToast.toast('当前已经是最后一页');
    }
  }

  Future pause() async {
    state.value = LoadingState.loading;
    final d = await ttsApp.pause();
    if (d == 1) {
      state.value = LoadingState.suc;
    } else {
      state.value = LoadingState.error;
    }
  }
  Future<List<dom.Element>> spText()async{
    try{
      if (speakMap.containsKey(index.value)) {
        final  speak = speakMap[index.value];
        if (speak != null && speak.isNotEmpty) {
          return speak;
        } else {
          final data =await getCatalogues();
          if(data.success){
            final  speakText = _asyncMap(data.data?.cont ?? '');
            return speakText;
          }else{
            return [];
          }
        }
      } else {
        final data = await getCatalogues();
        if(data.success){
          final  speakText = _asyncMap(data.data?.cont ?? '');
          return speakText;
        }else{
          return [];
        }
      }
    }catch(e){
      return [];
    }

  }
  play() async {
    state.value = LoadingState.loading;
    final speakText =await spText().catchError((e){
      state.value = LoadingState.error;
      AppToast.toast('${e.message}');
    });
      if(speakText.isNotEmpty){
        state.value = LoadingState.suc;
        ttsApp.playList = speakText.map((e) => e.text).toList();
        await ttsApp.speak();
      }else{
        state.value = LoadingState.suc;
      }
  }

  Future<ApiResult<Chapters>> getCatalogues() {
    final data = Api.book_Chapters(
        bookId: book.value.bookId!,
        chaptersId: catalogues[index.value].bookCatalogueId!);
    return data;
  }


}

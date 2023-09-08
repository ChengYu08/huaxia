import 'package:flutter/cupertino.dart';
import 'package:flutter_tts/flutter_tts.dart';

import 'package:get/get.dart';
import 'package:huaxia/apps/book_store/book_details/book_reader/data/book_chapter.dart';
import 'package:huaxia/apps/book_store/book_details/book_speak/view.dart';
import 'package:huaxia/apps/book_store/model/BookList.dart';

enum TtsState { playing, stopped, paused, continued, down }

typedef CurrentCallback = void Function(int index, String speakText);
typedef DownCallback = void Function();

class TTSApp extends GetxService {
  late FlutterTts flutterTts;

  final ValueNotifier<TtsState> ttsState = ValueNotifier(TtsState.stopped);

  ///音量
  final ValueNotifier<double> volume = ValueNotifier(0.8);

  ///语速
  final ValueNotifier<double> rate = ValueNotifier(1.0);

  ///音调
  final ValueNotifier<double> pitch = ValueNotifier(0.5);

  final ValueNotifier<int> currentIndex = ValueNotifier(0);
  CurrentCallback? currentCallback;
  DownCallback? downCallback;
  List<String> playList = [];
  double minRate = 0.0;
  double maxRate = 2.0;

  String? get currentPlayText {
    if (playList.isNotEmpty) {
      return playList[currentIndex.value];
    } else {
      return null;
    }
  }

  OverlayEntry? _entry;
  final ValueNotifier<bool> showBookSpeak = ValueNotifier(false);
  var showPages = true.obs;

  @override
  void onInit() {
    initTts();
    super.onInit();
  }

  openSpeakPage(BuildContext context,
      {required List<BookChapter> bookChapter,
      required String tag,
      int index = 0,
      required int bookId,
      int isJoin = 0,
      required String title,
      required String author}) {
    showPages.value = true;
    _entry = OverlayEntry(
      builder: (context) {
        return BookSpeakPage(
          bookChapter: bookChapter,
          tag: tag,
          bookId: bookId,
          title: title,
          index: index,
          isJoin: isJoin,
          author: author,
        );
      },
      opaque: false,
      maintainState: true
    );
    Overlay.of(context).insert(_entry!);
    showBookSpeak.value = true;
  }

  ///关闭听书页面【继续后台听歌】
  colsePages() {
    showPages.value = false;
  }

  remove() {
    if (_entry != null) {
      showPages.value = false;
      showBookSpeak.value = false;
      flutterTts.stop();
      _entry!.remove();
      _entry = null;
    }
  }

  initTts() async {
    flutterTts = FlutterTts();
    await flutterTts.setLanguage('zh-CN');
    await flutterTts.setSpeechRate(rate.value);
    await flutterTts.setPitch(pitch.value);
    _setAwaitOptions();
    if (GetPlatform.isAndroid) {
      _getDefaultEngine();
      await flutterTts.setQueueMode(1);
    }

    if (GetPlatform.isAndroid) {
      flutterTts.setInitHandler(() {
        Get.log('==Android初始化完成==');
        flutterTts.getEngines.then((value) {
          if (value is List) {
            value.forEach((element) {
              Get.log('=getEngines==$element');
            });
          }
        });
      });
    }

    /// iOS only
    if (GetPlatform.isIOS) {
      flutterTts.setSharedInstance(true);
      flutterTts.setIosAudioCategory(IosTextToSpeechAudioCategory.ambient, [
        IosTextToSpeechAudioCategoryOptions.allowBluetooth,
        IosTextToSpeechAudioCategoryOptions.allowBluetoothA2DP,
        IosTextToSpeechAudioCategoryOptions.mixWithOthers
      ]);
    }

    flutterTts.setStartHandler(() {
      Get.log('==TTS开始播放==');
      ttsState.value = TtsState.playing;
    });

    ///当前一段播放完成
    flutterTts.setCompletionHandler(() {
      ///如果播放列表里面还有剩余的播放item则继续播放
      if (playList.isNotEmpty) {
        currentIndex.value += 1;

        ///已经播放到最后一条告知已经播放完成
        ///清空当前播放列表和更新index
        if (currentIndex.value == playList.length) {
          downCallback?.call();
          playList.clear();
          currentIndex.value = 0;
          ttsState.value = TtsState.down;

          ///当前播放的列表继续下跳正常播放
        } else if (currentIndex.value < playList.length) {
          ttsState.value = TtsState.continued;
          speak();
          currentCallback?.call(
              currentIndex.value, playList[currentIndex.value]);
        }

        ///当前已经全部播放完成
      } else {
        downCallback?.call();
        playList.clear();
        currentIndex.value = 0;
        ttsState.value = TtsState.down;
      }
    });

    flutterTts.setCancelHandler(() {
      Get.log('==TTS当前播放已取消==');
      ttsState.value = TtsState.stopped;
    });

    flutterTts.setPauseHandler(() {
      Get.log('==TTS当前播放已暂停==');
      ttsState.value = TtsState.paused;
    });

    flutterTts.setContinueHandler(() {
      Get.log('==TTS当前播放继续进行==');
      ttsState.value = TtsState.playing;
    });

    flutterTts.setErrorHandler((msg) {
      Get.log('==TTS当前播放遇到错误==');
      ttsState.value = TtsState.stopped;
    });
    flutterTts.setProgressHandler((text, start, end, word) {
      Get.log("text:$text==start:$start==end:$end==word:$word");
    });
    flutterTts.getSpeechRateValidRange.then((value) {
      minRate = value.min;
      maxRate = value.max;
    });
  }

  void setCurrentCallback(CurrentCallback callback) {
    currentCallback = callback;
  }

  void setDownCallback(DownCallback callback) {
    downCallback = callback;
  }

  Future _getDefaultEngine() async {
    var engine = await flutterTts.getDefaultEngine;
    if (engine != null) {
      await flutterTts.setEngine(engine);
      Get.log('_getDefaultEngine:$engine');
    }
    var e = await flutterTts.getEngines;
    Get.log('=getEngines=$e');
    var v = await flutterTts.getVoices;
    Get.log('=getVoices=$v');
    var s = await flutterTts.getDefaultVoice;
    Get.log('=getDefaultVoice=$s');
  }

  Future setVolume() {
    return flutterTts.setVolume(volume.value);
  }

  Future setSpeechRate(double d) {
    rate.value = d;
    return flutterTts.setSpeechRate(rate.value);
  }

  Future setPitch() {
    return flutterTts.setPitch(pitch.value);
  }

  cleanPlayList() {
    playList.clear();
    currentIndex.value = 0;
  }

  Future<dynamic> speak() async {
    if (playList.isNotEmpty) {
      return flutterTts.speak(playList[currentIndex.value]).then((value) {
        ttsState.value = TtsState.playing;
        return value;
      });
    } else {
      return -1;
    }
  }

  Future _setAwaitOptions() async {
    await flutterTts.awaitSpeakCompletion(true);
  }

  Future stop() async {
    cleanPlayList();
    var result = await flutterTts.stop();
    if (result == 1) {
      ttsState.value = TtsState.stopped;
    }
    return result;
  }

  Future pause() async {
    var result = await flutterTts.pause();
    if (result == 1) {
      ttsState.value = TtsState.paused;
      Get.log('pause:$result');
    }

    return result;
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter_tts/flutter_tts.dart';

import 'package:get/get.dart';

enum TtsState { playing, stopped, paused, continued }

class TTSApp extends GetxService {
  late FlutterTts flutterTts;

  final ValueNotifier<TtsState> ttsState = ValueNotifier(TtsState.stopped);

  ///音量
  final ValueNotifier<double> volume = ValueNotifier(0.8);

  ///语速
  final ValueNotifier<double> rate = ValueNotifier(1.0);

  ///音调
  final ValueNotifier<double> pitch = ValueNotifier(0.5);


  double minRate = 0.0;
  double maxRate =2.0;
  @override
  void onInit() {
    initTts();
    super.onInit();
  }

  initTts() {
    flutterTts = FlutterTts();
    flutterTts.setLanguage('zh-CN');
    flutterTts.setSpeechRate(rate.value);
    _setAwaitOptions();
    if (GetPlatform.isAndroid) {
      _getDefaultEngine();
      flutterTts.setQueueMode(1);

    }

    if (GetPlatform.isAndroid) {
      flutterTts.setInitHandler(() {
        Get.log('==Android初始化完成==');
        flutterTts.getEngines.then((value) {
          if(value is List){
            value.forEach((element) {
              Get.log('=getEngines==$element');
            });
          }
        });
      });
    }
    /// iOS only
    if(GetPlatform.isIOS){
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
  Future _getDefaultEngine() async {
    var engine = await flutterTts.getDefaultEngine;
    if (engine != null) {
      await flutterTts.setEngine(engine);
      Get.log('_getDefaultEngine:$engine');
    }
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

  Future speak(String speak) {
    return flutterTts.speak(speak).then((value) {
      ttsState.value = TtsState.playing;
      return value;
    });

  }

  Future _setAwaitOptions() async {
    await flutterTts.awaitSpeakCompletion(true);
  }

  Future stop() async {
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

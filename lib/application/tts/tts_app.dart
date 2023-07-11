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
    _setAwaitOptions();
    /// iOS only
    if(GetPlatform.isIOS){

       flutterTts.setSharedInstance(true);
       flutterTts.setIosAudioCategory(IosTextToSpeechAudioCategory.ambient, [
         IosTextToSpeechAudioCategoryOptions.allowBluetooth,
         IosTextToSpeechAudioCategoryOptions.allowBluetoothA2DP,
         IosTextToSpeechAudioCategoryOptions.mixWithOthers
       ]);
    }
    if(GetPlatform.isAndroid){
      flutterTts.setQueueMode(1);
    }

    flutterTts.setStartHandler(() {
      Get.log('==TTS开始播放==');
      ttsState.value = TtsState.playing;
    });

    if (GetPlatform.isAndroid) {
      flutterTts.setInitHandler(() {
        Get.log('==Android初始化完成==');
      });
    }

    flutterTts.setCompletionHandler(() {
      Get.log('==TTS播放完成==');
      ttsState.value = TtsState.stopped;
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
      rate.value = value.normal;
      minRate = value.min;
      maxRate = value.max;
    });
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

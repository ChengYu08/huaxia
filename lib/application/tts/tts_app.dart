
import 'dart:io';

import 'package:flutter_tts/flutter_tts_web.dart';
import 'package:get/get.dart';
import 'package:flutter_tts/flutter_tts.dart';

class TTSApp extends GetxService{
  late FlutterTts flutterTts;
  var ttsState = TtsState.stopped.obs;
  String? engine;
  String? language;
  @override
  void onInit() {
    initTts();
    super.onInit();
  }
  initTts() {
    flutterTts = FlutterTts();

    _setAwaitOptions();
    flutterTts.setLanguage('cn');
    if (Platform.isAndroid) {
      _getDefaultEngine();
      _getDefaultVoice();
    }

    flutterTts.setStartHandler(() {
      ttsState.value = TtsState.playing;
    });

    if (Platform.isAndroid) {
      flutterTts.setInitHandler(() {
        print("TTS Initialized");
      });
    }

    flutterTts.setCompletionHandler(() {
      print("Complete");
      ttsState.value = TtsState.stopped;
    });

    flutterTts.setCancelHandler(() {
      ttsState.value = TtsState.stopped;
    });

    flutterTts.setPauseHandler(() {
      ttsState.value = TtsState.paused;
    });

    flutterTts.setContinueHandler(() {
      ttsState.value = TtsState.continued;
    });

    flutterTts.setErrorHandler((msg) {
      ttsState.value = TtsState.stopped;
    });
  }
  Future _getDefaultEngine() async {
    var engine = await flutterTts.getDefaultEngine;
    if (engine != null) {
      print(engine);
    }
  }

  Future _getDefaultVoice() async {
    var voice = await flutterTts.getDefaultVoice;
    if (voice != null) {
      print(voice);
    }
  }

  Future _setAwaitOptions() async {
    await flutterTts.awaitSpeakCompletion(true);
  }
  Future stop() async {
    var result = await flutterTts.stop();
    if (result == 1) ttsState.value = TtsState.stopped;
  }

  Future pause() async {
    var result = await flutterTts.pause();
    if (result == 1)ttsState.value = TtsState.paused;
  }


  void changedEnginesDropDownItem(String? selectedEngine) async {
    await flutterTts.setEngine(selectedEngine!);
    language = null;
    engine = selectedEngine;
  }

}
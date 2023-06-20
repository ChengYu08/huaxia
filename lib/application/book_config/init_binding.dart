
import 'package:get/get.dart';
import 'package:huaxia/application/book_config/app_book_config.dart';
import 'package:huaxia/application/tts/tts_app.dart';

class InitBinding extends Bindings{
  @override
  void dependencies() {
      Get.put(AppBookConfig());
      Get.put(TTSApp());
  }

}
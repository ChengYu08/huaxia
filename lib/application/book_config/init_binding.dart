
import 'package:get/get.dart';
import 'package:huaxia/application/book_config/app_book_config.dart';
import 'package:huaxia/application/tts/tts_app.dart';
import 'package:huaxia/apps/login/logic.dart';

class InitBinding extends Bindings{
  @override
  void dependencies() {
      Get.put(AppBookConfig());
      Get.lazyPut(() => TTSApp());
      Get.put(LoginLogic());
  }

}
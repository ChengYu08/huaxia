
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:huaxia/application/book_config/book_config.dart';
const String  kBookConfigBox = 'bookConfigBox';
class AppBookConfig extends GetxService {
  late Box<BookConfig> bookConfigBox;

  late ValueNotifier<BookConfig> bookConfigVN;
  @override
  void onInit() {

      initBox();

  }

  @override
  void onClose() {

  }

  @override
  void onReady() {

  }

  void initBox() async{
    Hive.openBox<BookConfig>(kBookConfigBox).then((value) {
      bookConfigBox = value;
      bookConfigVN =ValueNotifier( bookConfigBox.get(kBookConfigBox,defaultValue: BookConfig())!);
    });

  }
}
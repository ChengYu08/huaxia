
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:huaxia/application/book_config/book_config.dart';
const String  kBookConfigBox = 'bookConfigBox';
const String  myBookConfigBox = 'myBookConfigBox';
//flutter packages pub run build_runner build
class AppBookConfig extends GetxService {
  late Box<BookConfig> bookConfigBox;

  late ValueNotifier<BookConfig>   bookConfigVN =ValueNotifier(BookConfig());
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
  Future  upBookConfig(BookConfig config){
    bookConfigVN.notifyListeners();
   return bookConfigBox.put(myBookConfigBox, config);

   }
  void initBox() async{
    Hive.openBox<BookConfig>(kBookConfigBox).then((value) {
      bookConfigBox = value;
      BookConfig? config= bookConfigBox.get(myBookConfigBox);
      if(config!=null){
        bookConfigVN.value = config;
        print("=====${bookConfigVN.value.textSize}");
      }

    });

  }
}
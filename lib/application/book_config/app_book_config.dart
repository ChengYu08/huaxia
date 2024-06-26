
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:huaxia/application/book_config/book_config.dart';
import 'package:huaxia/config/config.dart';
const String  kBookConfigBox = 'bookConfigBox';
const String  myBookConfigBox = 'myBookConfigBox';
//flutter packages pub run build_runner build
class AppBookConfig extends GetxService {
  late Box<BookConfig> bookConfigBox;

  late ValueNotifier<BookConfig>   bookConfigVN =ValueNotifier(BookConfig());
  @override
  void onInit() {
    AppWidget.upWidgetData(title: '汉皇重色思倾国\n御宇多年求不得\n杨家有女初长成\n养在深闺人未识\n',message: '《白居易》');
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
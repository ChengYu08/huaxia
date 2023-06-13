
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:huaxia/application/book_config/app_book_config.dart';
import 'package:huaxia/apps/book_store/book_details/book_reader/logic.dart';

class BookTextStyleMenu extends StatelessWidget {
  final BookReaderLogic bookReaderLogic;
  const BookTextStyleMenu({Key? key,required this.bookReaderLogic}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final appConfig = Get.find<AppBookConfig>();
    return Obx(() {
      return AnimatedPositioned(
        left: 0,
        right: 0,
        bottom:bookReaderLogic.m4.value?0: -(Get.height * .75 + kBottomNavigationBarHeight),
        duration: 300.milliseconds,
        child:Container(
          padding: const EdgeInsets.symmetric(vertical: 20,horizontal: 16),
          width: double.infinity,
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(topRight: Radius.circular(20),topLeft: Radius.circular(20)
            ),
          ),
          child: ValueListenableBuilder(valueListenable:appConfig.bookConfigVN,
            builder: (BuildContext context, value, Widget? child) {
            return Column(
              children: [
                SizedBox(
                  height: 400,
                  child: Slider(value: value.textSize,
                      min: 16,
                      max: 40,
                      onChangeEnd: (v){
                        value.textSize= v;
                       value.save();
                      },
                      onChanged: (v){
                        value.textSize= v;
                        appConfig.bookConfigVN.notifyListeners();
                  }),
                )
              ],
            );
            },)
        ),
      );
    });
  }
}

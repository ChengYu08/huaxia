

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:huaxia/apps/book_store/book_details/book_reader/logic.dart';
import 'package:screen_brightness/screen_brightness.dart';

import 'my_slider_component_shape.dart';

class BookScreenBrightness extends StatelessWidget {
  final BookReaderLogic bookReaderLogic;
   BookScreenBrightness({super.key, required this.bookReaderLogic});

  final ValueNotifier<double> brig = ValueNotifier(50);

  @override
  Widget build(BuildContext context) {

    return Obx(() {
      return AnimatedPositioned(
        left: 0,
        right: 0,
        bottom:bookReaderLogic.m3.value?0:-(Get.height),
        duration: 300.milliseconds,
        child:Container(
          margin: const EdgeInsets.only(bottom: kBottomNavigationBarHeight),
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 24,horizontal: 16),

          color: Colors.white,
          child: Theme(
            data: Get.theme.copyWith(
                sliderTheme: SliderThemeData(
                    trackHeight: 32,
                    activeTrackColor: Color(0xffE7E7E7),
                    inactiveTrackColor: Color(0xffF4F5F7),
                    thumbColor: Colors.white,
                    disabledThumbColor: Get.theme.primaryColor,
                    trackShape: MyRoundedRectSliderTrackShape(),
                    thumbShape: const MySliderComponentShape(
                        enabledThumbRadius: 18,
                        fontFamily: 'MaterialIcons',
                        t1:"\ue80a",
                        t2: "\ue80a"))),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
            FutureBuilder<double>(
              future: bookReaderLogic.brightness.then((value) {
                brig.value = value*10;
                return value;
              }),

              builder: (context, snapshot) {
                return ValueListenableBuilder(valueListenable: brig,
                    builder: (context,data,child){
                  print("==23====$data");
                  return Slider(value: brig.value,
                    min: 20.0,
                    max: 100.0,
                    divisions: 20,
                    onChanged: (i){
                      brig.value = i;
                    },onChangeEnd: (v){
                      ScreenBrightness().setScreenBrightness(v/10);
                    },);
                });

              }
            ),
                SizedBox(height: 300,)
              ],
            ),
          ),
        ),
      );
    });
  }
}

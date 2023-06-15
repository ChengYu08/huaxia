import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:huaxia/application/book_config/app_book_config.dart';
import 'package:huaxia/apps/book_store/book_details/book_reader/logic.dart';
import 'package:screen_brightness/screen_brightness.dart';

import 'my_slider_component_shape.dart';

class BookScreenBrightness extends StatelessWidget {
  final BookReaderLogic bookReaderLogic;

  BookScreenBrightness({super.key, required this.bookReaderLogic});

  final ValueNotifier<double> brig = ValueNotifier(50);

  final List<BookTheme> bookThemes=[
    BookTheme(theme: 1,mainColor: Colors.white),
    BookTheme(theme: 2,mainColor: Colors.black),
    BookTheme(theme: 3,mainColor: Color(0xff32C5FF)),
    BookTheme(theme: 4,mainColor: Color(0xff44D7B6)),
    BookTheme(theme: 5,mainColor: Color(0xff6DD400)),
  ];
  @override
  Widget build(BuildContext context) {
    final appConfig = Get.find<AppBookConfig>();
    return Obx(() {
      return AnimatedPositioned(
        left: 0,
        right: 0,
        bottom: bookReaderLogic.m3.value ? 0 : -180,
        duration: 300.milliseconds,
        child: Container(
          width: double.infinity,
          height: 180,
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(20), topLeft: Radius.circular(20)),
          ),
          padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),

          child: Theme(
            data: Get.theme.copyWith(
                radioTheme: RadioThemeData(),
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
                        t1: "\ue80a",
                        t2: "\ue80a"))),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ValueListenableBuilder(
                    valueListenable: brig,
                    builder: (context, data, child) {

                      return Slider(
                        value: brig.value,
                        min: 0,
                        max: 100.0,
                        divisions: 20,
                        onChanged: (i) {
                          brig.value = i;
                        },
                        onChangeEnd: (v) {
                          ScreenBrightness().setScreenBrightness(v / 100);
                        },
                      );
                    }),
                Padding(
                  padding: const EdgeInsets.only(top: 24,),
                  child: ValueListenableBuilder(
                    valueListenable: appConfig.bookConfigVN,
                    builder: (BuildContext context, value, Widget? child) {
                    BookTheme b = bookThemes.singleWhere((element) => element.theme==value.bookThem);
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: bookThemes.map((e) {
                          return RadioBookTheme(value: e, child:CircleAvatar(
                            backgroundColor: e.mainColor,
                            radius: 18,
                          ),onChanged: (v){
                            b = v!;
                            value.bookThem=b.theme;
                            appConfig.upBookConfig(value);
                          },
                          groupValue: b,
                          );

                        }).toList(),
                      );

                    },

                  ),
                )
              ],
            ),
          ),
        ),
      );
    });
  }
}

class RadioBookTheme<T> extends StatelessWidget {
  /// The value represented by this radio button.
  final T value;

  final T? groupValue;

  final ValueChanged<T?>? onChanged;
  final Widget child;

  const RadioBookTheme(
      {Key? key,
      required this.value,
      this.groupValue,
      this.onChanged,
      required this.child})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    BoxBorder? border;
    if (value == groupValue) {
      border = Border.all(color: Get.theme.primaryColor, width: 2);
    } else {
      border = null;
    }

    return InkWell(
        onTap: () {
          onChanged!.call(value);
        },
        child: Container(
          padding: const EdgeInsets.all(2),
            decoration: BoxDecoration(shape: BoxShape.circle, border: border),
            child: child));
  }
}

class BookTheme{
  final int theme;
  final Color mainColor;

  BookTheme( {this.theme=1, this.mainColor=Colors.white,});
}
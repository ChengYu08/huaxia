import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:huaxia/application/book_config/app_book_config.dart';
import 'package:huaxia/application/book_config/book_config.dart';
import 'package:huaxia/apps/book_store/book_details/book_reader/logic.dart';
import 'package:huaxia/config/assets/imgs.dart';

import 'my_slider_component_shape.dart';

class BookTextStyleMenu extends StatelessWidget {
  final BookReaderLogic bookReaderLogic;

  const BookTextStyleMenu({Key? key, required this.bookReaderLogic})
      : super(key: key);


  openPageType(AppBookConfig appBookConfig){
    Get.bottomSheet(ValueListenableBuilder(
      valueListenable: appBookConfig.bookConfigVN,
      builder: (BuildContext context, value, Widget? child) {
        return Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Icon(Icons.expand_more_outlined,color: Colors.black,),
                  Text('翻页方式',style: Get.textTheme.titleMedium,),
                  const SizedBox(width: 24,)
                ],
              ),
              const SizedBox(height: 43,),
              GestureDetector(
                onTap: (){
                  value.readModel=ReadModel.simulationView;
                  appBookConfig.upBookConfig(value);
                },
                behavior: HitTestBehavior.translucent,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 17),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('仿真翻页',style: Get.textTheme.bodyLarge,),
                      if(  value.readModel==ReadModel.simulationView)
                      Icon(Icons.check,color: Get.theme.primaryColor,)
                    ],
                  ),
                ),
              ),

              GestureDetector(
                onTap: (){
                  value.readModel=ReadModel.pageView;
                  appBookConfig.upBookConfig(value);
                },
                behavior: HitTestBehavior.translucent,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 17),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('左右滑动',style: Get.textTheme.bodyLarge,),
                      if(  value.readModel==ReadModel.pageView)
                      Icon(Icons.check,color: Get.theme.primaryColor,)
                    ],
                  ),
                ),
              ),

              GestureDetector(
                onTap: (){
                  value.readModel=ReadModel.listView;
                  appBookConfig.upBookConfig(value);
                },
                behavior: HitTestBehavior.translucent,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 17),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('上下滚动',style: Get.textTheme.bodyLarge,),
                      if(  value.readModel==ReadModel.listView)
                      Icon(Icons.check,color: Get.theme.primaryColor,)
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 34,),
            ],
          ),
        );
      },

    ),backgroundColor: Colors.white);
  }
  @override
  Widget build(BuildContext context) {
    final appConfig = Get.find<AppBookConfig>();
    return Obx(() {
      return AnimatedPositioned(
        left: 0,
        right: 0,
        bottom: bookReaderLogic.m4.value
            ? 0
            : -220,
        duration: 300.milliseconds,
        child: Container(
            padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
            width: double.infinity,
            height: 220,
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(20), topLeft: Radius.circular(20)),
            ),
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
                          t1: 'A-',
                          t2: 'A+'))),
              child: ValueListenableBuilder(
                valueListenable: appConfig.bookConfigVN,
                builder: (BuildContext context, value, Widget? child) {
                  return Column(
                    children: [
                      SizedBox(
                        height: 32,
                        child: Slider(
                            value: value.textSize,
                            min: 16,
                            max: 40,
                            label: '${value.textSize}',
                            divisions: 8,
                            onChangeEnd: (v) {
                              value.textSize = v;
                              appConfig.upBookConfig(value);
                            },
                            onChanged: (v) {
                              value.textSize = v;
                              HapticFeedback.heavyImpact();
                              appConfig.bookConfigVN.notifyListeners();
                            }),
                      ),
                      const SizedBox(
                        height: 24,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Theme(
                              data: Get.theme!.copyWith(
                                  sliderTheme: SliderTheme.of(context).copyWith(
                                      thumbShape: const MySliderComponentShape(
                                          text: '行距',
                                          enabledThumbRadius: 18,
                                          t1: '紧',
                                          t2: '松')
                                  )),
                              child: SizedBox(
                                height: 32,
                                child: Slider(
                                    value: value.padding,
                                    min: 0,
                                    max: 20,
                                    label: '${value.padding}',
                                    divisions: 4,
                                    onChangeEnd: (v) {
                                      value.padding = v;
                                      appConfig.upBookConfig(value);
                                    },
                                    onChanged: (v) {
                                      value.padding = v;
                                      HapticFeedback.heavyImpact();
                                      appConfig.bookConfigVN.notifyListeners();
                                    }),
                              ),
                            ),
                          ),
                          const SizedBox(width: 8 ,),
                          Expanded(
                            child: Theme(
                              data: Get.theme!.copyWith(
                                  sliderTheme: SliderTheme.of(context).copyWith(
                                      thumbShape: const MySliderComponentShape(
                                          text: '段距',
                                          enabledThumbRadius: 18,
                                          t1: '小',
                                          t2: '大')
                                  )),
                              child: SizedBox(
                                height: 32,
                                child: Slider(
                                    value: value.textHight,
                                    min: 0.7,
                                    max: 2,
                                    label: '${value.textHight}',

                                    onChangeEnd: (v) {
                                      value.textHight = v;
                                      appConfig.upBookConfig(value);
                                    },
                                    onChanged: (v) {
                                      value.textHight = v;
                                      HapticFeedback.heavyImpact();
                                      appConfig.bookConfigVN.notifyListeners();
                                    }),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 24,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Container(
                              height: 32 ,
                              decoration: BoxDecoration(
                                color: Color(0xffF4F5F7),
                                borderRadius: BorderRadius.circular(16)
                              ),
                              padding: const EdgeInsets.only(left: 12,right: 12,top: 5,bottom: 5),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('默认字体',style: Get.textTheme.bodySmall ,),
                                  Image.asset(Imgs.ic_join,width: 14,height: 14,)
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 16,
                          ),
                          Expanded(
                            child: GestureDetector(
                              onTap: (){
                                openPageType(appConfig);
                              },
                              child: Container(
                                height: 32 ,
                                decoration: BoxDecoration(
                                    color: Color(0xffF4F5F7),
                                    borderRadius: BorderRadius.circular(16)
                                ),
                                padding: const EdgeInsets.only(left: 12,right: 12,top: 5,bottom: 5),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('翻页方式',style: Get.textTheme.bodySmall ,),
                                    Image.asset(Imgs.ic_join,width: 14,height: 14,)
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 24,
                      ),
                    ],
                  );
                },
              ),
            )),
      );
    });
  }
}

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:huaxia/widgets/card/flutter_card_swiper.dart';

class HomeSentenceLogic extends GetxController {

    final ValueNotifier<int> like = ValueNotifier(0);
    final CardSwiperController cardSwiperController = CardSwiperController();
}

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:huaxia/apps/home_sentence/model/Entence.dart';
import 'package:huaxia/config/config.dart';
import 'package:huaxia/widgets/card/flutter_card_swiper.dart';

class HomeSentenceLogic extends GetxController {

    final ValueNotifier<int> like = ValueNotifier(0);
    final CardSwiperController cardSwiperController = CardSwiperController();
    late Future<ApiResult<List<Entence>>>  futureEntence;

    @override
  void onInit() {
        futureEntence = Api.entence_list();
    super.onInit();
  }

  Future entence_like(String entenceId,String isLike){
      return Api.entence_like(entenceId: entenceId, isLike: isLike);
  }


}

import 'package:get/get.dart';
import 'package:huaxia/config/config.dart';


import '../../../home_sentence/model/Entence.dart';

class SentenceLogic extends GetxController {

  late Future<ApiResult<List<Entence>>> love;
  @override
  void onInit() {
    love = Api.loves_entence();
    super.onInit();
  }
}

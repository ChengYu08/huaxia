import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:huaxia/config/config.dart';

class AddSentenceLogic extends GetxController {

  final TextEditingController controller1 = TextEditingController();

  final TextEditingController controller2 = TextEditingController();

  final TextEditingController controller3 = TextEditingController();

  final TextEditingController controller4 = TextEditingController();

  postSent() async {
    if (controller1.text.isEmpty) {
      AppToast.toast('请输入内容');
      return;
    }

    if (controller2.text.isEmpty) {
      AppToast.toast('请输入译文');
      return;
    }

    if (controller1.text.isEmpty) {
      AppToast.toast('请输入出处');
      return;
    }

    if (controller1.text.isEmpty) {
      AppToast.toast('请输入章节');
      return;
    }
    return await Api.entence_add(
            sentence: controller1.text,
            interpretation: controller2.text,
            sourceCont: controller3.text,
            sourceUrl: controller4.text)
        .then((value) {
        if(value.success){
          AppToast.toast('发布成功');
           Get.back();
        }
    }).catchError((e) {
      AppToast.toast('${e.message}');
    });
  }


}

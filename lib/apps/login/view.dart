import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:huaxia/config/assets/imgs.dart';
import 'package:huaxia/config/config.dart';
import 'package:huaxia/config/wechat/wechat.dart';
import 'package:wechat_kit/wechat_kit.dart';

import 'logic.dart';

class LoginPage extends StatelessWidget {
  final logic = Get.find<LoginLogic>();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration:BoxDecoration(
        image:  DecorationImage(image: AssetImage(Imgs.bg_login),fit: BoxFit.fill),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
        ),
        body: Column(
          children: [
            const Spacer(),
            Image.asset(Imgs.logo,width: 108,height: 108,),
            const SizedBox(height: 15,),
            Image.asset(Imgs.bg_login_text,width: 108,height: 40,),
            const SizedBox(height: 9,),
            Text('传播国学文化，复兴国学价值!',style: Get.textTheme.bodySmall,),
            const SizedBox(height: 40,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: SizedBox(
                  height: 48,
                  width: double.infinity,
                  child: ElevatedButton.icon(onPressed: logic.wechatLogin,
                    icon: Image.asset(Imgs.wechat_fill,width: 24,height: 24,),label: const Text('微信登录'),)),
            ),
            const Spacer(),
            RichText(
                text: TextSpan(children: [
                  WidgetSpan(
                    child: Obx(() {
                      return SizedBox(
                        height: 14,
                        width: 14,
                        child: Checkbox(
                          value: logic.show.value,
                          shape:RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)
                          ),
                          onChanged: (v) {
                            logic.show.value = v!;
                          },
                        ),
                      );
                    }),
                  ),
                  TextSpan(
                      text: '  我已阅读并同意',
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          logic.show.value = ! logic.show.value;
                        },
                      style: TextStyle(color: Color(0xff90959C ), height: 2,fontSize: 12)
                  ),
                  TextSpan(
                      text: '《会员协议》',
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                        //todo
                        },
                      style: TextStyle(
                          color: Get.theme.primaryColor, height: 2,fontSize: 13)
                  ),
                  TextSpan(
                      text: '《自动续费协议》',
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {

                        },
                      style: TextStyle(
                          color: Get.theme.primaryColor,height: 2, fontSize: 13)
                  ),
                ])),
            const SizedBox(height: 80,)
          ],
        ),
      ),
    );
  }
}

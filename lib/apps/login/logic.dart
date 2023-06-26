import 'dart:async';

import 'package:bot_toast/bot_toast.dart';
import 'package:get/get.dart';
import 'package:huaxia/config/config.dart';
import 'package:huaxia/config/routers/app_routers.dart';
import 'package:wechat_kit/wechat_kit.dart';
import 'package:wechat_kit_extension/wechat_kit_extension.dart';

class LoginLogic extends GetxController {
 var show = false.obs;
 late final StreamSubscription<WechatResp> _respSubs;

 WechatAuthResp? _authResp;
 @override
  void onInit() {

  _respSubs = WechatKitPlatform.instance.respStream().listen(_listenResp);
    super.onInit();
  }

 void _listenResp(WechatResp resp) {

  if (resp is WechatAuthResp) {
   _authResp = resp;
   final String content = 'auth: $_authResp';

   if(_authResp?.isCancelled==true){
     Get.log('======取消了登录==========');
    AppToast.toast('取消登录');
   }
   if(_authResp?.isSuccessful==true){
    // final WechatAccessTokenResp accessTokenResp =
    //     await WechatExtension.getAccessTokenUnionID(
    //  appId: kWechatAppID,
    //  appSecret: kWechatAppSecret,
    //  code: _authResp!.code!,
    // );

    // Api.wechat_login(_authResp.)
    // Get.offAndToNamed(Routers.home);
   }
   Get.log('登录:$content');
  } else if (resp is WechatShareMsgResp) {
   final String content = 'share: ${resp.errorCode} ${resp.errorMsg}';
   Get.log('分享:$content', );
  } else if (resp is WechatPayResp) {
   final String content = 'pay: ${resp.errorCode} ${resp.errorMsg}';
   Get.log('支付:$content', );
  } else if (resp is WechatLaunchMiniProgramResp) {
   final String content = 'mini program: ${resp.errorCode} ${resp.errorMsg}';
   Get.log('拉起小程序:$content', );
  }
 }
 @override
  void onClose() {
  _respSubs.cancel();
    super.onClose();
  }

}

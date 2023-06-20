import 'dart:async';

import 'package:get/get.dart';
import 'package:wechat_kit/wechat_kit.dart';

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
   final String content = 'auth: ${resp.errorCode} ${resp.errorMsg}';
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

import 'dart:async';

import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:huaxia/config/config.dart';
import 'package:huaxia/config/http/TokenInterceptor.dart';
import 'package:huaxia/config/http/api_service.dart';
import 'package:huaxia/config/routers/app_routers.dart';
import 'package:huaxia/config/wechat/wechat.dart';
import 'package:wechat_kit/wechat_kit.dart';
import 'package:wechat_kit_extension/wechat_kit_extension.dart';

import 'model/user_model.dart';

const loginHive = 'loginHive';
const loginBox = 'loginBox';

class LoginLogic extends GetxService {
  var show = false.obs;
  late final StreamSubscription<WechatResp> _respSubs;

  WechatAuthResp? _authResp;

  late Box<UserModel> userBox;

  final StreamController<UserModel> userStream = StreamController.broadcast();
  final ValueNotifier<LoginState> loginState= ValueNotifier(LoginState.unknown);
  @override
  void onInit() {
    userStream.add(UserModel.un());
    initBox();
    _respSubs = WechatKitPlatform.instance.respStream().listen(_listenResp);
    super.onInit();
  }
  ///微信登录
  wechatLogin() {
    if (show.value) {
      WeChatConfig.login();
    }else{
      AppToast.toast('请同意协议继续');
    }
  }
  ///微信当前返回状态检讨
  void _listenResp(WechatResp resp) {
    if (resp is WechatAuthResp) {
      _authResp = resp;
      final String content = 'auth: $_authResp';
      if (_authResp?.isCancelled == true) {
        Get.log('======取消了登录==========');
        AppToast.toast('取消登录');
      }

      handlerLogin();
      Get.log('登录:$content');
    } else if (resp is WechatShareMsgResp) {
      final String content = 'share: ${resp.errorCode} ${resp.errorMsg}';
      Get.log(
        '分享:$content',
      );
    } else if (resp is WechatPayResp) {
      final String content = 'pay: ${resp.errorCode} ${resp.errorMsg}';
      Get.log(
        '支付:$content',
      );
    } else if (resp is WechatLaunchMiniProgramResp) {
      final String content = 'mini program: ${resp.errorCode} ${resp.errorMsg}';
      Get.log(
        '拉起小程序:$content',
      );
    }
  }

  @override
  void onClose() {
    _respSubs.cancel();
    super.onClose();
  }

  void handlerLogin() async {
    if (_authResp?.isSuccessful == true) {
      final WechatAccessTokenResp accessTokenResp =
          await WechatExtension.getAccessTokenUnionID(
        appId: WeChatConfig.kAppId,
        appSecret: WeChatConfig.kAppSecret,
        code: _authResp!.code!,
      );
      Api.wechat_login(accessTokenResp.openid!).then((value) {
        if (value.success) {
          _saveUser(value.data!);
          _addUser(value.data!);
          Get.offAndToNamed(Routers.home);
        } else {
          AppToast.toast(value.message);
        }
      });
    }
  }

  void initBox() async {
    userBox = await Hive.openBox(loginHive);
    final user = userBox.get(loginBox);
    if (user != null) {
      _addUser(user);
    }else{
      loginState.value = LoginState.notAuthenticated;
    }
  }

  _addUser(UserModel userModel) {
    userStream.add(userModel);
    loginState.value = LoginState.authentication;
    ApiService.getInstance().addInterceptors(TokenInterceptor(userModel.userToken!));
  }

  _saveUser(UserModel userModel) {
    userStream.add(userModel);
    userBox.put(loginBox, userModel);
  }

  cleanUser() {
    userBox.delete(loginBox);
    loginState.value = LoginState.notAuthenticated;
    userStream.add(UserModel.un());
  }
}

enum LoginState{
  authentication,
  notAuthenticated,
  unknown
}

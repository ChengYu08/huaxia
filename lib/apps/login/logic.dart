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

  final StreamController<UserModel> _userStream = StreamController.broadcast();
  final ValueNotifier<LoginState> loginState= ValueNotifier(LoginState.unknown);

   Stream<UserModel> get  userStream=>_userStream.stream;
  UserModel? get  initUserModel =>userBox.get(loginBox);


  @override
  void onInit() {
    _userStream.add(UserModel.un());
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
         if (_authResp?.errorCode == -4) {
        Get.log('======取消了登录==========');
        AppToast.toast('用户拒绝授权');
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
  ///刷新用户状态
  Future<User?> reUser(){
   return  Api.user_info().then((value) {

        if(value.success){
          _saveUser(initUserModel!.copy(value.data!));
        }
      return value.data;
    });
  }

  @override
  void onClose() {
    _respSubs.cancel();
    super.onClose();
  }

  void handlerLogin() async {
    if (_authResp?.isSuccessful == true) {
      Api.wechat_login( _authResp!.code!).then((value) {
        if (value.success) {
          _saveUser(value.data!);
          _addUser(value.data!);
          Get.offAllNamed(Routers.home);
        } else {
          AppToast.toast(value.message);
        }
      });
    }
  }

  void initBox() async {
    userBox = await Hive.openBox(loginHive);

    if (initUserModel != null) {
      Get.log("用户信息：$initUserModel");
      _addUser(initUserModel!);
    }else{
      loginState.value = LoginState.notAuthenticated;
    }
  }

  _addUser(UserModel userModel) {
    _userStream.sink.add(userModel);
    loginState.value = LoginState.authentication;
    ApiService.getInstance().addInterceptors(TokenInterceptor(userModel.userToken!));
  }

  _saveUser(UserModel userModel) {
    _userStream.add(userModel);
    userBox.put(loginBox, userModel);
  }

   cleanUser()async {
 await  userBox.delete(loginBox);
    loginState.value = LoginState.notAuthenticated;
    _userStream.add(UserModel.un());
  }
}

enum LoginState{
  authentication,
  notAuthenticated,
  unknown
}

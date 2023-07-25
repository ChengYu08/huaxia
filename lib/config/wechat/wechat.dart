

import 'package:wechat_kit/wechat_kit.dart';

class WeChatConfig{
  static const String kAppId = 'wxb34ed16241caa374';
  static const String kUniversalLink = '';
  static const String kAppSecret = '892fc14c9e7d101950f1951331979582';

  static register(){
     WechatKitPlatform.instance.registerApp(
      appId: kAppId,
      universalLink: kUniversalLink,
    );
  }
  static Future login(){
  return  WechatKitPlatform.instance.auth(
      scope: <String>[WechatScope.kSNSApiUserInfo],
      state: 'auth',
    );
  }

}
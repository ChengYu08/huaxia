
import 'package:huaxia/config/config.dart';

class ApiUrl{
  static get BASE_URL{
    if(appPath ==AppPath.DEBUG){
      return _DEBUG_BASE_URL;
    }else{
      return '';
    }
  }
  static const _DEBUG_BASE_URL='http://www.ygongzuo.com:15005/';

  static const wechat_login='/guoxue/app/user/login';
}
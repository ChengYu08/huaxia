
import 'package:huaxia/config/config.dart';

class ApiUrl{
  static get BASE_URL{
    if(appPath ==AppPath.RELEASE){
      return _RELEASE_BASE_URL;
    }else{
      return '';
    }
  }

  static const _DEBUG_BASE_URL='http://www.ygongzuo.com:15005/';

  static const _RELEASE_BASE_URL='https://www.ygongzuo.com/';

  static const wechat_login='/guoxue/app/user/login';

  ///书城列表
  static const book_list='/guoxue/app/book/list';
}
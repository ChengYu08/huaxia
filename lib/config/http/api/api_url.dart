
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
  ///书籍目录
  static String book_catalogue(String id){
    return '/guoxue/app/book/catalogue/$id/list';
  }
  ///书籍章节
  static String chapters({required int bookId,required int  chaptersId}){
    return '/guoxue/app/book/chapters/$bookId/$chaptersId';
  }

  ///我的书架
  static const  book_shelf= '/guoxue/app/book/shelf/list';
  ///加入书架
  static const  book_shelf_add= '/guoxue/app/book/shelf/add';
}

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

  ///书籍详情
  static String book_info(String id){
    return '/guoxue/app/book/$id/info';
  }
  static const  book_shelf_delete =  '/guoxue/app/book/shelf/';



  ///书籍章节
  static String chapters({required int bookId,required int  chaptersId}){
    return '/guoxue/app/book/chapters/$bookId/$chaptersId';
  }

  ///我的书架
  static const  book_shelf = '/guoxue/app/book/shelf/list';

  ///加入书架
  static const  book_shelf_add = '/guoxue/app/book/shelf/add';

  ///新增划线
  static const  book_delineate_add = '/guoxue/app/book/delineate/add';

  ///VIP列表
  static const  vip_list = '/guoxue/app/vip/type/list';

  ///开通vip（预下单
  static const  vip_order_add = '/guoxue/app/vip/order/add';

  ///我的信息(刷新使用)
  static const  user_info = '/guoxue/app/user/info';

  ///首页 句子 列表
  static const  entence_list = '/guoxue/app/entence/list';

  ///句子 喜欢或者不喜欢
  static const  entence_like = '/guoxue/app/entence/like/log/add';

  ///发布句子
  static const  entence_add = '/guoxue/app/entence/add';


  ///我喜欢的句子
  static const  loves_entence = '/guoxue/app/entence/like/log/loves';

  ///我的浏览记录
  static const  read_history = '/guoxue/app/book/shelf/read/history';


}
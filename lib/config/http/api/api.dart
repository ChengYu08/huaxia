import 'package:huaxia/apps/book_store/model/BookList.dart';
import 'package:huaxia/apps/login/model/user_model.dart';
import 'package:huaxia/config/http/api/api_url.dart';

import '../api_service.dart';

T? asT<T>(dynamic value) {
  if (value is T) {
    return value;
  }
  return null;
}

class Api{


  static Future<ApiResult<UserModel>> wechat_login(String openId){
    return ApiService.getInstance().post(ApiUrl.wechat_login,data:{
          "openId":openId
    },dataParser: (v){
      return UserModel.fromJson(v);
    });
  }

  static Future<ApiResult<List<BookList>>> book_list(String typeId){
    return ApiService.getInstance().get(ApiUrl.book_list,queryParameters: {
          'typeId':typeId},dataParser: (v){
      return _bookList(v);
    });
  }

  static List<BookList> _bookList(v) {
    final List<BookList> data = [];
    if(v!=null && v is List){
      for (final dynamic item in v) {
        if (item != null) {
          data.add(BookList.fromJson(asT<Map<String, dynamic>>(item)!));
        }
      }
    }
    return data;
  }
}
import 'package:huaxia/apps/book_store/model/BookList.dart';
import 'package:huaxia/apps/book_store/model/Catalogue.dart';
import 'package:huaxia/apps/book_store/model/Chapters.dart';
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


  static Future<ApiResult<UserModel>> wechat_login(String code){
    return ApiService.getInstance().post(ApiUrl.wechat_login,data:{
          "code":code
    },dataParser: (v){
      return UserModel.fromJson(v);
    });
  }

  static Future<ApiResult<List<BookList>>> book_list(String typeId){
    return ApiService.getInstance().post(ApiUrl.book_list,data: {
          'type':typeId},dataParser: (v){
      return _bookList(v);
    });
  }

  static Future<ApiResult<List<Catalogue>>> book_Catalogue(int id){
    return ApiService.getInstance().get(ApiUrl.book_catalogue('$id'),dataParser: (v){
      return _bookCatalogue(v);
    });
  }

  static Future<ApiResult<Chapters>> book_Chapters({required int bookId,required int  chaptersId}){
    return ApiService.getInstance().get(ApiUrl.chapters(bookId: bookId,chaptersId: chaptersId),dataParser: (v){
      return Chapters.fromJson(v);
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
  static List<Catalogue> _bookCatalogue(v) {
    final List<Catalogue> data = [];
    if(v!=null && v is List){
      for (final dynamic item in v) {
        if (item != null) {
          data.add(Catalogue.fromJson(asT<Map<String, dynamic>>(item)!));
        }
      }
    }
    return data;
  }
}
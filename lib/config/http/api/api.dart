import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';
import 'package:get/get.dart';
import 'package:huaxia/apps/book_store/model/BookList.dart';
import 'package:huaxia/apps/book_store/model/Catalogue.dart';
import 'package:huaxia/apps/book_store/model/Chapters.dart';
import 'package:huaxia/apps/book_store/model/ShelfBook.dart';
import 'package:huaxia/apps/book_store/my_book_logic.dart';
import 'package:huaxia/apps/home_sentence/model/Entence.dart';
import 'package:huaxia/apps/login/model/user_model.dart';
import 'package:huaxia/apps/vip/model/VIPList.dart';
import 'package:huaxia/config/http/api/api_url.dart';
import '../../../apps/vip/model/VipPay.dart';
import '../api_service.dart';

T? asT<T>(dynamic value) {
  if (value is T) {
    return value;
  }
  return null;
}

class Api {
  static Future<ApiResult<UserModel>> wechat_login(String code) {
    return ApiService.getInstance()
        .post(ApiUrl.wechat_login, data: {"code": code}, dataParser: (v) {
      return UserModel.fromJson(v);
    });
  }

  static Future<ApiResult<User>> user_info() {
    return ApiService.getInstance().get(ApiUrl.user_info, dataParser: (v) {
      return User.fromJson(v);
    });
  }

  static Future<ApiResult> book_shelf_add(String bookId) {
    return ApiService.getInstance()
        .post(ApiUrl.book_shelf_add, data: {"bookId": bookId}).then((value) {
      if (value.success) {
        if (Get.isRegistered<MyBookLogic>()) {
          Get.find<MyBookLogic>().update();
        }
      }
      return value;
    });
  }

  static Future<ApiResult> book_delineate_add({
    required int bookId,
    required int bookChaptersInfoId,
    Map<String, dynamic>? expand,
  }) {
    return ApiService.getInstance().post(ApiUrl.book_delineate_add, data: {
      "bookId": bookId,
      "bookChaptersInfoId": bookChaptersInfoId,
      "expand": expand,
    });
  }

  static Future<ApiResult> book_shelf_delete({
    required String ids,
  }) {
    return ApiService.getInstance().delete(
      ApiUrl.book_shelf_delete + ids,
    );
  }

  static Future<ApiResult<List<BookList>>> book_list(String typeId,
      {int pageNum = 1, int pageSize = 20}) {
    return ApiService.getInstance().post(ApiUrl.book_list,
        queryParameters: {'pageNum': pageNum, 'pageSize': pageSize},
        data: {'type': typeId}, dataParser: (v) {
      return _bookList(v);
    });
  }

  static Future<ApiResult<List<ShelfBook>>> book_shelf() {
    return ApiService.getInstance().get(ApiUrl.book_shelf, dataParser: (v) {
      return _shelfBook(v);
    });
  }

  static Future<ApiResult<List<Entence>>> entence_list() {
    return ApiService.getInstance().get(ApiUrl.entence_list, dataParser: (v) {
      return _entences(v);
    });
  }

  static Future<ApiResult<List<Entence>>> loves_entence() {
    return ApiService.getInstance().get(ApiUrl.loves_entence, dataParser: (v) {
      return _entences(v);
    });
  }

  ///[isLike]是否喜欢(0否，1是)
  static Future entence_like(
      {required String entenceId, required String isLike}) {
    return ApiService.getInstance().post(ApiUrl.entence_like, data: {
      'entenceId': entenceId,
      'isLike': isLike,
    });
  }

  static Future<ApiResult> entence_add(
      {required String sentence,
      required String interpretation,
      required String sourceCont,
      required String sourceUrl}) {
    return ApiService.getInstance().post(ApiUrl.entence_add, data: {
      'sentence': sentence,
      'interpretation': interpretation,
      'sourceCont': sourceCont,
      'sourceUrl': sourceUrl,
    });
  }

  static Future<ApiResult<List<VIPList>>> vip_list() {
    return ApiService.getInstance().post(ApiUrl.vip_list, dataParser: (v) {
      return _vip_list(v);
    });
  }

  static Future<ApiResult<VipPay>> vip_order_add(
      {required int vipTypeId, required int payType}) {
    return ApiService.getInstance().post(ApiUrl.vip_order_add,
        data: {"vipTypeId": vipTypeId, "payType": payType}, dataParser: (v) {
      return VipPay.fromJson(v);
    });
  }

  static Future<ApiResult<List<Catalogue>>> book_Catalogue(int id) {
    return ApiService.getInstance().get(
        ApiUrl.book_catalogue(
          '$id',
        ),
        cachePolicy: CachePolicy.request, dataParser: (v) {
      return _bookCatalogue(v);
    });
  }

  static Future<ApiResult<BookList>> book_info(int id) {
    return ApiService.getInstance().get(
        ApiUrl.book_info(
          '$id',
        ),
        cachePolicy: CachePolicy.request, dataParser: (v) {
      return BookList.fromJson(v);
    });
  }

  static Future<ApiResult<Chapters>> book_Chapters(
      {required int bookId, required int chaptersId}) {
    return ApiService.getInstance().get(
        ApiUrl.chapters(bookId: bookId, chaptersId: chaptersId),
        cachePolicy: CachePolicy.forceCache, dataParser: (v) {
      return Chapters.fromJson(v);
    });
  }

  static List<BookList> _bookList(v) {
    final List<BookList> data = [];
    if (v != null && v is List) {
      for (final dynamic item in v) {
        if (item != null) {
          data.add(BookList.fromJson(asT<Map<String, dynamic>>(item)!));
        }
      }
    }
    return data;
  }

  static List<ShelfBook> _shelfBook(v) {
    final List<ShelfBook> data = [];
    if (v != null && v is List) {
      for (final dynamic item in v) {
        if (item != null) {
          data.add(ShelfBook.fromJson(asT<Map<String, dynamic>>(item)!));
        }
      }
    }
    return data;
  }

  static List<Entence> _entences(v) {
    final List<Entence> data = [];
    if (v != null && v is List) {
      for (final dynamic item in v) {
        if (item != null) {
          data.add(Entence.fromJson(asT<Map<String, dynamic>>(item)!));
        }
      }
    }
    return data;
  }

  static List<VIPList> _vip_list(v) {
    final List<VIPList> data = [];
    if (v != null && v is List) {
      for (final dynamic item in v) {
        if (item != null) {
          data.add(VIPList.fromJson(asT<Map<String, dynamic>>(item)!));
        }
      }
    }
    return data;
  }

  static List<Catalogue> _bookCatalogue(v) {
    final List<Catalogue> data = [];
    if (v != null && v is List) {
      for (final dynamic item in v) {
        if (item != null) {
          data.add(Catalogue.fromJson(asT<Map<String, dynamic>>(item)!));
        }
      }
    }
    return data;
  }
}

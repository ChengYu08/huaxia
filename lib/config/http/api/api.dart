import 'package:huaxia/config/http/api/api_url.dart';

import '../api_service.dart';


class Api{


  static Future<ApiResult> wechat_login(String id){

    return ApiService.getInstance().post(ApiUrl.wechat_login,data: {

    });
  }
}
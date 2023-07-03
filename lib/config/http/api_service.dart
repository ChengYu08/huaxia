import 'dart:async';


import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'api/api_url.dart';



typedef DataParser<T> = T Function(dynamic);

typedef Json = Map<String, dynamic>;

const int connectTimeout = 3000;
const int sendTimeout = 3000;
const int receiveTimeout = 3000;
class ApiService {
  static ApiService? _instance;

  static ApiService getInstance() {
    _instance ??= ApiService._();
    return _instance!;
  }



  Dio get dio => _dio;
  late  Dio _dio;

  ApiService._()  {
    _dio = Dio(
      BaseOptions(
        baseUrl: ApiUrl.BASE_URL,
        connectTimeout: connectTimeout.milliseconds,
        sendTimeout: sendTimeout.milliseconds,
        receiveTimeout: receiveTimeout.milliseconds,

      ),
    );
    dio.interceptors.add(PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseBody: true,
        responseHeader: false,
        error: true,
        compact: true,
        maxWidth: 90));
  }

  void addHeader(String key, String value) {
    _dio.options.headers[key] = value;
  }

  void removeHeader(String key) {
    if (_dio.options.headers.containsKey(key)) {
      _dio.options.headers.remove(key);
    }
  }
  void addInterceptors(Interceptor interceptor){

    _dio.interceptors.add(interceptor);
  }

  Completer<bool>? _locker;

  bool get isLocked => !(_locker?.isCompleted ?? true);

  /// 锁
  void lock() {
    if (!isLocked) {

      _locker = Completer<bool>();
    }
  }

  /// 解锁
  void unLock([bool complete = true]) {
    if (isLocked) {

      _locker?.complete(complete);
    }
  }



  /// 通用请求
  Future<ApiResult<T>> request<T>(
    String src,
    String method, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Map<String, String>? header,
    DataParser<T>? dataParser,
    bool skipLock = false,

  }) async {
    if (!skipLock && isLocked) {

      final isPass = await _locker!.future;
      if (!isPass) {
        return ApiResult<T>(500, 'Request canceled');
      }
    }
    Options options = Options(
      method: method,
      headers: header,

      sendTimeout: sendTimeout.milliseconds,
      receiveTimeout: receiveTimeout.milliseconds,
    );

    try {
      Response<Json> res = await _dio.request(
        src,
        data: data,
        queryParameters: queryParameters,
        options: options,
      );

      final result = ApiResult<T>.fromResponse(res, dataParser: dataParser);


      return result;
    } on DioException catch(e,s) {

      return ApiResult.error(e);
    }
  }

  /// get请求
  Future<ApiResult<T>> get<T>(
    String src, {
    Map<String, dynamic>? queryParameters,
    Map<String, String>? header,
    DataParser<T>? dataParser,
    bool skipLock = false,

  }) async {
    return request(
      src,
      'GET',
      header: header,
      queryParameters: queryParameters,
      dataParser: dataParser,
      skipLock: skipLock,

    );
  }

  /// post请求
  Future<ApiResult<T>> post<T>(
    String src, {
      Map<String, dynamic>? data,
    Map<String, dynamic>? queryParameters,
    Map<String, String>? header,
    DataParser<T>? dataParser,
    bool skipLock = false,

  }) async {
    return request(
      src,
      'POST',
      data: data,
      header: header,
      queryParameters: queryParameters,
      dataParser: dataParser,
      skipLock: skipLock,

    );
  }

  /// put请求
  Future<ApiResult<T>> put<T>(
    String src,
    dynamic data, {
    Map<String, dynamic>? queryParameters,
    Map<String, String>? header,
    DataParser<T>? dataParser,
    bool skipLock = false,

  }) async {
    return request(
      src,
      'PUT',
      data: data,
      header: header,
      queryParameters: queryParameters,
      dataParser: dataParser,
      skipLock: skipLock,

    );
  }

  /// delete请求
  Future<ApiResult<T>> delete<T>(
    String src, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Map<String, String>? header,
    DataParser<T>? dataParser,
    bool skipLock = false,

  }) async {
    return request(
      src,
      'DELETE',
      data: data,
      header: header,
      queryParameters: queryParameters,
      dataParser: dataParser,
      skipLock: skipLock,

    );
  }
}

class ApiResult<T> {
  final int status;
  final String message;
   int? total;
  final T? data;


  bool get failed => status != 200;

  bool get success => status == 0;

  bool get invalidToken => status == 402;

  bool get needLogin => status == 401 ;

  bool get unauthorized => status == 403;

  ApiResult(this.status, this.message, {this.data});

  ApiResult.fromResponse(
    Response<Json> response, {
    DataParser<T>? dataParser,
  })  : status = response.data?['code'] ?? -1,
        message = response.data?['msg'] ?? '',
        total = response.data?['total'] ?? 0,
        data = response.data?['data'] != null
                ?(dataParser?.call(response.data?['data']) ?? response.data?['data']):
                 response.data?['rows']!=null
                 ?(dataParser?.call(response.data?['rows'])?? response.data?['rows'])
                 :null;

  Json toJson() => {
        'status': status,
        'message': message,
        'data': data,
      };



  factory ApiResult.error(DioException error){
      switch(error.type){
        case DioExceptionType.cancel:
          {
            return ApiResult(-1, "请求取消");
          }

        case DioExceptionType.connectionTimeout:
          {
            return ApiResult(-1, "连接超时");
          }

        case DioExceptionType.sendTimeout:
          {
            return ApiResult(-1, "请求超时");
          }

        case DioExceptionType.receiveTimeout:
          {
            return ApiResult(-1, "响应超时");
          }
        case DioExceptionType.unknown:
          {
            return ApiResult(-1, "网络错误");
          }

        case DioExceptionType.badResponse:
          {
            try {
              int? errCode = error.response?.statusCode!;
              switch (errCode) {
                case 400:
                  {
                    return ApiResult(errCode!, "请求语法错误");
                  }
                  break;
                case 401:
                  {
                    return ApiResult(errCode!, "没有权限");
                  }
                  break;
                case 403:
                  {
                    return ApiResult(errCode!, "服务器拒绝执行");
                  }
                  break;
                case 404:
                  {
                    return ApiResult(errCode!, "无法连接服务器");
                  }
                  break;
                case 405:
                  {
                    return ApiResult(errCode!, "请求方法被禁止");
                  }
                  break;
                case 500:
                  {
                    return ApiResult(errCode!, "服务器内部错误");
                  }
                  break;
                case 502:
                  {
                    return ApiResult(errCode!, "无效的请求");
                  }
                  break;
                case 503:
                  {
                    return ApiResult(errCode!, "服务器挂了");
                  }
                  break;
                case 505:
                  {
                    return ApiResult(errCode!, "不支持HTTP协议请求");
                  }
                  break;
                default:
                  {
                    // return ErrorEntity(code: errCode, message: "未知错误");
                    return ApiResult(
                        errCode??-1, error.response?.statusMessage ?? '');
                  }
              }
            } on Exception catch (_) {
              return ApiResult(-1, "未知错误");
            }
          }
          break;
        default:
          {
            return ApiResult(-1, error.message??'');
          }
      }
  }

  @override
  String toString() => toJson().toString();
}



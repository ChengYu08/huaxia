



import 'dart:io';

import 'package:dio/dio.dart';



class TokenInterceptor extends Interceptor{
  final String token;

  TokenInterceptor(this.token);

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    options.headers['x-access-token']=token;
    options.headers['platform']=Platform.isAndroid?'Android':'ios';
    return handler.next(options);
  }

}

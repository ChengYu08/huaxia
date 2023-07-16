import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:huaxia/application/applocation.dart';
import 'package:huaxia/application/book_config/book_config.dart';
import 'package:home_widget/home_widget.dart';
import 'package:huaxia/apps/book_store/book_details/book_reader/data/book_paragraph.dart';
import 'package:huaxia/config/config.dart';

import 'apps/login/model/user_model.dart';
import 'config/wechat/wechat.dart';

void main() async {
  await Hive.initFlutter();
  ///hive适配器注册
  _registerAdapter();
  ///微信初始化
  WeChatConfig.register();
  ///初始化网络请求
  ApiService.getInstance();
  runApp(const Application());
}

_registerAdapter() {
  Hive.registerAdapter(BookConfigAdapter());
  Hive.registerAdapter(ReadModelAdapter());
  Hive.registerAdapter(UserModelAdapter());
  Hive.registerAdapter(UserAdapter());
  Hive.registerAdapter(BookParagraphAdapter());
}



import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:huaxia/application/applocation.dart';
import 'package:huaxia/application/book_config/book_config.dart';
import 'package:home_widget/home_widget.dart';

import 'config/wechat/wechat.dart';

void main() async {
  await Hive.initFlutter();
  ///hive适配器注册
  _registerAdapter();
  ///微信初始化
  WeChatConfig.register();
  ///初始化网络请求

  runApp(const Application());
}

_registerAdapter() {
  Hive.registerAdapter(BookConfigAdapter());
  Hive.registerAdapter(ReadModelAdapter());
}



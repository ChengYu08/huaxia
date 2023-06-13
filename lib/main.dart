import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:huaxia/application/applocation.dart';
import 'package:huaxia/application/book_config/book_config.dart';

void main() async {
  await Hive.initFlutter();
  _registerAdapter();
  runApp(const Application());
}

_registerAdapter() {
  Hive.registerAdapter(BookConfigAdapter());
}
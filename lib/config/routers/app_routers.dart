
import 'package:get/get.dart';
import 'package:huaxia/apps/book_store/binding.dart';
import 'package:huaxia/apps/book_store/book_details/book_reader/binding.dart';
import 'package:huaxia/apps/book_store/book_details/book_reader/view.dart';
import 'package:huaxia/apps/book_store/book_search/view.dart';
import 'package:huaxia/apps/home/view.dart';
import 'package:huaxia/apps/screen/binding.dart';
import 'package:huaxia/apps/screen/view.dart';

import '../../apps/book_store/book_details/binding.dart';
import '../../apps/book_store/book_details/view.dart';
import '../../apps/book_store/book_search/binding.dart';
import '../../apps/home/binding.dart';

class Routers{
  Routers._();
  static const Initial = '/';
  ///登录
  static const login = '/login';
  ///首页
  static const home = '/home';
  static const bookSearchPage = '/BookSearchPage';
  static const bookDetailsPage = '/BookDetailsPage';
  static const bookReaderPage = '/BookReaderPage';
}
class AppRouters{
  static final routers = [
    GetPage(
        name: Routers.Initial,
        page: () {
          return  ScreenPage();
        },binding: ScreenBinding()),
    GetPage(
        name: Routers.home,
        page: () =>HomePage(),
        bindings: [
          HomeBinding(),
          BookStoreBinding()
        ],
       ),
    GetPage(
        name: Routers.bookSearchPage,
        page: ()=>BookSearchPage(),
        binding: BookSearchBinding()),
    GetPage(
        name: Routers.bookDetailsPage,
        page: ()=>BookDetailsPage(),
        binding: BookDetailsBinding()),
    GetPage(
        name: Routers.bookReaderPage,
        page: ()=>BookReaderPage(),
        binding: BookReaderBinding()),
  ];
}
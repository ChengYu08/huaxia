
import 'package:get/get.dart';
import 'package:huaxia/apps/book_store/binding.dart';
import 'package:huaxia/apps/book_store/book_details/book_reader/binding.dart';
import 'package:huaxia/apps/book_store/book_details/book_reader/view.dart';
import 'package:huaxia/apps/book_store/book_search/view.dart';
import 'package:huaxia/apps/home/view.dart';
import 'package:huaxia/apps/me/me/binding.dart';
import 'package:huaxia/apps/me/me/sentence/binding.dart';
import 'package:huaxia/apps/me/me/sentence/view.dart';
import 'package:huaxia/apps/me/me/view.dart';
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

  static const me = '/MePage';
  static const sentencePage = '/MePage/SentencePage';
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
          BookStoreBinding(),
          MeBinding()
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
    GetPage(
        name: Routers.me,
        page: ()=>MePage(),
        binding: MeBinding()),
    GetPage(
        name: Routers.sentencePage,
        page: ()=>SentencePage(),
        binding: SentenceBinding()),
  ];
}
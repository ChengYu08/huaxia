
import 'package:get/get.dart';
import 'package:huaxia/apps/book_store/binding.dart';
import 'package:huaxia/apps/book_store/book_details/book_reader/binding.dart';
import 'package:huaxia/apps/book_store/book_details/book_reader/view.dart';
import 'package:huaxia/apps/book_store/book_details/book_speak/binding.dart';
import 'package:huaxia/apps/book_store/book_details/book_speak/view.dart';
import 'package:huaxia/apps/book_store/book_search/view.dart';
import 'package:huaxia/apps/home/view.dart';
import 'package:huaxia/apps/home_sentence/binding.dart';
import 'package:huaxia/apps/home_sentence/des_sentence/binding.dart';
import 'package:huaxia/apps/home_sentence/des_sentence/view.dart';
import 'package:huaxia/apps/home_sentence/view.dart';

import 'package:huaxia/apps/login/view.dart';
import 'package:huaxia/apps/me/me/binding.dart';
import 'package:huaxia/apps/me/me/me_read_history/view.dart';
import 'package:huaxia/apps/me/me/sentence/binding.dart';
import 'package:huaxia/apps/me/me/sentence/view.dart';
import 'package:huaxia/apps/me/me/view.dart';
import 'package:huaxia/apps/me/setting/binding.dart';

import 'package:huaxia/apps/screen/view.dart';
import 'package:huaxia/apps/vip/binding.dart';
import 'package:huaxia/apps/vip/view.dart';

import '../../apps/book_store/book_details/binding.dart';
import '../../apps/book_store/book_details/view.dart';
import '../../apps/book_store/book_search/binding.dart';
import '../../apps/home/binding.dart';
import '../../apps/home_sentence/add_sentence/binding.dart';
import '../../apps/home_sentence/add_sentence/view.dart';
import '../../apps/me/me/me_read_history/binding.dart';
import '../../apps/me/setting/view.dart';

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

  static const home_sentencePage = '/HomeSentencePage';
  static const desSentencePage = '/HomeSentencePage/DesSentencePage';
  static const addSentencePage = '/HomeSentencePage/AddSentencePage';

  static const me = '/MePage';
  static const sentencePage = '/MePage/SentencePage';
  static const settingPage = '/MePage/SettingPage';
  static const me_read_historyPage = '/MePage/Me_read_historyPage';
  static const vipPage = '/VipPage';
}
class AppRouters{
  static final routers = [
    GetPage(
        name: Routers.Initial,
        page: () {
          return  ScreenPage();
        }),
    GetPage(
        name: Routers.login,
        page: () {
          return  LoginPage();
        }),    GetPage(
        name: Routers.me_read_historyPage,
        binding: Me_read_historyBinding(),
        page: () {
          return  Me_read_historyPage();
        }),

    GetPage(
        name: Routers.home,
        page: () =>HomePage(),
        bindings: [
          HomeBinding(),
          BookStoreBinding(),
          HomeSentenceBinding(),
          MeBinding()
        ],
       ),

    GetPage(
        name: Routers.home_sentencePage,
        page: ()=>HomeSentencePage(),
        binding: HomeSentenceBinding()),
    GetPage(
        name: Routers.vipPage,
        page: () {
          return  VipPage();
        },binding: VipBinding()),
    GetPage(
        name: Routers.addSentencePage,
        page: ()=>AddSentencePage(),
        binding: AddSentenceBinding()),
    GetPage(
        name: Routers.desSentencePage,
        page: ()=>DesSentencePage(),
        binding: DesSentenceBinding()),

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
      ),
    GetPage(
        name: Routers.me,
        page: ()=>MePage(),
        binding: MeBinding()),
    GetPage(
        name: Routers.sentencePage,
        page: ()=>SentencePage(),
        binding: SentenceBinding()),
    GetPage(
        name: Routers.settingPage,
        page: ()=>SettingPage(),
        binding: SettingBinding()),
  ];
}
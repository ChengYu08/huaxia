import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:huaxia/apps/me/me/view.dart';
import 'package:huaxia/config/config.dart';

import '../book_store/view.dart';
import 'logic.dart';

class HomePage extends StatefulWidget {

  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final logic = Get.find<HomeLogic>();


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        physics: const NeverScrollableScrollPhysics(),
        controller: logic.pageController,
        children: [
          Container(color: Colors.teal,),
          BookStorePage(),
          MePage(),
        ],
      ),
      bottomNavigationBar: Obx(() {
        return BottomNavigationBar(
          onTap: (i) {
            logic.jump(i);
          },
          currentIndex: logic.selectIndex.value,
          items: [
            BottomNavigationBarItem(
                icon: Image.asset(
                  Imgs.ic_bar_jz,
                  width: 24,
                  height: 24,
                ),
                activeIcon: Image.asset(
                  Imgs.ic_bar_jz_a,
                  width: 24,
                  height: 24,
                ),
                label: '句子'), BottomNavigationBarItem(
                icon: Image.asset(
                  Imgs.ic_bar_sc,
                  width: 24,
                  height: 24,
                ),
                activeIcon: Image.asset(
                  Imgs.ic_bar_sc_a,
                  width: 24,
                  height: 24,
                ),
                label: '书城'), BottomNavigationBarItem(
                icon: Image.asset(
                  Imgs.ic_bar_me,
                  width: 24,
                  height: 24,
                ),
                activeIcon: Image.asset(
                  Imgs.ic_bar_me_a,
                  width: 24,
                  height: 24,
                ),
                label: '我的'),
          ],
        );
      }),
    );
  }
}

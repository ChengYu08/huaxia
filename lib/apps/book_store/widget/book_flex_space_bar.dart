
import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:huaxia/config/config.dart';

class BookFlexSpaceBar extends StatelessWidget {
   BookFlexSpaceBar({
    super.key,
    required TabController tabController,
  }) : _tabController = tabController;

  final TabController _tabController;
  final PageController _pageController= PageController();

  @override
  Widget build(BuildContext context) {
    return FlexibleSpaceBar(
      background: Stack(
        children: [
          Positioned.fill(
            child: PageView(
              controller: _pageController,
              onPageChanged: (i){
                _tabController.animateTo(i);
              },
              children: [
                Image.asset(
                  Imgs.bg_banner_1,
                  width: double.infinity,
                  height: 290,
                  fit: BoxFit.fitWidth,
                ),
                Image.asset(
                  Imgs.bg_banner_2,
                  width: double.infinity,
                  height: 290,
                  fit: BoxFit.fitWidth,
                ),
                Image.asset(
                  Imgs.bg_banner_3,
                  width: double.infinity,
                  height: 290,
                  fit: BoxFit.fitWidth,
                ),
                Image.asset(
                  Imgs.bg_banner_4,
                  width: double.infinity,
                  height: 290,
                  fit: BoxFit.fitWidth,
                ),
              ],
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            top: kToolbarHeight+40,
            child: TabBar(controller: _tabController,
                dividerColor: Colors.transparent,
                indicatorPadding: EdgeInsets.zero,
                onTap: (i){
                _pageController.animateToPage(i, duration: 300.milliseconds, curve: Curves.linear);
                },
                labelPadding: EdgeInsets.zero,
                tabs:const [
                  Tab(
                    text: '经部',
                    iconMargin:  EdgeInsets.zero,
                  ),
                  Tab(
                    text: '史部',
                    iconMargin:  EdgeInsets.zero,
                  ),
                  Tab(
                    text: '子部',
                    iconMargin:  EdgeInsets.zero,
                  ),
                  Tab(
                    text: '集部',
                    iconMargin:  EdgeInsets.zero,
                  ),
                ]),
          )
        ],
      ),
    );
  }
}
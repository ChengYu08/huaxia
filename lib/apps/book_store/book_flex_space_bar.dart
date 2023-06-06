
import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:huaxia/config/config.dart';

class BookFlexSpaceBar extends StatelessWidget {
  const BookFlexSpaceBar({
    super.key,
    required TabController tabController,
  }) : _tabController = tabController;

  final TabController _tabController;

  @override
  Widget build(BuildContext context) {
    return FlexibleSpaceBar(
      background: Stack(
        children: [
          Positioned.fill(
            child: Swiper.children(
              autoplay: true,
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
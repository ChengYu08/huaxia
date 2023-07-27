import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:huaxia/apps/book_store/logic.dart';
import 'package:huaxia/apps/home/logic.dart';
import 'package:huaxia/apps/login/logic.dart';
import 'package:huaxia/apps/login/model/user_model.dart';
import 'package:huaxia/config/config.dart';
import 'package:huaxia/widgets/persistent_header_builder.dart';

import 'logic.dart';

class MePage extends StatelessWidget {
  final logic = Get.find<MeLogic>();
  final loginIc = Get.find<LoginLogic>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: Get.theme.scaffoldBackgroundColor,
            title: Text(
              '我的',
              style: Get.textTheme.titleLarge,
            ),
            centerTitle: false,
            actions: [IconButton(onPressed: () {
              Get.toNamed(Routers.settingPage);
            }, icon: Icon(Icons.settings))],
            expandedHeight: 200,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                width: double.infinity,
                height: double.infinity,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(Imgs.ic_me_bg),
                        fit: BoxFit.fitWidth,
                        alignment: Alignment.topCenter)),
                child: StreamBuilder<UserModel>(
                  stream: loginIc.userStream,
                  initialData: loginIc.initUserModel,
                  builder: (context, snapshot) {
                    return Column(
                      children: [
                        const SizedBox(
                          height: kToolbarHeight + 32,
                        ),
                        if(snapshot.data?.user?.avatar!=null)
                        ImgNet.net(
                            '${snapshot.data?.user?.avatar}',
                            boxShape: BoxShape.circle,
                            width: 80,
                            height: 80,
                            fit: BoxFit.cover)else
                            CircleAvatar(
                              backgroundColor:Get.theme.primaryColor,
                                maxRadius: 40,
                            ),
                        const SizedBox(
                          height: 12,
                        ),
                        ValueListenableBuilder(
                          valueListenable: loginIc.loginState,
                          builder: (BuildContext context, LoginState value, Widget? child) {
                              if(value ==LoginState.authentication){
                                return Text(
                                  snapshot.data?.user?.nickName??'',
                                  style: Get.textTheme.displaySmall!
                                      .copyWith(fontWeight: FontWeight.w600),
                                );
                              }
                            return Text(
                              '登录/注册',
                              style: Get.textTheme.displaySmall!
                                  .copyWith(fontWeight: FontWeight.w600),
                            );
                          },
                          child: Text(
                            '登录/注册',
                            style: Get.textTheme.displaySmall!
                                .copyWith(fontWeight: FontWeight.w600),
                          ),
                        )
                      ],
                    );
                  }
                ),
              ),
            ),
          ),
          SliverPersistentHeader(
            pinned: false,
            delegate: PersistentHeaderBuilder(
                builder: (context, offset) {
                  return Container(
                    width: double.infinity,
                    height: double.infinity,
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    margin: const EdgeInsets.symmetric(horizontal: 16),
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage(Imgs.ic_me_vip_bg),
                            fit: BoxFit.fill)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Image.asset(
                                  Imgs.ic_vip,
                                  width: 24,
                                  height: 24,
                                ),
                                const SizedBox(
                                  width: 4,
                                ),
                                const Text(
                                  '华夏国学',
                                  style: TextStyle(
                                      color: Color(0xff26211B),
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                )
                              ],
                            ),
                            const Text(
                              '支持国学复兴，开通会员付费',
                              style: TextStyle(
                                  color: Color(0xff776651),
                                  fontSize: 12,
                                  fontWeight: FontWeight.normal),
                            )
                          ],
                        ),
                        ElevatedButton(
                            onPressed: () {
                              Get.toNamed(Routers.vipPage);
                            },
                            style: ElevatedButton.styleFrom(
                                backgroundColor: const Color((0xff221F20))),
                            child: const Text(
                              '立即开通',
                              style: TextStyle(
                                  color: Color(0xffFFD8B2), fontSize: 12),
                            ))
                      ],
                    ),
                  );
                },
                min: 60,
                max: 80),
          ),
          SliverToBoxAdapter(
            child: Container(
              padding: const EdgeInsets.all(16),

              decoration: BoxDecoration(
                  color: Color(0XFFF7F8FA),
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20)),
                  boxShadow: [
                    BoxShadow(
                        offset: Offset(0, -4),
                        blurRadius: 15,
                        spreadRadius: 0,
                        color: Colors.black.withOpacity(.1))
                  ]),
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 14, horizontal: 27),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        buildColumn(s1: Imgs.ic_me_book, s2: '书架', s3: '12',onTap: (){
                          final home = Get.find<HomeLogic>();
                          home.jump(1);
                          final book = Get.find<BookStoreLogic>();
                          book.changedBook.value=1;
                        }),
                        buildColumn(s1: Imgs.ic_me_sentence, s2: '句子', s3: '1',onTap: (){
                          Get.toNamed(Routers.sentencePage);
                        }),
                        buildColumn(s1: Imgs.ic_me_notes, s2: '笔记', s3: '132'),
                        buildColumn(s1: Imgs.ic_me_browse, s2: '浏览', s3: '142'),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12)),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        buildListTile(s1: Imgs.ic_widget,s2: '小组件设置'),
                        const Divider(height:0,indent: 50,thickness: .5,color: Color(0xffE1E2E8),),
                        buildListTile(s1: Imgs.ic_me_feedback,s2: '意见反馈'),
                        const Divider(height:0,indent: 50,thickness: .5,color: Color(0xffE1E2E8 ),),
                        buildListTile(s1: Imgs.ic_me_group,s2: '入群学习'),
                      ],
                    ),
                  ),
                  const SizedBox(height: 100,)
                ],
              ),
            ),
          ),

        ],
      ),
    );
  }

  ListTile buildListTile({required String s1,required String s2,GestureTapCallback? onTap}) {
    return ListTile(
      onTap: onTap,
      leading: Image.asset(
        s1,
        width: 24,
        height: 24,
      ),
      title: Text(s2,style: Get.textTheme.bodySmall,),
      trailing: Image.asset(
        Imgs.ic_join,
        width: 22,
        height: 24,
      ),
    );
  }

  Widget buildColumn(
      {required String s1, required String s2, required String s3,GestureTapCallback? onTap}) {
    return GestureDetector(
      onTap:onTap,
      child: Column(
        children: [
          Image.asset(
            s1,
            width: 28,
            height: 28,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8, bottom: 2),
            child: Text(
              s2,
              style: Get.textTheme.bodySmall,
            ),
          ),
          Text(
            s3,
            style: Get.textTheme.labelLarge,
          )
        ],
      ),
    );
  }
}

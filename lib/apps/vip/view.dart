import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:huaxia/apps/login/logic.dart';
import 'package:huaxia/apps/login/model/user_model.dart';
import 'package:huaxia/apps/vip/model/VIPList.dart';
import 'package:huaxia/config/config.dart';
import 'package:huaxia/config/http/async_builder/async_builder.dart';

import 'logic.dart';

const _textStyle = TextStyle(color: Color(0xff83888F), fontSize: 12);

class VipPage extends StatelessWidget {
  final logic = Get.find<VipLogic>();
  final userLogic = Get.find<LoginLogic>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('华夏国学会员'),
        actions: [
          IconButton(
              onPressed: () {},
              icon: Image.asset(
                Imgs.ic_share,
                width: 24,
                height: 24,
              ))
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: buildPay(),
      backgroundColor: Colors.black,
      body: ListView(
        children: [
          buildProfile(),
          Container(
            padding: const EdgeInsets.only(left: 15, right: 15, top: 26),
            decoration: BoxDecoration(
                color: Get.theme.scaffoldBackgroundColor,
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20))),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                buildSelectVipType(),
                buildTitle('支付方式'),
                buildPayType(),
                buildTitle('其他推荐'),
                buildIntr('句子查看原文', '句子浏览时可随意查看原文书籍', Imgs.bg_intr_1),
                buildIntr('桌面个性小组件', '名言警句桌面警示或好句子推送', Imgs.bg_intr_3),
                buildIntr('阅读器个性化设置', '阅读器背景、字体、阅读方式个性化设置', Imgs.bg_intr_4),
                buildTitle('购买须知'),
                const Text(
                  '1. 会员开通为虚拟服务，不支持退款',
                  style: _textStyle,
                ),
                const SizedBox(
                  height: 12,
                ),
                const Text(
                  '2. 提示开通会员成功后，重新登录App',
                  style: _textStyle,
                ),
                Row(
                  children: [
                    const Text(
                      '3. 超过10分钟后联系客服微信：hxgxapp',
                      style: _textStyle,
                    ),
                    IconButton(
                        onPressed: () async {
                          ClipboardData data =
                          const ClipboardData(text: 'hxgxapp');
                          Clipboard.setData(data);
                          AppToast.toast('已复制：hxgxapp');
                        },
                        icon: Image.asset(
                          Imgs.ic_text_copy,
                          width: 20,
                          height: 20,
                        ))
                  ],
                ),
                const Text(
                  '4. 取消续订：订阅期到期前24小时可取消下月续费',
                  style: _textStyle,
                ),
                const SizedBox(
                  height: 100,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Container buildPay() {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.only(left: 16, top: 14, bottom: 14),
      child: Row(
        children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AsyncBuilder(
                  future: logic.vip_list,
                  builder: (context, snapshot) {
                    return Obx(() {
                      return RichText(
                          text: TextSpan(
                              text: '￥',
                              style: Get.textTheme.bodySmall,
                              children: [
                                TextSpan(
                                  text: '${snapshot?.data?.firstWhere((
                                      element) =>
                                  element.vipTypeId ==
                                      logic.selectVipPriceID.value).price}',
                                  style: Get.textTheme.bodySmall!.copyWith(
                                    fontSize: 24,
                                  ),
                                )
                              ]));
                    });
                  }
              ),
              RichText(
                  text: const TextSpan(
                      text: '支付即同意',
                      style:
                      TextStyle(color: Color(0xff83888F), fontSize: 10),
                      children: [
                        TextSpan(
                          text: '《会员协议》',
                          style:
                          TextStyle(color: Color(0xff202329), fontSize: 10),
                        ),
                        TextSpan(
                          text: '《自动续费协议》',
                          style:
                          TextStyle(color: Color(0xff202329), fontSize: 10),
                        ),
                      ])),
            ],
          ),
          const SizedBox(
            width: 12,
          ),
          ElevatedButton(
              onPressed: logic.pay,
              style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xff3F3735)),
              child: const Text(
                '立即开通',
                style: TextStyle(
                    color: Color(0xffFFD8B2),
                    fontSize: 18,
                    fontWeight: FontWeight.w500),
              ))
        ],
      ),
    );
  }

  Widget buildTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(top: 24, bottom: 12),
      child: Text(
        title,
        style: Get.textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.w500),
      ),
    );
  }

  Container buildIntr(String t1, String t2, String t3) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        image: DecorationImage(
            image: AssetImage(Imgs.bg_vip_intr), alignment: Alignment.topLeft),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  t1,
                  style: Get.textTheme.bodyMedium!
                      .copyWith(fontWeight: FontWeight.w500),
                ),
                const SizedBox(
                  height: 6,
                ),
                Text(
                  t2,
                  style: Get.textTheme.labelLarge,
                ),
              ],
            ),
          ),
          const SizedBox(
            width: 12,
          ),
          Image.asset(
            t3,
            width: 68,
            height: 68,
          )
        ],
      ),
    );
  }

  Widget buildSelectVipType() {
    return AsyncBuilder(
        future: logic.vip_list,
        builder: (context, snapshot) {
          return Obx(() {
            return Row(
                children: snapshot!.data!.map((e) =>
                    Expanded(child: buildVip(e))).toList()
            );
          });
        }
    );
  }

  Obx buildPayType() {
    return Obx(() {
      return Row(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () {
                logic.selectPayType.value = 1;
              },
              child: Container(
                padding: const EdgeInsets.only(
                    top: 18, bottom: 18, left: 8, right: 8),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12)),
                child: Row(
                  children: [
                    Image.asset(
                      Imgs.ic_wx,
                      width: 24,
                      height: 24,
                    ),
                    const SizedBox(width: 3,),
                    Text(
                      '微信支付',
                      style: Get.textTheme.bodySmall,
                    ),
                    const Spacer(),
                    if (logic.selectPayType.value == 1)
                      ImageIcon(
                        AssetImage(Imgs.ic_check),
                        size: 24,
                        color: Get.theme.primaryColor,
                      )
                    else
                      Icon(
                        Icons.radio_button_off_sharp,
                        size: 24,
                        color: Get.theme.scaffoldBackgroundColor,
                      ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(
            width: 12,
          ),
          Expanded(
            child: GestureDetector(
              onTap: () {
                logic.selectPayType.value = 2;
              },
              child: Container(
                padding: const EdgeInsets.only(
                    top: 18, bottom: 18, left: 8, right: 8),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12)),
                child: Row(
                  children: [
                    Image.asset(
                      Imgs.ic_zfb,
                      width: 24,
                      height: 24,
                    ),
                    const SizedBox(width: 3,),
                    Text(
                      '支付宝支付',
                      style: Get.textTheme.bodySmall,
                    ),
                    const Spacer(),
                    if (logic.selectPayType.value == 2)
                      ImageIcon(
                        AssetImage(Imgs.ic_check),
                        size: 24,
                        color: Get.theme.primaryColor,
                      )
                    else
                      Icon(
                        Icons.radio_button_off_sharp,
                        size: 24,
                        color: Get.theme.scaffoldBackgroundColor,
                      ),
                  ],
                ),
              ),
            ),
          ),
        ],
      );
    });
  }

  Widget buildVip(VIPList vipList) {
    final selectCurrent = vipList.vipTypeId == logic.selectVipPriceID.value;
    return Padding(
      padding: const EdgeInsets.only(left: 6, right: 6),
      child: GestureDetector(
        onTap: () {
          logic.selectVipPriceID.value = vipList.vipTypeId!;
        },
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: selectCurrent ? const Color(0xffFDF9EE) : Colors.white,
              border: selectCurrent
                  ? Border.all(color: const Color(0xffF0C58E), width: 1)
                  : null),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const SizedBox(
                height: 20,
              ),
              Text(
                vipList.title ?? '--',
                style: TextStyle(color: Color(0xff83888F), fontSize: 14),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 6),
                child: RichText(
                    text: TextSpan(
                        text: '￥',
                        style:
                        Get.textTheme.displayMedium!.copyWith(fontSize: 14),
                        children: [
                          TextSpan(
                              text: '${vipList.price ?? 0}',
                              style: Get.textTheme.displayMedium)
                        ])),
              ),
              Text(
                '原价￥${vipList.oldPrice ?? 0}',
                style: TextStyle(
                    color:selectCurrent?Color(0xff787369 ): Color(0xffC2C6CE),
                    decoration: TextDecoration.lineThrough,
                    decorationColor:selectCurrent?Color(0xff787369 ): Color(0xffC2C6CE),
                    decorationStyle: TextDecorationStyle.solid,
                    decorationThickness: 3,
                    height: 2,
                    textBaseline: TextBaseline.ideographic,
                    fontSize: 14),
              ),
              const SizedBox(
                height: 8,
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                    vertical: 3, horizontal: 11),
                decoration: BoxDecoration(
                  color: selectCurrent ? Color(0xffF9E5CA) : Color(0xffF4F5F7),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  vipList.validStr ?? '--',
                  style: Get.textTheme.displayMedium!
                      .copyWith(fontSize: 12, fontWeight: FontWeight.w400),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Container buildProfile() {
    return Container(
      margin: const EdgeInsets.only(top: 28, left: 16, right: 16),
      padding: const EdgeInsets.only(top: 20, bottom: 16, right: 16, left: 16),
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage(Imgs.ic_me_vip_bg), fit: BoxFit.fill)),
      child: StreamBuilder<UserModel>(
          stream: userLogic.userStream,
          initialData: userLogic.initUserModel,
          builder: (context, snapshot) {
            return Row(
              children: [
                if (snapshot.data?.user?.avatar != null)
                  ImgNet.net('${snapshot.data?.user?.avatar}',
                      boxShape: BoxShape.circle,
                      width: 48,
                      height: 48,
                      border: Border.all(color: Colors.white, width: 1),
                      fit: BoxFit.cover)
                else
                  CircleAvatar(
                    backgroundColor: Get.theme.primaryColor,
                    maxRadius: 24,
                  ),
                const SizedBox(
                  width: 12,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Text(
                          snapshot.data?.user?.nickName ?? '',
                          style: Get.textTheme.displaySmall!
                              .copyWith(fontWeight: FontWeight.w600),
                        ),
                        Image.asset(
                          Imgs.ic_vip,
                          width: 24,
                          height: 24,
                        ),
                      ],
                    ),
                    const Text(
                      "有效期至2038-10-01",
                      style: TextStyle(color: Color(0xff776651), fontSize: 12),
                    )
                  ],
                )
              ],
            );
          }),
    );
  }
}

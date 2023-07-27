import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:huaxia/apps/login/logic.dart';
import 'package:huaxia/config/config.dart';

import 'about_me_page.dart';
import 'logic.dart';

class SettingPage extends StatelessWidget {
  final logic = Get.find<SettingLogic>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('设置'),
      ),
      body: Column(
        children: [
          Container(
            margin: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
            padding: const EdgeInsets.only(left: 15, right: 15,top: 12,bottom: 12),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12)
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('使用音量键翻页', style: Get.textTheme.bodySmall,),
                    Obx(() {
                      return CupertinoSwitch(
                          value: logic.volume.value, onChanged: (v){
                            logic.volume.value = v;
                      });
                    }),
                  ],
                ),
                const Divider(thickness: .5,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('阅读时不自动锁屏', style: Get.textTheme.bodySmall,),
                    Obx(() {
                      return CupertinoSwitch(
                          value: logic.lock.value, onChanged: (v){
                        logic.lock.value = v;
                      });
                    }),
                  ],
                ),
                const Divider(thickness: .5,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('阅读时显示时间和电量', style: Get.textTheme.bodySmall,),
                    Obx(() {
                      return CupertinoSwitch(
                          value: logic.bey.value, onChanged: (v){
                        logic.bey.value = v;
                      });
                    }),
                  ],
                ),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric( horizontal: 16),
            padding: const EdgeInsets.only(left: 15, right: 15,top: 12,bottom: 12),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12)
            ),
            child: Column(
              children: [
                InkWell(
                  onTap: (){
                    Get.to(()=>const AboutMePage());
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('关于我们', style: Get.textTheme.bodySmall,),
                      Icon(Icons.arrow_forward_ios)
                    ],
                  ),
                ),
                const Divider(thickness: .5,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('注销账户', style: Get.textTheme.bodySmall,),
                    Icon(Icons.arrow_forward_ios)
                  ],
                ),
              ],
            ),
          ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.all(16),
            child: SizedBox(
                width: double.infinity,
                height: 45,
                child: ElevatedButton(onPressed: (){
                  Get.offAllNamed(Routers.login);
                  final u = Get.find<LoginLogic>();

                  u.cleanUser();

                }, child: Text('退出登录'))),
          ),
          const Spacer(),
        ],
      ),
    );
  }
}

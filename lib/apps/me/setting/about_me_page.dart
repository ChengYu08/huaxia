
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:huaxia/config/config.dart';
import 'package:package_info_plus/package_info_plus.dart';

class AboutMePage extends StatelessWidget {
  const AboutMePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('关于我们'),
      ),
      body:  Column(
        children: [
          const SizedBox(height: 60,),
          Image.asset(Imgs.logo,width: 60,height: 60,),
          const SizedBox(height: 10,),
          Image.asset(Imgs.bg_login_text,width: 106,height: 40,),
          Padding(
            padding: const EdgeInsets.only(top: 5,bottom: 20),
            child: FutureBuilder<PackageInfo>(
              future: PackageInfo.fromPlatform(),
              builder: (context, snapshot) {
                return Text('v${snapshot.data?.version??"1.0.0"}',style: Get.textTheme.bodyLarge,);
              }
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('用户协议', style: Get.textTheme.bodySmall,),
                    Icon(Icons.arrow_forward_ios,color: Get.theme.dividerColor,)
                  ],
                ),
                const Divider(thickness: .5,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('隐私政策', style: Get.textTheme.bodySmall,),
                    Icon(Icons.arrow_forward_ios,color: Get.theme.dividerColor,)
                  ],
                ),
              ],
            ),
          ),
          const Spacer(),
          Text('重庆易工作科技公司版权所有',style: Get.textTheme.labelLarge,),
          Text('版权获得时间：xx年xx月xx日',style: Get.textTheme.labelLarge,),
          const SizedBox(height: 50,)
        ],
      ),
    );
  }
}

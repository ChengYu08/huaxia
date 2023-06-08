import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:huaxia/config/assets/imgs.dart';

import 'logic.dart';

class SentencePage extends StatelessWidget {
  final logic = Get.find<SentenceLogic>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('句子'),
      ),
      body: ListView.builder(
          padding: const EdgeInsets.symmetric(vertical: 12,horizontal: 16 ),
          itemBuilder: (context,index){
        return Container(
          padding: const EdgeInsets.only(left: 12,right: 12,top: 12),
          margin: const EdgeInsets.only(bottom: 12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12)
          ),
          child: IntrinsicHeight(
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('《周易》',style: Get.textTheme.bodySmall!.copyWith(fontWeight: FontWeight.bold),),
                      const SizedBox(height: 8,),
                      Text('天行健，君子以自强不息。地势坤，君子以厚德载物。',style: Get.textTheme.bodySmall,),

                      Row(
                        children: [
                          TextButton.icon(onPressed: (){

                          }, icon: Image.asset(Imgs.ic_wach,width: 20,height: 20,),
                          label: Text('查看出处',style: Get.textTheme.labelLarge,),
                         ),
                          TextButton.icon(onPressed: (){

                          }, icon: Image.asset(Imgs.ic_share,width: 20,height: 20,),
                            label: Text('分享',style: Get.textTheme.labelLarge,),
                          ),

                        ],
                      ),

                    ],
                  ),
                ),
                const SizedBox(width: 12,),
                 SizedBox(
                   height: double.infinity,
                   child: Align(
                       alignment:  const Alignment(0.0, -.6),
                       child: Image.asset(Imgs.ic_like_no,width: 24,height:24,)),
                 )
              ],
            ),
          ),
        );
      }),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:huaxia/widgets/book_cover.dart';

import 'logic.dart';

class Me_read_historyPage extends StatelessWidget {
  final logic = Get.find<Me_read_historyLogic>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('浏览历史'),
      ),
      body: ListView.builder(
          padding: const EdgeInsets.all(16),
          itemBuilder: (_,index){
        return Container(
          padding: const EdgeInsets.all(12),
          margin: const EdgeInsets.only(bottom: 12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              BookCover(title: '123',),
              SizedBox(width: 12,),
              Column(
                children: [
                  Text('论语',style: Get.textTheme.bodyMedium,),
                  const Spacer(),
                  Text('已读1%',style: Get.textTheme.labelMedium,),
                  Text('2023-03-03',style: Get.textTheme.labelMedium,),
                ],
              ),
              const Spacer(),
              Container(
                padding: const EdgeInsets.only(top: 3,bottom: 3,left: 6,right: 6),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: Get.theme.primaryColor,width: 1),
                ),
                child:  Text('加入书架',style: Get.textTheme.bodyMedium!.copyWith(color: Get.theme.primaryColor),),
              )
            ],
          ),
        );
      }),
    );
  }
}

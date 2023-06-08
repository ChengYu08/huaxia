import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'logic.dart';

class AddSentencePage extends StatelessWidget {
  final logic = Get.find<AddSentenceLogic>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('添加句子'),
      ),
    floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    floatingActionButton:   Padding(
      padding: const EdgeInsets.all(16.0),
      child: SizedBox(
          width: double.infinity,
          height: 44,
          child: ElevatedButton(onPressed: (){}, child: Text('确定发布'))),
    ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 17),
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('内容',style: Get.textTheme.titleSmall!.copyWith(fontWeight: FontWeight.bold),),
          ),
          TextField(
            maxLines: 3,
            maxLength: 30,
            decoration: InputDecoration(
              filled: true,
              hintText: '请认真填写您要分享的句子,否则将不予以展现',
              hintStyle: Get.textTheme.labelLarge!.copyWith(fontSize: 14),
              fillColor: Colors.white,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none
              )
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('译文',style: Get.textTheme.titleSmall!.copyWith(fontWeight: FontWeight.bold),),
          ),
          TextField(
            maxLines: 3,
            maxLength: 30,
            decoration: InputDecoration(
              filled: true,
              hintText: '请认真填写您要分享的句子,否则将不予以展现',
              hintStyle: Get.textTheme.labelLarge!.copyWith(fontSize: 14),
              fillColor: Colors.white,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none
              )
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('出处',style: Get.textTheme.titleSmall!.copyWith(fontWeight: FontWeight.bold),),
          ),
          SizedBox(
            height: 41,
            child: TextField(
              decoration: InputDecoration(
                  filled: true,
                  hintText: '输入书名',
                  hintStyle: Get.textTheme.labelLarge!.copyWith(fontSize: 14),
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none
                  )
              ),
            ),
          ),
          const SizedBox(height: 8,),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('章节',style: Get.textTheme.titleSmall!.copyWith(fontWeight: FontWeight.bold),),
          ),
          SizedBox(
            height: 41,
            child: TextField(
              decoration: InputDecoration(
                  filled: true,
                  hintText: '输入书名-章节',
                  hintStyle: Get.textTheme.labelLarge!.copyWith(fontSize: 14),
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none
                  )
              ),
            ),
          ),

        ],
      ),
    );
  }
}

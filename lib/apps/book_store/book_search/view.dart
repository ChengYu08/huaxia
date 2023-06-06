import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:huaxia/config/assets/imgs.dart';

import 'logic.dart';

class BookSearchPage extends StatelessWidget {
  final logic = Get.find<BookSearchLogic>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Get.theme.scaffoldBackgroundColor,
        automaticallyImplyLeading: false,
        title: SizedBox(
          height: 56,
          child: TextField(
            controller: logic.controller,
            decoration: InputDecoration(
                fillColor: Colors.white,
                filled: true,
                prefixIcon: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: ImageIcon(AssetImage(Imgs.ic_search)),
                ),
                prefixIconColor: Color(0xff83888F),
                hintText: '书名或作者',
                hintStyle: Get.textTheme.labelLarge,
                prefixIconConstraints: BoxConstraints(
                  minHeight: 24,
                  minWidth: 24,
                ),
                contentPadding: const EdgeInsets.only(left: 20),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(18),
                  borderSide: BorderSide.none,
                )),
          ),
        ),
        actions: [
          TextButton(
              onPressed: () {
                Get.back();
              },
              child: Text(
                '取消',
                style: Get.textTheme.bodySmall,
              ))
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '历史搜索',
                  style: Get.textTheme.bodyMedium!
                      .copyWith(fontWeight: FontWeight.bold),
                ),
                IconButton(
                    onPressed: () {},
                    icon: Image.asset(
                      Imgs.ic_delect,
                      width: 24,
                      height: 24,
                    ))
              ],
            ),
          ),
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: [
              ...List.generate(10, (index) =>   RawChip(
                label: Text('论语$index',style: Get.textTheme.bodySmall,),
                onPressed: () {},
                showCheckmark: false,
                side: BorderSide(color: Colors.white, width: 1),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
                backgroundColor: Colors.white,
                padding: EdgeInsets.symmetric(vertical: 5,horizontal: 12),
              ),)

            ],
          ),

        ],
      ),
    );
  }
}

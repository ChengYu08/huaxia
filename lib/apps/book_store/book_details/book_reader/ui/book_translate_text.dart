import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:huaxia/apps/book_store/book_details/book_reader/logic.dart';

class BookTranslateText extends StatelessWidget {
  final BookReaderLogic bookReaderLogic;

  const BookTranslateText({
    super.key, required this.bookReaderLogic,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if(bookReaderLogic.menuBottomShow.value){
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FloatingActionButton(onPressed: () {
              bookReaderLogic.translateText.value = 0;
            },
              shape: const CircleBorder(
                  side: BorderSide(color: Colors.white, width: 1)),
              backgroundColor: Colors.white,
              child: Text('原文', style: Get.textTheme.bodySmall!.copyWith(color:   bookReaderLogic.translateText.value == 0?Get.theme.primaryColor:null),
              ),),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: FloatingActionButton(onPressed: () {
                bookReaderLogic.translateText.value = 1;
              },
                backgroundColor: Colors.white,
                shape: const CircleBorder(
                    side: BorderSide(color: Colors.white, width: 1)),
                child: Text('译文', style: Get.textTheme.bodySmall!.copyWith(color:   bookReaderLogic.translateText.value == 1?Get.theme.primaryColor:null),),),
            ),
            FloatingActionButton(onPressed: () {
              bookReaderLogic.translateText.value = 2;
            },
              backgroundColor: Colors.white,
              shape: const CircleBorder(
                  side: BorderSide(color: Colors.white, width: 1)),
              child: Text('解读', style: Get.textTheme.bodySmall!.copyWith(color:bookReaderLogic.translateText.value == 2?Get.theme.primaryColor:null),),),
          ],
        );
      }else{
        return const SizedBox.shrink();
      }

    });
  }
}
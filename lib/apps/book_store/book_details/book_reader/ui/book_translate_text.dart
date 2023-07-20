import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:huaxia/application/tts/tts_app.dart';
import 'package:huaxia/apps/book_store/book_details/book_reader/logic.dart';
import 'package:huaxia/config/assets/imgs.dart';
import 'package:huaxia/config/routers/app_routers.dart';

class BookTranslateText extends StatelessWidget {
  final BookReaderLogic bookReaderLogic;

   BookTranslateText({
    super.key, required this.bookReaderLogic,
  });
  final ttsApp = Get.find<TTSApp>();
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if(bookReaderLogic.menuBottomShow.value){
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 50,),
            FloatingActionButton(onPressed: () {
              bookReaderLogic.translateText.value = 0;
            },
              heroTag: '原文',
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
                heroTag: '译文',
                shape: const CircleBorder(
                    side: BorderSide(color: Colors.white, width: 1)),
                child: Text('译文', style: Get.textTheme.bodySmall!.copyWith(color:   bookReaderLogic.translateText.value == 1?Get.theme.primaryColor:null),),),
            ),
            FloatingActionButton(onPressed: () {
              bookReaderLogic.translateText.value = 2;
            },
              backgroundColor: Colors.white,
              heroTag: '解读',
              shape: const CircleBorder(
                  side: BorderSide(color: Colors.white, width: 1)),
              child: Text('解读', style: Get.textTheme.bodySmall!.copyWith(color:bookReaderLogic.translateText.value == 2?Get.theme.primaryColor:null),),),
            Padding(
              padding: const EdgeInsets.only(top: 18),
              child: ValueListenableBuilder(
                valueListenable: ttsApp.showBookSpeak,
                builder: (BuildContext context, bool value, Widget? child) {
                  if(value){
                    return const SizedBox.shrink();
                  }else{
                    return IconButton(onPressed: (){
                      if(value && !ttsApp.showPages.value){
                        ttsApp.showPages.value = true;
                      }else{
                      ttsApp.openSpeakPage(context, bookChapter: bookReaderLogic.bookChapter.value,
                          tag: '${bookReaderLogic.bookId}', bookId: bookReaderLogic.bookId,
                          isJoin: bookReaderLogic.isJoin.value,
                          index: bookReaderLogic.currentIndex.value,
                          title: bookReaderLogic.title, author: bookReaderLogic.title);
                      }
                    }, icon: Image.asset(Imgs.ic_listen,width: 60,height: 60,));
                  }
                },

              ),
            )
          ],
        );
      }else{
        return const SizedBox.shrink();
      }

    });
  }
}
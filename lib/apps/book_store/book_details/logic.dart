import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:huaxia/application/tts/tts_app.dart';
import 'package:huaxia/apps/book_store/model/BookList.dart';
import 'package:huaxia/apps/book_store/my_book_logic.dart';
import 'package:huaxia/apps/login/logic.dart';
import 'package:huaxia/tools/wx_share.dart';
import 'package:huaxia/widgets/book_cover.dart';
import 'package:huaxia/widgets/drop_shadow_image.dart';

import '../../../config/config.dart';
import '../../login/model/user_model.dart';
import '../model/Catalogue.dart';
import 'book_reader/data/book_chapter.dart';

class BookDetailsLogic extends GetxController {

  var  book = BookList().obs;
  late Future<ApiResult<List<Catalogue>>>   bookCatalogue;
  late int bookId;
@override
  void onInit() {
  bookId = int.parse('${Get.parameters['bookId']}');
      if(Get.arguments is BookList){
        book.value = Get.arguments as BookList;
      }else{
        Api.book_info(bookId).then((value) {
          if(value.success){
            book.value = value.data!;
          }
        });
      }


      bookCatalogue= Api.book_Catalogue(bookId);
    super.onInit();
  }

  void goBook(List<Catalogue> catalogue) {
    final List<BookChapter> b = catalogue
        .map((catalogue) => BookChapter(
        title: catalogue.secondCatalogue,
        bookId: book.value.bookId,
        paragraphId: catalogue.bookCatalogueId!))
        .toList();
    Get.toNamed(Routers.bookReaderPage, arguments: b, parameters: {
      'bookId': '${book.value.bookId}',
      'title': '${book.value.name}',
      'author': '${book.value.author}',
      'isJoin': '${book.value.isJoin}',
      'index': '0',
    });
  }
  share(){
  final boundaryKey = GlobalKey();
  final user = Get.find<LoginLogic>();
    Get.bottomSheet(Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        RepaintBoundary(
          key: boundaryKey,
          child: Container(
            margin: const EdgeInsets.all(15),
            padding: const EdgeInsets.only(left: 34,right: 34,top: 38,bottom: 18),
            width: double.infinity,
            decoration: BoxDecoration(
                image: DecorationImage(image: AssetImage(Imgs.bg_share),fit: BoxFit.fill)
            ),
            child: Column(

              children: [
                StreamBuilder<UserModel>(
                    stream: user.userStream,
                    initialData: user.initUserModel,
                    builder: (context, snapshot) {
                      return Row(
                        children: [
                          ImgNet.net('${snapshot.data?.user?.avatar}',width: 40,height: 40,
                              boxShape: BoxShape.circle,
                              border: Border.all(color: Colors.white,width: 1)
                          ),
                          Column(
                            children: [
                              Row(
                                children: [
                                  Text(snapshot.data?.user?.nickName??'',style: Get.textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.w500) ,),
                                  if(snapshot.data?.user?.vip==1)
                                    Image.asset(Imgs.ic_vip,width: 24,height: 24,)
                                ],
                              ),
                              Text('隐藏个人信息',style: Get.textTheme.labelLarge ,),

                            ],
                          ),

                        ],
                      );
                    }
                ),
                const SizedBox(height: 50,),
                SizedBox(
                  width: 125,
                  height: 170,
                  child:BookCover(
                    title: "${book.value.name}",
                    width: 120,
                    height: 164,
                  )
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  '${book.value.name}',
                  style: Get.textTheme.displaySmall!
                      .copyWith(fontWeight: FontWeight.w500),
                ),
                const SizedBox(
                  height: 7,
                ),
                Text(
                  '${book.value.author}',
                  style: Get.textTheme.bodySmall,
                ),
                const SizedBox(height: 100,),
              ],
            ),
          ),
        ),
        const SizedBox(height: 20,),
        Container(
          width: double.infinity,
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(topRight: Radius.circular(20),topLeft: Radius.circular(20)),
            color: Colors.white,
          ),
          child: Column(
            children: [
              const SizedBox(height: 11,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  GestureDetector(
                    onTap: ()async{
                      WxShare.shareWxSession(boundaryKey, description: book.value.name??'');
                    },
                    child: Column(
                      children: [
                        Image.asset(Imgs.ic_share_wx,width: 48,height: 48,),
                        const SizedBox(height: 6,),
                        Text('微信',style: Get.textTheme.labelLarge,)
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: (){
                      WxShare.shareWxTimeline(boundaryKey,description: book.value.name??'');
                    },
                    child: Column(
                      children: [
                        Image.asset(Imgs.ic_share_wx_2,width: 48,height: 48,),
                        const SizedBox(height: 6,),
                        Text('微信朋友圈',style: Get.textTheme.labelLarge,)
                      ],
                    ),
                  ),
                ],
              ),
              const Divider(),
              TextButton(onPressed: (){
                Get.back();
              }, child: Text('关闭'))
            ],
          ),
        )
      ],
    ),isScrollControlled: true);
  }
  void openBookMuem( List<Catalogue> data){
    Get.bottomSheet(
      ListView.separated(
      itemCount:data.length,
    itemBuilder: (_,index){
        final d = data[index];
        return ListTile(
          title:Text(d.firstCatalogue??''),
        );
      }, separatorBuilder: (BuildContext context, int index) {
        return Divider();
      },),
      backgroundColor: Colors.white,

    );
  }

  void addBook() {
    final c=AppLoading.loading();
    Api.book_shelf_add('${book.value.bookId}').then((value){
      c();
      if(value.success){
        AppToast.toast('加入成功');
        final myBook = Get.find<MyBookLogic>();
        myBook.getData();
        book.update((val) {
          val?.isJoin = 1;
        });
      }else{
        AppToast.toast(value.message);
      }
    }).catchError((e){
      AppToast.toast(e.message);
      c();
    });
  }

  void goSpeak(List<Catalogue> catalogue,BuildContext context) {
    final List<BookChapter> bookChapter = catalogue
        .map((catalogue) => BookChapter(
        title: catalogue.secondCatalogue,
        bookId: book.value.bookId,
        paragraphId: catalogue.bookCatalogueId!))
        .toList();
    final tts = Get.find<TTSApp>();
    tts.openSpeakPage(context, bookChapter:bookChapter,
        tag: '${book.value.bookId}', bookId: book.value.bookId!,
        title: book.value.name!, author: book.value.author!);
  }
}

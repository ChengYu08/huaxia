import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:huaxia/widgets/book_cover.dart';

import '../logic.dart';

class BookMenu extends StatelessWidget {
  const BookMenu({
    super.key,
    required this.logic,
  });

  final BookReaderLogic logic;
  @override
  Widget build(BuildContext context) {
    return Obx(() {

      return AnimatedPositioned(
        left: 0,
        right: 0,
        bottom: logic.m1.value ? 0 : -(Get.height),
        duration: 300.milliseconds,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
          width: double.infinity,
          height: Get.height * .75,
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(20), topLeft: Radius.circular(20)),
          ),
          child: Column(
            children: [
              Row(
                children: [
                  BookCover(title: '${logic.book.name}',
                    width: 68,
                    height: 68,
                  ),

                  const SizedBox(
                    width: 13,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${logic.book.name}',
                          style: Get.textTheme.headlineMedium!
                              .copyWith(fontWeight: FontWeight.w500),
                        ),
                        Text(
                          '共${logic.catalogues.length}章',
                          style: Get.textTheme.labelLarge!.copyWith(
                            fontSize: 14,
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              '已读1%',
                              style: Get.textTheme.labelLarge!
                                  .copyWith(fontSize: 14),
                            ),
                            TextButton.icon(
                              onPressed: () {},
                              icon: Icon(Icons.arrow_drop_down_sharp),
                              label: Text('去当前'),
                            )
                          ],
                        ),
                      ],
                    ),
                  )
                ],
              ),
              Expanded(
                child: Obx(() {
                  return  ListView.builder(
                      itemCount: logic.catalogues.length,
                      itemBuilder: (context, index) {
                        final c = logic.catalogues[index];
                        return ListTile(
                          onTap: (){
                            logic.toCuttex(index);
                          },
                          title:  Text('${c.secondCatalogue}',style: Get.theme.textTheme.titleMedium,),
                          trailing: Text('${c.sizeNum??0}',style: Get.textTheme.titleMedium,),
                        );
                      });
                }),
              )
            ],
          ),
        ),
      );
    });
  }
}
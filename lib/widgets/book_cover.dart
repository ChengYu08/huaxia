

import 'package:flutter/material.dart';
import 'package:huaxia/config/assets/imgs.dart';

class BookCover extends StatelessWidget {
   final double width;
   final double height;
   final String title;
  const BookCover({Key? key,  this.width=64,
    this.height=88, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final  textHeight = title.length*13.5+20;
    var h = height;
      if(height<textHeight){
        h=textHeight;
      }
    return Container(
      width: width,
      height: h,
      padding: const EdgeInsets.only(top: 4,left: 4),
      decoration: BoxDecoration(
        image: DecorationImage(image: AssetImage(Imgs.bg_book),fit: BoxFit.fill)
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(1),
            decoration: BoxDecoration(
                color: Color(0xffEDF1F3)
            ),
            child: Container(
              decoration: BoxDecoration(
                  color: Color(0xffE3E3DD),
                  border: Border.all(color: Color(0xff1B293D),width: .5 )
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                for(int i=0;i<title.length;i++)
                  Text(title[i],style: const TextStyle(color: Color(0xff1B3760),fontSize: 12,
                      fontFamily: 'MaShanZheng'),),
                ],
              )
            ),
          ),

        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:huaxia/config/config.dart';
import 'package:huaxia/widgets/custom_selectable_text/custom_selectable_text.dart';

class BookReaderLogic extends GetxController {
  var showFistPop= true.obs;
  @override
  void onInit() {

    super.onInit();
  }


  final customSelectableTextItems = [
    CustomSelectableTextItem.icon(icon: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(Imgs.ic_text_copy,width: 18,height: 18,color: Colors.white,),
        const Text('复制',style: TextStyle(color: Colors.white,fontSize: 10),)
      ],),controlType: SelectionControlType.copy,onPressed: (text){
      AppToast.toast('复制成功');
    }),
    CustomSelectableTextItem.icon(icon: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(Imgs.ic_share,width: 18,height: 18,color: Colors.white,),
        const Text('分享',style: TextStyle(color: Colors.white,fontSize: 10),)
      ],),controlType: SelectionControlType.other,onPressed: (text){
      AppToast.toast('正在开发中...');
    }),
    CustomSelectableTextItem.icon(icon: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(Imgs.ic_text_line,width: 18,height: 18,color: Colors.white,),
        const Text('划线',style: TextStyle(color: Colors.white,fontSize: 10),)
      ],),controlType: SelectionControlType.other,onPressed: (text){
      AppToast.toast('正在开发中...');
    }),
    CustomSelectableTextItem.icon(icon: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(Imgs.ic_text_idea,width: 18,height: 18,color: Colors.white,),
        const Text('想法',style: TextStyle(color: Colors.white,fontSize: 10),)
      ],),controlType: SelectionControlType.other,onPressed: (text){
      AppToast.toast('正在开发中...');
    }),  CustomSelectableTextItem.icon(icon: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(Imgs.ic_text_idea,width: 18,height: 18,color: Colors.white,),
        const Text('查询',style: TextStyle(color: Colors.white,fontSize: 10),)
      ],),controlType: SelectionControlType.other,onPressed: (text){
      AppToast.toast('正在开发中...');
    }),
  ];
}

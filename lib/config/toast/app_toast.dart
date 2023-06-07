
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';

class AppToast{
  static  toast(String msg){
    return BotToast.showText(text: msg,
      borderRadius: BorderRadius.circular(8),
      contentColor: Colors.black.withOpacity(.8),
      align: Alignment.center,
      contentPadding: const EdgeInsets.only(top: 14,bottom: 14,left: 10,right: 10),
      textStyle: const TextStyle(color: Colors.white,fontSize: 16)
    );
  }
}
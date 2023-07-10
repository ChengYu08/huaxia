import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:huaxia/apps/login/logic.dart';
import 'package:huaxia/config/config.dart';



class ScreenPage extends StatefulWidget {
  @override
  State<ScreenPage> createState() => _ScreenPageState();
}

class _ScreenPageState extends State<ScreenPage> {


  final login = Get.find<LoginLogic>();

@override
  void initState() {
  login.loginState.addListener(() {

    if( login.loginState.value == LoginState.authentication){
      Get.offAllNamed(Routers.home);
    }else{
      Get.offAllNamed(Routers.login);
    }
  });

    super.initState();
  }
  @override
  void dispose() {
    login.loginState.removeListener(() { });
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
        image: DecorationImage(image: AssetImage(Imgs.bg_start),fit: BoxFit.fill)),
        child:  Stack(
          alignment: Alignment.center,
          children: [
            Positioned(
              top: Get.statusBarHeight+50,
              child: Image.asset(Imgs.bg_start_text,width: 80,fit: BoxFit.fitWidth,)
            ),

            Positioned(
              bottom: 100,
              left: 0,
              right: 0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(Imgs.logo,width: 40,height: 40,),
                  const SizedBox(width: 6,),
                  Image.asset(Imgs.bg_login_text,height: 40,fit: BoxFit.fitHeight,),
                ],
              ),
            ),

          ],
        ),
      )
    );
  }
}

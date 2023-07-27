
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
class AppLoading{
    static loading({
      WrapAnimation? wrapToastAnimation,
      Alignment align = Alignment.center,
      String? title,
      BackButtonBehavior? backButtonBehavior,
      bool crossPage = true,
      bool clickClose = false,
      bool allowClick = false,
      bool enableKeyboardSafeArea = true,
      VoidCallback? onClose,
      Duration? duration,
      Duration? animationDuration,
      Duration? animationReverseDuration,
      Color backgroundColor = Colors.black26,
    }){
      return  BotToast.showCustomLoading(
        wrapAnimation: wrapToastAnimation,
        align: Alignment.center,
        backButtonBehavior: backButtonBehavior,
        crossPage: crossPage,
        clickClose: clickClose,
        allowClick:  allowClick,
        enableKeyboardSafeArea: enableKeyboardSafeArea,
        onClose: onClose,
        duration: duration,
        animationDuration: animationDuration,
        animationReverseDuration: animationDuration,
        backgroundColor: backgroundColor,
        toastBuilder: (_) => const LoadingWidget(),
      );

    }
}

//加载提示的Widget
class LoadingWidget extends StatelessWidget {
  final String? title;
  const LoadingWidget({Key? key, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: const BoxDecoration(
          color: Colors.black54,
          borderRadius: BorderRadius.all(Radius.circular(8))),
      child: title==null?const CircularProgressIndicator(
        backgroundColor: Colors.white,
      ):Column(
        children: [
          const CircularProgressIndicator(
            backgroundColor: Colors.white,
          ),
          Text(title!,)
        ],
      )
    );
  }
}

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:wechat_kit/wechat_kit.dart';

class WxShare {
  static shareWxSession(GlobalKey boundaryKey, {required String description}) async {
    RenderRepaintBoundary? boundary = boundaryKey.currentContext!
        .findRenderObject() as RenderRepaintBoundary?;
    double dpr = Get.pixelRatio; // 获取当前设备的像素比
    var image = await boundary!.toImage(pixelRatio: dpr);
    // 将image转化成byte
    ByteData? byteData = await image.toByteData(format: ImageByteFormat.png);

    Uint8List pngBytes = byteData!.buffer.asUint8List();
    WechatKitPlatform.instance.shareImage(
        scene: WechatScene.kSession,
        description: description,
        imageData: pngBytes);
  }

  static shareWxFavorite(GlobalKey boundaryKey, {required String description}) async {
    RenderRepaintBoundary? boundary = boundaryKey.currentContext!
        .findRenderObject() as RenderRepaintBoundary?;
    double dpr = Get.pixelRatio; // 获取当前设备的像素比
    var image = await boundary!.toImage(pixelRatio: dpr);
    // 将image转化成byte
    ByteData? byteData = await image.toByteData(format: ImageByteFormat.png);
    Uint8List pngBytes = byteData!.buffer.asUint8List();
    WechatKitPlatform.instance.shareImage(
        scene: WechatScene.kFavorite,
        description: description,
        imageData: pngBytes);
  }

  static shareWxTimeline(GlobalKey boundaryKey, {required String description}) async {
    RenderRepaintBoundary? boundary = boundaryKey.currentContext!
        .findRenderObject() as RenderRepaintBoundary?;
    double dpr = Get.pixelRatio; // 获取当前设备的像素比
    var image = await boundary!.toImage(pixelRatio: dpr);
    // 将image转化成byte
    ByteData? byteData = await image.toByteData(format: ImageByteFormat.png);
    Uint8List pngBytes = byteData!.buffer.asUint8List();
    WechatKitPlatform.instance.shareImage(
        scene: WechatScene.kTimeline,
        description: description,
        imageData: pngBytes);
  }

}

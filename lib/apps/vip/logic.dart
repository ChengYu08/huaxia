import 'dart:async';

import 'package:get/get.dart';
import 'package:huaxia/apps/login/logic.dart';
import 'package:huaxia/config/config.dart';
import 'package:huaxia/config/wechat/wechat.dart';
import 'package:wechat_kit/wechat_kit.dart';

import 'model/VIPList.dart';

class VipLogic extends GetxController {
  var selectVipPriceID = (-1).obs;

  var selectPayType = 1.obs;

  late Future<ApiResult<List<VIPList>>> vip_list;

  late final StreamSubscription<WechatResp> _respSubs;

  @override
  void onInit() {

    vip_list = Api.vip_list().then((value) {
      selectVipPriceID.value = value.data!.first.vipTypeId!;
      return value;
    });
    super.onInit();
    _respSubs = WechatKitPlatform.instance.respStream().listen(_listenResp);
  }

  pay() async {
    final c = AppLoading.loading();
    try {
      final add = await Api.vip_order_add(
          vipTypeId: selectVipPriceID.value, payType: selectPayType.value);
      await WeChatConfig.pay(add.data!);
      c();
    } catch (e) {
      c();
      if (e is ApiResult) {
        AppToast.toast(e.message);
      } else {
        AppToast.toast('$e');
      }
    }
  }

  void _listenResp(WechatResp event) {
    if (event is WechatPayResp) {
      if (event.isSuccessful) {
        final c = AppLoading.loading(title: '处理中...');
        final u = Get.find<LoginLogic>();
        u.reUser().then((value) {
          c();
          if (value != null) {
            if (value.vip == 1) {
              AppToast.toast("开通成功");
              if (Get.currentRoute == Routers.vipPage) {
                Get.back();
              }
            }
          }
        }).catchError((e) {
          c();
          AppToast.toast(e);
        });
      } else if (event.isCancelled) {
        ///用户主动取消支付
      } else {
        AppToast.toast("支付错误:${event.errorCode}-${event.errorMsg}");
      }
    }
  }
}

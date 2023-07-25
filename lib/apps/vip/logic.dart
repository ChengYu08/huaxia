import 'package:get/get.dart';
import 'package:huaxia/config/config.dart';

import 'model/VIPList.dart';

class VipLogic extends GetxController {
  var selectVipPriceID = (-1).obs;

  var selectPayType = 1.obs;

  final Map<int,VipModel> inVip ={
      0:VipModel(
        title: '连续包月',
        orgPrice: 11.5,
        currendPrice: 6.0,
        vipTimeLong: 30,
      ),
    1:VipModel(
      title: '包年会员',
      orgPrice: 120.5,
      currendPrice: 50.0,
      vipTimeLong: 360,
    ),
    2:VipModel(
      title: '永久会员',
      orgPrice: 288,
      currendPrice: 108,
      vipTimeLong: -1,
    ),
  };
late  Future<ApiResult<List<VIPList>>> vip_list;
  @override
  void onInit() {
    vip_list = Api.vip_list().then((value) {
      selectVipPriceID.value = value.data!.first.vipTypeId!;
      return value;
    });
    super.onInit();
  }
  pay()async{
    final c = AppLoading.loading();
    try{

    final add= await  Api.vip_order_add(vipTypeId: selectVipPriceID.value,
          payType: selectPayType.value);
    c();
    }catch (e){
      c();
      if(e is ApiResult){
        AppToast.toast(e.message);
      }else{
        AppToast.toast('$e');
      }
    }

  }
}

class VipModel{
  final String title;
  final double orgPrice;
  final double currendPrice;
  final int vipTimeLong;

  String  get vipLongStr{
      if(vipTimeLong==-1){
        return '永久有效';
      }else if(vipTimeLong ==360){
        return '一年有效';
      }else{
        return '一月有效';
      }
  }
  VipModel({
    required this.title, required this.orgPrice, required this.currendPrice, required this.vipTimeLong
});
}
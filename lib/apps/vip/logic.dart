import 'package:get/get.dart';

class VipLogic extends GetxController {
  var selectVipPrice = 0.obs;

  var selectPayType = 0.obs;

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
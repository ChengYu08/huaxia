import 'dart:convert';

T? asT<T>(dynamic value) {
  if (value is T) {
    return value;
  }
  return null;
}

class VIPList {
  const VIPList({
    this.createBy,
    this.validStr,
    this.createTime,
    this.updateBy,
    this.updateTime,
    this.remark,
    this.vipTypeId,
    this.title,
    this.price,
    this.oldPrice,
    this.nums,
    this.isDel,
  });

  factory VIPList.fromJson(Map<String, dynamic> json) => VIPList(
    createBy: asT<String?>(json['createBy']),
    createTime: asT<String?>(json['createTime']),
    updateBy: asT<String?>(json['updateBy']),
    updateTime: asT<String?>(json['updateTime']),
    validStr: asT<String?>(json['validStr']),
    remark: asT<String?>(json['remark']),
    vipTypeId: asT<int?>(json['vipTypeId']),
    title: asT<String?>(json['title']),
    price: asT<num?>(json['price']),
    oldPrice: asT<num?>(json['oldPrice']),
    nums: asT<int?>(json['num']),
    isDel: asT<int?>(json['isDel']),
  );

  final String? createBy;
  final String? createTime;
  final String? updateBy;
  final String? updateTime;
  final String? remark;
  final int? vipTypeId;
  final String? title;
  final num? price;
  final num? oldPrice;
  final int? nums;
  final String? validStr;
  final int? isDel;

  @override
  String toString() {
    return jsonEncode(this);
  }


  Map<String, dynamic> toJson() => <String, dynamic>{
    'createBy': createBy,
    'createTime': createTime,
    'updateBy': updateBy,
    'updateTime': updateTime,
    'remark': remark,
    'vipTypeId': vipTypeId,
    'title': title,
    'price': price,
    'oldPrice': oldPrice,
    'num': nums,
    'isDel': isDel,
  };
}

import 'dart:convert';

T? asT<T>(dynamic value) {
  if (value is T) {
    return value;
  }
  return null;
}

class VipPay {
  const VipPay({
    this.package,
    this.outTradeNo,
    this.appid,
    this.sign,
    this.partnerid,
    this.prepayid,
    this.noncestr,
    this.timestamp,
  });

  factory VipPay.fromJson(Map<String, dynamic> json) => VipPay(
    package: asT<String?>(json['package']),
    outTradeNo: asT<String?>(json['out_trade_no']),
    appid: asT<String?>(json['appid']),
    sign: asT<String?>(json['sign']),
    partnerid: asT<String?>(json['partnerid']),
    prepayid: asT<String?>(json['prepayid']),
    noncestr: asT<String?>(json['noncestr']),
    timestamp: asT<String?>(json['timestamp']),
  );

  final String? package;
  final String? outTradeNo;
  final String? appid;
  final String? sign;
  final String? partnerid;
  final String? prepayid;
  final String? noncestr;
  final String? timestamp;

  @override
  String toString() {
    return jsonEncode(this);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
    'package': package,
    'out_trade_no': outTradeNo,
    'appid': appid,
    'sign': sign,
    'partnerid': partnerid,
    'prepayid': prepayid,
    'noncestr': noncestr,
    'timestamp': timestamp,
  };
}

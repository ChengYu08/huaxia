import 'dart:convert';

import 'package:hive/hive.dart';
part 'user_model.g.dart';
T? asT<T>(dynamic value) {
  if (value is T) {
    return value;
  }
  return null;
}

@HiveType(typeId: 3)
class UserModel {
  const UserModel({
    this.userToken,
    this.user,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    userToken: asT<String?>(json['userToken']),
    user: json['user'] == null
        ? null
        : User.fromJson(asT<Map<String, dynamic>>(json['user'])!),
  );
  @HiveField(0)
  final String? userToken;
  final User? user;

  factory UserModel.un(){
    return UserModel(userToken: '-',user: User());
}
  @override
  String toString() {
    return jsonEncode(this);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
    'userToken': userToken,
    'user': user,
  };


}
@HiveType(typeId: 4)
class User {
  const User({
    this.createBy,
    this.createTime,
    this.updateBy,
    this.updateTime,
    this.remark,
    this.userId,
    this.openid,
    this.userName,
    this.avatar,
    this.sex,
    this.vip,
    this.vipStartTime,
    this.vipEndTime,
    this.macId,
    this.loginIp,
    this.loginDate,
    this.isDel,
    this.unionId,
    this.subscribe,
    this.subscribeTime,
    this.nickName,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
    createBy: asT<Object?>(json['createBy']),
    createTime: asT<String?>(json['createTime']),
    updateBy: asT<String?>(json['updateBy']),
    updateTime: asT<String?>(json['updateTime']),
    remark: asT<String?>(json['remark']),
    userId: asT<int?>(json['userId']),
    openid: asT<String?>(json['openid']),
    userName: asT<String?>(json['userName']),
    avatar: asT<String?>(json['avatar']),
    sex: asT<int?>(json['sex']),
    vip: asT<int?>(json['vip']),
    vipStartTime: asT<String?>(json['vipStartTime']),
    vipEndTime: asT<String?>(json['vipEndTime']),
    macId: asT<String?>(json['macId']),
    loginIp: asT<String?>(json['loginIp']),
    loginDate: asT<String?>(json['loginDate']),
    isDel: asT<int?>(json['isDel']),
    unionId: asT<String?>(json['unionId']),
    subscribe: asT<int?>(json['subscribe']),
    subscribeTime: asT<String?>(json['subscribeTime']),
    nickName: asT<String?>(json['nickName']),
  );
  @HiveField(1)
  final Object? createBy;
  @HiveField(2)
  final String? createTime;
  @HiveField(3)
  final String? updateBy;
  @HiveField(4)
  final String? updateTime;
  @HiveField(5)
  final String? remark;
  @HiveField(6)
  final int? userId;
  @HiveField(7)
  final String? openid;
  @HiveField(8)
  final String? userName;
  @HiveField(9)
  final String? avatar;
  @HiveField(10)
  final int? sex;
  @HiveField(11)
  final int? vip;
  @HiveField(12)
  final String? vipStartTime;
  @HiveField(13)
  final String? vipEndTime;
  @HiveField(14)
  final String? macId;
  @HiveField(15)
  final String? loginIp;
  @HiveField(16)
  final String? loginDate;
  @HiveField(17)
  final int? isDel;
  @HiveField(18)
  final String? unionId;
  @HiveField(19)
  final int? subscribe;
  @HiveField(20)
  final String? subscribeTime;
  @HiveField(21)
  final String? nickName;

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
    'userId': userId,
    'openid': openid,
    'userName': userName,
    'avatar': avatar,
    'sex': sex,
    'vip': vip,
    'vipStartTime': vipStartTime,
    'vipEndTime': vipEndTime,
    'macId': macId,
    'loginIp': loginIp,
    'loginDate': loginDate,
    'isDel': isDel,
    'unionId': unionId,
    'subscribe': subscribe,
    'subscribeTime': subscribeTime,
    'nickName': nickName,
  };


}

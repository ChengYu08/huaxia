import 'dart:convert';

T? asT<T>(dynamic value) {
  if (value is T) {
    return value;
  }
  return null;
}

class Entence {
  const Entence({
    this.createBy,
    this.createTime,
    this.updateBy,
    this.updateTime,
    this.remark,
    this.entenceId,
    this.sentence,
    this.interpretation,
    this.sourceCont,
    this.sourceUrl,
    this.userId,
    this.userName,
    this.status,
    this.likeNum,
    this.unlikeNum,
    this.commentNum,
    this.shareNum,
    this.isDel,
    this.recommend,
    this.recommendEndTime,
  });

  factory Entence.fromJson(Map<String, dynamic> json) => Entence(
    createBy: asT<String?>(json['createBy']),
    createTime: asT<String?>(json['createTime']),
    updateBy: asT<String?>(json['updateBy']),
    updateTime: asT<String?>(json['updateTime']),
    remark: asT<String?>(json['remark']),
    entenceId: asT<int?>(json['entenceId']),
    sentence: asT<String?>(json['sentence']),
    interpretation: asT<String?>(json['interpretation']),
    sourceCont: asT<String?>(json['sourceCont']),
    sourceUrl: asT<String?>(json['sourceUrl']),
    userId: asT<int?>(json['userId']),
    userName: asT<String?>(json['user_name']),
    status: asT<int?>(json['status']),
    likeNum: asT<int?>(json['likeNum']),
    unlikeNum: asT<int?>(json['unlikeNum']),
    commentNum: asT<int?>(json['commentNum']),
    shareNum: asT<int?>(json['shareNum']),
    isDel: asT<int?>(json['isDel']),
    recommend: asT<String?>(json['recommend']),
    recommendEndTime: asT<String?>(json['recommendEndTime']),
  );

  final String? createBy;
  final String? createTime;
  final String? updateBy;
  final String? updateTime;
  final String? remark;
  final int? entenceId;
  final String? sentence;
  final String? interpretation;
  final String? sourceCont;
  final String? sourceUrl;
  final int? userId;
  final String? userName;
  final int? status;
  final int? likeNum;
  final int? unlikeNum;
  final int? commentNum;
  final int? shareNum;
  final int? isDel;
  final String? recommend;
  final String? recommendEndTime;

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
    'entenceId': entenceId,
    'sentence': sentence,
    'interpretation': interpretation,
    'sourceCont': sourceCont,
    'sourceUrl': sourceUrl,
    'userId': userId,
    'user_name': userName,
    'status': status,
    'likeNum': likeNum,
    'unlikeNum': unlikeNum,
    'commentNum': commentNum,
    'shareNum': shareNum,
    'isDel': isDel,
    'recommend': recommend,
    'recommendEndTime': recommendEndTime,
  };
}

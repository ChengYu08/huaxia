import 'dart:convert';

import 'package:huaxia/config/http/api/api.dart';



class BookList {
  const BookList({
    this.createBy,
    this.createTime,
    this.updateBy,
    this.updateTime,
    this.remark,
    this.bookId,
    this.name,
    this.pic,
    this.synopsis,
    this.author,
    this.typeId,
    this.typeSecondId,
    this.catalogueNum,
    this.sizeNum,
    this.isDel,
    this.keyword,
  });

  factory BookList.fromJson(Map<String, dynamic> json) => BookList(
    createBy: asT<int?>(json['createBy']),
    createTime: asT<int?>(json['createTime']),
    updateBy: asT<int?>(json['updateBy']),
    updateTime: asT<int?>(json['updateTime']),
    remark: asT<String?>(json['remark']),
    bookId: asT<int?>(json['bookId']),
    name: asT<String?>(json['name']),
    pic: asT<String?>(json['pic']),
    synopsis: asT<String?>(json['synopsis']),
    author: asT<String?>(json['author']),
    typeId: asT<String?>(json['typeId']),
    typeSecondId: asT<String?>(json['typeSecondId']),
    catalogueNum: asT<int?>(json['catalogueNum']),
    sizeNum: asT<int?>(json['sizeNum']),
    isDel: asT<bool?>(json['isDel']),
    keyword: asT<String?>(json['keyword']),
  );

  final int? createBy;
  final int? createTime;
  final int? updateBy;
  final int? updateTime;
  final String? remark;
  final int? bookId;
  final String? name;
  final String? pic;
  final String? synopsis;
  final String? author;
  final String? typeId;
  final String? typeSecondId;
  final int? catalogueNum;
  final int? sizeNum;
  final bool? isDel;
  final String? keyword;

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
    'bookId': bookId,
    'name': name,
    'pic': pic,
    'synopsis': synopsis,
    'author': author,
    'typeId': typeId,
    'typeSecondId': typeSecondId,
    'catalogueNum': catalogueNum,
    'sizeNum': sizeNum,
    'isDel': isDel,
    'keyword': keyword,
  };
}

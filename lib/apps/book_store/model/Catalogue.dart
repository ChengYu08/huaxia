import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:huaxia/apps/book_store/book_details/book_reader/logic.dart';

T? asT<T>(dynamic value) {
  if (value is T) {
    return value;
  }
  return null;
}

class Catalogue {
   Catalogue({
    this.createBy,
    this.createTime,
    this.updateBy,
    this.updateTime,
    this.remark,
    this.bookCatalogueId,
    this.firstCatalogue,
    this.secondCatalogue,
    this.bookId,
    this.sizeNum,
    this.isDel,
  });

  factory Catalogue.fromJson(Map<String, dynamic> json) => Catalogue(
    createBy: asT<String?>(json['createBy']),
    createTime: asT<String?>(json['createTime']),
    updateBy: asT<String?>(json['updateBy']),
    updateTime: asT<String?>(json['updateTime']),
    remark: asT<String?>(json['remark']),
    bookCatalogueId: asT<int?>(json['bookCatalogueId']),
    firstCatalogue: asT<String?>(json['firstCatalogue']),
    secondCatalogue: asT<String?>(json['secondCatalogue']),
    bookId: asT<int?>(json['bookId']),
    sizeNum: asT<int?>(json['sizeNum']),
    isDel: asT<int?>(json['isDel']),
  );

  final String? createBy;
  final String? createTime;
  final String? updateBy;
  final String? updateTime;
  final String? remark;
  final int? bookCatalogueId;
  final String? firstCatalogue;
  final String? secondCatalogue;
  final int? bookId;
  final int? sizeNum;
  final int? isDel;
  String? error;

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
    'bookCatalogueId': bookCatalogueId,
    'firstCatalogue': firstCatalogue,
    'secondCatalogue': secondCatalogue,
    'bookId': bookId,
    'sizeNum': sizeNum,
    'isDel': isDel,
  };
}

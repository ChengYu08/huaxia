import 'dart:convert';

import 'package:flutter/material.dart';

T? asT<T>(dynamic value) {
  if (value is T) {
    return value;
  }
  return null;
}

class ShelfBook {
   ShelfBook({
    this.bookshelfId,
    this.catalogueId,
    this.bookId,
    this.percentage,
    this.bookName,
    this.bookPic,
  });

  factory ShelfBook.fromJson(Map<String, dynamic> json) => ShelfBook(
    bookshelfId: asT<int?>(json['bookshelfId']),
    catalogueId: asT<int?>(json['catalogueId']),
    bookId: asT<int?>(json['bookId']),
    percentage: asT<int?>(json['percentage']),
    bookName: asT<String?>(json['bookName']),
    bookPic: asT<String?>(json['bookPic']),
  );

  final int? bookshelfId;
  final int? catalogueId;
  final int? bookId;
  final int? percentage;
  final String? bookName;
  final String? bookPic;
  final ValueNotifier<bool> selectBook=ValueNotifier(false);
  @override
  String toString() {
    return jsonEncode(this);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
    'bookshelfId': bookshelfId,
    'catalogueId': catalogueId,
    'bookId': bookId,
    'percentage': percentage,
    'bookName': bookName,
    'bookPic': bookPic,
  };
}

import 'dart:convert';

T? asT<T>(dynamic value) {
  if (value is T) {
    return value;
  }
  return null;
}

class Chapters {
  const Chapters({
    this.createBy,
    this.createTime,
    this.updateBy,
    this.updateTime,
    this.remark,
    this.bookChaptersInfoId,
    this.bookId,
    this.bookCatalogueId,
    this.secondCatalogue,
    this.cont,
    this.translation,
    this.chapters,
    this.isDel,
  });

  factory Chapters.fromJson(Map<String, dynamic> json) => Chapters(
    createBy: asT<String?>(json['createBy']),
    createTime: asT<String?>(json['createTime']),
    updateBy: asT<String?>(json['updateBy']),
    updateTime: asT<String?>(json['updateTime']),
    remark: asT<String?>(json['remark']),
    bookChaptersInfoId: asT<String?>(json['bookChaptersInfoId']),
    bookId: asT<int?>(json['bookId']),
    bookCatalogueId: asT<int?>(json['bookCatalogueId']),
    secondCatalogue: asT<int?>(json['secondCatalogue']),
    cont: asT<String?>(json['cont']),
    translation: asT<String?>(json['translation']),
    chapters: asT<String?>(json['chapters']),
    isDel: asT<int?>(json['isDel']),
  );

  final String? createBy;
  final String? createTime;
  final String? updateBy;
  final String? updateTime;
  final String? remark;
  final String? bookChaptersInfoId;
  final int? bookId;
  final int? bookCatalogueId;
  final int? secondCatalogue;
  final String? cont;
  final String? translation;
  final String? chapters;
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
    'bookChaptersInfoId': bookChaptersInfoId,
    'bookId': bookId,
    'bookCatalogueId': bookCatalogueId,
    'secondCatalogue': secondCatalogue,
    'cont': cont,
    'translation': translation,
    'chapters': chapters,
    'isDel': isDel,
  };
}

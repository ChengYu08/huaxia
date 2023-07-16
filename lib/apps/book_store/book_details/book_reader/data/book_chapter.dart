
import 'package:flutter/cupertino.dart';

import 'package:huaxia/apps/book_store/book_details/book_reader/logic.dart';

import 'book_paragraph.dart';


class BookChapter{

  final ValueNotifier<BookLoadingState> bookLoadingState = ValueNotifier(BookLoadingState.loading);

  String? title;

  int? bookId;

  int paragraphId;
  int? updateTime;
  BookParagraph? bookParagraph;
  BookChapter({required this.title, required this.bookId, required this.paragraphId, this.updateTime,this.bookParagraph});
  String? error;
  @override
  bool operator ==(other) {
    if (other is! BookChapter) {
      return false;
    }
    return  paragraphId==other.paragraphId;
  }

  @override
  int get hashCode => paragraphId.hashCode;

}
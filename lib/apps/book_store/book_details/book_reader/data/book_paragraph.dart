import 'package:hive/hive.dart';
import 'package:html/dom.dart' as dom;
import 'package:html/parser.dart' as htmlparser;
part 'book_paragraph.g.dart';
@HiveType(typeId: 5)
class BookParagraph {
  @HiveField(0)
  int paragraphId;
  @HiveField(1)
  String? title;
  @HiveField(2)
  String? originalArticle;
  @HiveField(3)
  String? translationArticle;
  @HiveField(4)
  String? explinArticle;

  BookParagraph(
      {required this.paragraphId,
      this.title,
      this.originalArticle,
      this.translationArticle,
      this.explinArticle});

  dom.Document get originalArticleElement =>htmlparser.parse(originalArticle);

  dom.Document get translationArticleElement =>htmlparser.parse(translationArticle);

  dom.Document get explinArticleElement =>htmlparser.parse(explinArticle);
}

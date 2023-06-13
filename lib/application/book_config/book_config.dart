

import 'package:hive/hive.dart';
part 'book_config.g.dart';

@HiveType(typeId: 1)
class BookConfig extends HiveObject{
  @HiveField(0,defaultValue: 16)
   double textSize;
  @HiveField(1,defaultValue: ReadModel.listView)
   ReadModel readModel;
  @HiveField(2,defaultValue: 1)
   double textHight;
  @HiveField(3,defaultValue: 0xff202329)
   int textColor;
  @HiveField(4,defaultValue: 1)
   int bookThem;
  @HiveField(5,defaultValue: 1)
   double padding;
  BookConfig({
    this.textSize=16, this.readModel=ReadModel.listView, this.textHight=1,
    this.textColor=0xff202329,
    this.bookThem=1,
    this.padding=0,
  });

}
@HiveType(typeId: 2)
enum ReadModel{
  @HiveField(0)
  listView,
  @HiveField(1)
  pageView,
  @HiveField(2)
  simulationView
}
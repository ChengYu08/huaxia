// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'book_paragraph.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class BookParagraphAdapter extends TypeAdapter<BookParagraph> {
  @override
  final int typeId = 5;

  @override
  BookParagraph read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return BookParagraph(
      paragraphId: fields[0] as int,
      title: fields[1] as String?,
      originalArticle: fields[2] as String?,
      translationArticle: fields[3] as String?,
      explinArticle: fields[4] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, BookParagraph obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.paragraphId)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.originalArticle)
      ..writeByte(3)
      ..write(obj.translationArticle)
      ..writeByte(4)
      ..write(obj.explinArticle);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BookParagraphAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

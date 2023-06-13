// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'book_config.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class BookConfigAdapter extends TypeAdapter<BookConfig> {
  @override
  final int typeId = 1;

  @override
  BookConfig read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return BookConfig(
      textSize: fields[0] == null ? 16 : fields[0] as double,
      readModel:
          fields[1] == null ? ReadModel.listView : fields[1] as ReadModel,
      textHight: fields[2] == null ? 1 : fields[2] as double,
      textColor: fields[3] == null ? 4280296233 : fields[3] as int,
      bookThem: fields[4] == null ? 1 : fields[4] as int,
      padding: fields[5] == null ? 1 : fields[5] as double,
    );
  }

  @override
  void write(BinaryWriter writer, BookConfig obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.textSize)
      ..writeByte(1)
      ..write(obj.readModel)
      ..writeByte(2)
      ..write(obj.textHight)
      ..writeByte(3)
      ..write(obj.textColor)
      ..writeByte(4)
      ..write(obj.bookThem)
      ..writeByte(5)
      ..write(obj.padding);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BookConfigAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class ReadModelAdapter extends TypeAdapter<ReadModel> {
  @override
  final int typeId = 2;

  @override
  ReadModel read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return ReadModel.listView;
      case 1:
        return ReadModel.pageView;
      case 2:
        return ReadModel.simulationView;
      default:
        return ReadModel.listView;
    }
  }

  @override
  void write(BinaryWriter writer, ReadModel obj) {
    switch (obj) {
      case ReadModel.listView:
        writer.writeByte(0);
        break;
      case ReadModel.pageView:
        writer.writeByte(1);
        break;
      case ReadModel.simulationView:
        writer.writeByte(2);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ReadModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

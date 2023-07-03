// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UserModelAdapter extends TypeAdapter<UserModel> {
  @override
  final int typeId = 3;

  @override
  UserModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return UserModel(
      userToken: fields[0] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, UserModel obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.userToken);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class UserAdapter extends TypeAdapter<User> {
  @override
  final int typeId = 4;

  @override
  User read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return User(
      createBy: fields[1] as Object?,
      createTime: fields[2] as String?,
      updateBy: fields[3] as String?,
      updateTime: fields[4] as String?,
      remark: fields[5] as String?,
      userId: fields[6] as int?,
      openid: fields[7] as String?,
      userName: fields[8] as String?,
      avatar: fields[9] as String?,
      sex: fields[10] as int?,
      vip: fields[11] as int?,
      vipStartTime: fields[12] as String?,
      vipEndTime: fields[13] as String?,
      macId: fields[14] as String?,
      loginIp: fields[15] as String?,
      loginDate: fields[16] as String?,
      isDel: fields[17] as int?,
      unionId: fields[18] as String?,
      subscribe: fields[19] as int?,
      subscribeTime: fields[20] as String?,
      nickName: fields[21] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, User obj) {
    writer
      ..writeByte(21)
      ..writeByte(1)
      ..write(obj.createBy)
      ..writeByte(2)
      ..write(obj.createTime)
      ..writeByte(3)
      ..write(obj.updateBy)
      ..writeByte(4)
      ..write(obj.updateTime)
      ..writeByte(5)
      ..write(obj.remark)
      ..writeByte(6)
      ..write(obj.userId)
      ..writeByte(7)
      ..write(obj.openid)
      ..writeByte(8)
      ..write(obj.userName)
      ..writeByte(9)
      ..write(obj.avatar)
      ..writeByte(10)
      ..write(obj.sex)
      ..writeByte(11)
      ..write(obj.vip)
      ..writeByte(12)
      ..write(obj.vipStartTime)
      ..writeByte(13)
      ..write(obj.vipEndTime)
      ..writeByte(14)
      ..write(obj.macId)
      ..writeByte(15)
      ..write(obj.loginIp)
      ..writeByte(16)
      ..write(obj.loginDate)
      ..writeByte(17)
      ..write(obj.isDel)
      ..writeByte(18)
      ..write(obj.unionId)
      ..writeByte(19)
      ..write(obj.subscribe)
      ..writeByte(20)
      ..write(obj.subscribeTime)
      ..writeByte(21)
      ..write(obj.nickName);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

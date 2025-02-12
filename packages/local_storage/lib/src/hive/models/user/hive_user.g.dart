// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hive_user.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class HiveUserAdapter extends TypeAdapter<HiveUser> {
  @override
  final int typeId = 2;

  @override
  HiveUser read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return HiveUser(
      name: fields[0] as String,
      email: fields[1] as String,
      phone: fields[2] as String,
      image: fields[3] as String,
      activeCoupon: fields[4] as String,
      pos: fields[5] as int,
      posUsed: fields[6] as int,
    );
  }

  @override
  void write(BinaryWriter writer, HiveUser obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.email)
      ..writeByte(2)
      ..write(obj.phone)
      ..writeByte(3)
      ..write(obj.image)
      ..writeByte(4)
      ..write(obj.activeCoupon)
      ..writeByte(5)
      ..write(obj.pos)
      ..writeByte(6)
      ..write(obj.posUsed);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) => identical(this, other) || other is HiveUserAdapter && runtimeType == other.runtimeType && typeId == other.typeId;
}

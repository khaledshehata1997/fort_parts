// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hive_access_token.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class HiveAccessTokenAdapter extends TypeAdapter<HiveAccessToken> {
  @override
  final int typeId = 1;

  @override
  HiveAccessToken read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return HiveAccessToken(
      accessToken: fields[0] as String,
    );
  }

  @override
  void write(BinaryWriter writer, HiveAccessToken obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.accessToken);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HiveAccessTokenAdapter && runtimeType == other.runtimeType && typeId == other.typeId;
}

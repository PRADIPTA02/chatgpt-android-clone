// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MessageAdapter extends TypeAdapter<Message> {
  @override
  final int typeId = 0;

  @override
  Message read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Message(
      sessionId: fields[6] as dynamic,
      message_text: fields[0] as String,
      isApi: fields[3] as bool,
      id: fields[1] as String,
      timeStamp: fields[2] as int,
    )
      ..isAnimate = fields[4] as bool
      ..isLiked = fields[5] as bool;
  }

  @override
  void write(BinaryWriter writer, Message obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.message_text)
      ..writeByte(1)
      ..write(obj.id)
      ..writeByte(2)
      ..write(obj.timeStamp)
      ..writeByte(3)
      ..write(obj.isApi)
      ..writeByte(4)
      ..write(obj.isAnimate)
      ..writeByte(5)
      ..write(obj.isLiked)
      ..writeByte(6)
      ..write(obj.sessionId);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MessageAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message_session_list_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MessageSessionListAdapter extends TypeAdapter<MessageSessionList> {
  @override
  final int typeId = 1;

  @override
  MessageSessionList read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return MessageSessionList(
      sessionId: fields[0] as String,
      sessionName: fields[1] as String,
    );
  }

  @override
  void write(BinaryWriter writer, MessageSessionList obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.sessionId)
      ..writeByte(1)
      ..write(obj.sessionName);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MessageSessionListAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

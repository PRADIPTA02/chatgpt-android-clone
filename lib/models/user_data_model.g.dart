// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_data_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UserDataAdapter extends TypeAdapter<UserData> {
  @override
  final int typeId = 3;

  @override
  UserData read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return UserData(
      Profile_image: fields[0] as String,
      User_id: fields[20] as String,
      User_uid: fields[21] as String,
      Firstname: fields[1] as String,
      Lastname: fields[2] as String,
      Email_id: fields[3] as String?,
      Password: fields[5] as String,
      Birthday: fields[7] as DateTime,
      Country: fields[8] as String,
      Gender: fields[6] as String,
      Share_link: fields[22] as String,
    )
      ..Phone_number = fields[4] as String
      ..Temperature = fields[9] as double
      ..Maximum_length = fields[10] as int
      ..Top_p = fields[11] as double
      ..Frequency_penalty = fields[12] as double
      ..Presence_penalty = fields[13] as double
      ..Best_of = fields[14] as int
      ..Language = fields[15] as String
      ..Model = fields[16] as String
      ..Image_show_layout = fields[17] as String
      ..Image_size = fields[18] as String
      ..Number_of_images = fields[19] as int;
  }

  @override
  void write(BinaryWriter writer, UserData obj) {
    writer
      ..writeByte(23)
      ..writeByte(0)
      ..write(obj.Profile_image)
      ..writeByte(1)
      ..write(obj.Firstname)
      ..writeByte(2)
      ..write(obj.Lastname)
      ..writeByte(3)
      ..write(obj.Email_id)
      ..writeByte(4)
      ..write(obj.Phone_number)
      ..writeByte(5)
      ..write(obj.Password)
      ..writeByte(6)
      ..write(obj.Gender)
      ..writeByte(7)
      ..write(obj.Birthday)
      ..writeByte(8)
      ..write(obj.Country)
      ..writeByte(9)
      ..write(obj.Temperature)
      ..writeByte(10)
      ..write(obj.Maximum_length)
      ..writeByte(11)
      ..write(obj.Top_p)
      ..writeByte(12)
      ..write(obj.Frequency_penalty)
      ..writeByte(13)
      ..write(obj.Presence_penalty)
      ..writeByte(14)
      ..write(obj.Best_of)
      ..writeByte(15)
      ..write(obj.Language)
      ..writeByte(16)
      ..write(obj.Model)
      ..writeByte(17)
      ..write(obj.Image_show_layout)
      ..writeByte(18)
      ..write(obj.Image_size)
      ..writeByte(19)
      ..write(obj.Number_of_images)
      ..writeByte(20)
      ..write(obj.User_id)
      ..writeByte(21)
      ..write(obj.User_uid)
      ..writeByte(22)
      ..write(obj.Share_link);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserDataAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

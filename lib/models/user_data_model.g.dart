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
      User_id: fields[21] as String,
      User_uid: fields[22] as String,
      Display_name: fields[23] as String,
      primary_address: fields[25] as String,
    )
      ..Profile_image = fields[0] as String
      ..Firstname = fields[1] as String
      ..Lastname = fields[2] as String
      ..Email_id = fields[3] as String
      ..Phone_number = fields[4] as String
      ..Password = fields[5] as String
      ..Gender = fields[6] as String
      ..Birthday = fields[7] as DateTime
      ..Age = fields[8] as String
      ..Country = fields[9] as String
      ..Temperature = fields[10] as double
      ..Maximum_length = fields[11] as int
      ..Top_p = fields[12] as double
      ..Frequency_penalty = fields[13] as double
      ..Presence_penalty = fields[14] as double
      ..Best_of = fields[15] as int
      ..Language = fields[16] as String
      ..Model = fields[17] as String
      ..Image_show_layout = fields[18] as String
      ..Image_size = fields[19] as String
      ..Number_of_images = fields[20] as int
      ..database_updated = fields[24] as bool;
  }

  @override
  void write(BinaryWriter writer, UserData obj) {
    writer
      ..writeByte(26)
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
      ..write(obj.Age)
      ..writeByte(9)
      ..write(obj.Country)
      ..writeByte(10)
      ..write(obj.Temperature)
      ..writeByte(11)
      ..write(obj.Maximum_length)
      ..writeByte(12)
      ..write(obj.Top_p)
      ..writeByte(13)
      ..write(obj.Frequency_penalty)
      ..writeByte(14)
      ..write(obj.Presence_penalty)
      ..writeByte(15)
      ..write(obj.Best_of)
      ..writeByte(16)
      ..write(obj.Language)
      ..writeByte(17)
      ..write(obj.Model)
      ..writeByte(18)
      ..write(obj.Image_show_layout)
      ..writeByte(19)
      ..write(obj.Image_size)
      ..writeByte(20)
      ..write(obj.Number_of_images)
      ..writeByte(21)
      ..write(obj.User_id)
      ..writeByte(22)
      ..write(obj.User_uid)
      ..writeByte(23)
      ..write(obj.Display_name)
      ..writeByte(24)
      ..write(obj.database_updated)
      ..writeByte(25)
      ..write(obj.primary_address);
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

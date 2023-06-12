// ignore_for_file: non_constant_identifier_names

import 'package:hive/hive.dart';
part 'user_data_model.g.dart';

@HiveType(typeId: 3)
class UserData extends HiveObject {
  UserData({required this.User_id,required this.User_uid,required this.Display_name,required this.primary_address});
  @HiveField(0)
  String Profile_image = "";
  @HiveField(1)
  String Firstname = "";
  @HiveField(2)
  String Lastname = "";
  @HiveField(3)
  String Email_id = "";
  @HiveField(4)
  String Phone_number = "";
  @HiveField(5)
  String Password = "";
  @HiveField(6)
  String Gender = "";
  @HiveField(7)
  DateTime Birthday = DateTime.now();
  @HiveField(8)
  String Age = "";
  @HiveField(9)
  String Country = "";
  @HiveField(10)
  double Temperature = 0.6;
  @HiveField(11)
  int Maximum_length = 3457;
  @HiveField(12)
  double Top_p = 0.1;
  @HiveField(13)
  double Frequency_penalty = 1;
  @HiveField(14)
  double Presence_penalty = 1;
  @HiveField(15)
  int Best_of = 1;
  @HiveField(16)
  String Language = "English";
  @HiveField(17)
  String Model = "text-davinci-003";
  @HiveField(18)
  String Image_show_layout = "list";
  @HiveField(19)
  String Image_size = "256x256";
  @HiveField(20)
  int Number_of_images = 2;
  @HiveField(21)
  final String User_id;
  @HiveField(22)
  final String User_uid;
  @HiveField(23)
  final String Display_name;
  @HiveField(24)
  bool database_updated = false;
  @HiveField(25)
  final String primary_address;
  
}

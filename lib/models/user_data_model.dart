// ignore_for_file: non_constant_identifier_names

import 'package:hive/hive.dart';
part 'user_data_model.g.dart';

@HiveType(typeId: 3)
class UserData extends HiveObject {
  UserData({
    required this.Profile_image,
    required this.User_id,
    required this.User_uid,
    required this.Firstname,
    required this.Lastname,
    required this.Email_id,
    required this.Password,
    required this.Birthday,
    required this.Country,
    required this.Gender,
    required this.Share_link,
    });
  @HiveField(0)
  String Profile_image = "";
  @HiveField(1)
  String Firstname = "";
  @HiveField(2)
  String Lastname = "";
  @HiveField(3)
  final String? Email_id;
  @HiveField(4)
  String Phone_number = "";
  @HiveField(5)
  String Password = "";
  @HiveField(6)
  String Gender = "";
  @HiveField(7)
  DateTime Birthday = DateTime.now();
  @HiveField(8)
  String Country = "";
  @HiveField(9)
  double Temperature = 0.6;
  @HiveField(10)
  int Maximum_length = 3457;
  @HiveField(11)
  double Top_p = 0.1;
  @HiveField(12)
  double Frequency_penalty = 1;
  @HiveField(13)
  double Presence_penalty = 1;
  @HiveField(14)
  int Best_of = 1;
  @HiveField(15)
  String Language = "English";
  @HiveField(16)
  String Model = "text-davinci-003";
  @HiveField(17)
  String Image_show_layout = "list";
  @HiveField(18)
  String Image_size = "256x256";
  @HiveField(19)
  int Number_of_images = 2;
  @HiveField(20)
  final String User_id;
  @HiveField(21)
  final String User_uid;
  @HiveField(22)
  final String Share_link;
}

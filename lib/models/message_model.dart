import 'package:hive/hive.dart';
part 'message_model.g.dart';

@HiveType(typeId: 0)
class Message extends HiveObject{
  Message({required this.sessionId,required this.message_text,required this.isApi,required this.id,required this.timeStamp}){}
  @HiveField(0)
  final String message_text;
  @HiveField(1)
  final String id;
  @HiveField(2)
  final int timeStamp;
  @HiveField(3)
  bool isApi=true;
  @HiveField(4)
  bool isAnimate = true;
  @HiveField(5)
  bool isLiked = false;
  @HiveField(6)
  final String sessionId;
  @HiveField(7)
  int indexOfUpdateMessage=0;
  // this function for typing animate effect run only first time 
  void changeAnimate(){
    isAnimate = false;
  }
  void changeIsLiked(){
    isLiked = true;
  }
}
import 'package:hive/hive.dart';
part 'message_session_list_model.g.dart';

@HiveType(typeId: 1)
class MessageSessionList extends HiveObject{
  @HiveField(0)
  final String sessionId;
  @HiveField(1)
  String sessionName = "New chat";
  MessageSessionList({required this.sessionId,required this.sessionName});
}
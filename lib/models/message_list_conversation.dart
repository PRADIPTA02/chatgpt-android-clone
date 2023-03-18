import 'package:hive/hive.dart';

import 'message_model.dart';
part 'message_list_conversation.g.dart';

@HiveType(typeId: 2)
class Conversation extends HiveObject {
  Conversation({required this.messages});

  @HiveField(0)
  List<List<Message>> messages;
}
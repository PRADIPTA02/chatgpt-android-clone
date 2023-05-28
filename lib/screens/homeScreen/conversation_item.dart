import 'package:chatgpt/util/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ConversationItem extends StatelessWidget {
  const ConversationItem(
      {super.key, required this.firstMessage, required this.timeStamp});
  final String firstMessage;
  final int timeStamp;
  String getTimeOrDate(int timestamp) {
    DateTime now = DateTime.now();
    DateTime today = DateTime(now.year, now.month, now.day);
    DateTime inputDate = DateTime.fromMillisecondsSinceEpoch(timestamp );
    Duration diff = today.difference(inputDate);

    if (diff.inDays == 0) {
      // Return time if it's today
      return 'Today';
    } else if (diff.inDays == 1) {
      // Return "Yesterday" if it's yesterday
      return 'Yesterday';
    } else if (diff.inDays >= 2 && diff.inDays <= 6) {
      // Return the day of the week if it's within the past week
      return DateFormat('EEEE').format(inputDate);
    } else {
      // Return the date in the format "Month Day, Year"
      return DateFormat('MMMM d, yyyy').format(inputDate);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(
          color: const Color.fromARGB(255, 72, 70, 70),
          width: 1.0,
        ),
      ),
      child: ListTile(
        tileColor: secondaryColor,
        title: const Text(
          'ChatBOT',
          style: TextStyle(color: Colors.white),
        ),
        subtitle: Text(
          firstMessage,
          style: const TextStyle(color: Colors.white70),
        ),
        trailing: Text(
          getTimeOrDate(timeStamp),
          style: const TextStyle(fontSize: 14, color: Colors.grey),
        ),
      ),
    );
  }
}

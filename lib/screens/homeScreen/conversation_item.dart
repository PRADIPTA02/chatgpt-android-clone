import 'package:chatgpt/providers/text_copletion_provider.dart';
import 'package:chatgpt/util/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../chatScreen/chatScreen.dart';

class ConversationItem extends StatelessWidget {
  const ConversationItem(
      {super.key,
      required this.firstMessage,
      required this.timeStamp,
      required this.index});
  final String firstMessage;
  final int timeStamp;
  final String index;
  String getTimeOrDate(int timestamp) {
    DateTime now = DateTime.now();
    DateTime today = DateTime(now.year, now.month, now.day);
    DateTime inputDate = DateTime.fromMillisecondsSinceEpoch(timestamp);
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
    return Consumer<TextCompletProvider>(
      builder: (context, value, child) => InkWell(
        onTap: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const ChatScreen()));
          value.changeCurrentSessionIndex(value.allSesions
              .indexWhere((element) => element.sessionId == index));
        },
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 5),
          decoration: BoxDecoration(
            color: secondaryColor,
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(
              color: const Color.fromARGB(255, 72, 70, 70),
              width: 1.0,
            ),
          ),
          child: ListTile(
            title: Text(
              'AI BUDDY',
              style: GoogleFonts.nunito(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w600),
            ),
            subtitle: Text(
              firstMessage,
              style: GoogleFonts.nunito(
                  color: Colors.white70,
                  fontSize: 14,
                  fontWeight: FontWeight.w500),
            ),
            trailing: Text(
              getTimeOrDate(timeStamp),
              style: GoogleFonts.nunito(
                  fontSize: 14,
                  
                  color: cgSecondary.withOpacity(0.6),
                  fontWeight: FontWeight.w500),maxLines: 1,overflow: TextOverflow.ellipsis
            ),
          ),
        ),
      ),
    );
  }
}

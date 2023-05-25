import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/message_model.dart';
import '../../providers/text_copletion_provider.dart';
import 'carousel_message_body.dart';
import 'example_object.dart';
import 'single_message_body.dart';
import 'package:flutter_list_view/flutter_list_view.dart';
// ignore: depend_on_referenced_packages
import 'package:intl/intl.dart';

class MessegeList extends StatelessWidget {
  const MessegeList({super.key});

  String getDayFromTimestamp(int timestamp) {
    DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
    List<String> daysOfWeek = [
      'Monday',
      'Tuesday',
      'Wednesday',
      'Thursday',
      'Friday',
      'Saturday',
      'Sunday'
    ];
    int dayIndex = dateTime.weekday - 1;
    return daysOfWeek[dayIndex];
  }
 String getTimeOrDate(int timestamp) {
    DateTime now = DateTime.now();
    DateTime today = DateTime(now.year, now.month, now.day);
    DateTime inputDate = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
    Duration diff = today.difference(inputDate);

    if (diff.inDays == 0) {
      // Return time if it's today
      return DateFormat('H:m:s').format(inputDate);
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
    final textCompletionProvider =
        Provider.of<TextCompletProvider>(context, listen: false);
    return Consumer<TextCompletProvider>(builder: (context, value, child) {
      final List<List<Message>> messages =
          textCompletionProvider.CurrentSessionIndex >
                  textCompletionProvider.allMessages.length - 1
              ? []
              : textCompletionProvider
                  .allMessages[textCompletionProvider.CurrentSessionIndex];
      messages.sort((a, b) => b[0].timeStamp.compareTo(a[0].timeStamp));
      return FlutterListView(
          physics: const BouncingScrollPhysics(
              decelerationRate: ScrollDecelerationRate.fast),
          reverse: true,
          key: const PageStorageKey<String>('page'),
          controller: textCompletionProvider.chatScrollControler,
          delegate: FlutterListViewDelegate(
              childCount: messages.isEmpty ? 1 : messages.length,
              firstItemAlign: FirstItemAlign.end,
              onItemKey: (index) =>
                  messages.isEmpty ? "1221" : messages[index][0].id.toString(),
              (BuildContext context, int index) => messages.isEmpty
                  ? const ExampleObject()
                  : messages[index].length == 1
                      ? 
                      Column (
                        children: [
                          index == messages.length-1 ?  
                          Text(getTimeOrDate(messages[index][0].timeStamp)):
                          index<messages.length-1 && 
                          (getDayFromTimestamp(messages[index][0].timeStamp)!= getDayFromTimestamp(messages[index+1 ][0].timeStamp))?
                          Text(getTimeOrDate(messages[index][0].timeStamp)):
                          const SizedBox(),
                          SingleMessageBody(
                              text: messages[index][0].message_text,
                              isApi: messages[index][0].isApi,
                              isAnimate: messages[index][0].isAnimate,
                              timeStamp: messages[index][0].timeStamp,
                              id: messages[index][0].id,
                              messageIndex: index,
                              sessionIndex:
                                  textCompletionProvider.CurrentSessionIndex,
                              isCarouselMessage: false,
                              upperMessageIndex: index,
                              isLiked: messages[index][0].isLiked,
                              isDisLiked: messages[index][0].isDisLiked,
                            ),
                        ],
                      )
                      : Column(
                        children: [
                          index == messages.length-1 ?  
                          Text(getTimeOrDate(messages[index][0].timeStamp)):
                          index<messages.length-1 && 
                          (getDayFromTimestamp(messages[index][0].timeStamp)!= getDayFromTimestamp(messages[index+1 ][0].timeStamp))?
                          Text(getTimeOrDate(messages[index][0].timeStamp)):
                          const SizedBox(),
                          CarouselMessageBody(
                              ms: messages[index],
                              upeerMessageIndex: index,
                              sessionIndex:
                                  textCompletionProvider.CurrentSessionIndex,
                            ),
                        ],
                      )));
    });
  }
}

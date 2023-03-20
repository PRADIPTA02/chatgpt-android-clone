import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/message_model.dart';
import '../../providers/text_copletion_provider.dart';
import 'carousel_message_body.dart';
import 'example_object.dart';
import 'single_message_body.dart';
import 'package:flutter_list_view/flutter_list_view.dart';

class MessegeList extends StatelessWidget {
  MessegeList({super.key});
  @override
  Widget build(BuildContext context) {
    final _textCompletionProvider =
        Provider.of<TextCompletProvider>(context, listen: false);
    return Consumer<TextCompletProvider>(builder: (context, value, child) {
      final List<List<Message>> messages =
          _textCompletionProvider.CurrentSessionIndex >
                  _textCompletionProvider.allMessages.length - 1
              ? []
              : _textCompletionProvider
                  .allMessages[_textCompletionProvider.CurrentSessionIndex];
      messages.sort((a, b) => b[0].timeStamp.compareTo(a[0].timeStamp));
      return FlutterListView(
          physics: const BouncingScrollPhysics(
              decelerationRate: ScrollDecelerationRate.fast),
          reverse: true,
          key: const PageStorageKey<String>('page'),
          controller: _textCompletionProvider.chatScrollControler,
          delegate: FlutterListViewDelegate(
            childCount: messages.isEmpty ? 1 : messages.length,
            firstItemAlign: FirstItemAlign.end,
            onItemKey: (index) =>
                messages.isEmpty ? "1221" : messages[index][0].id.toString(),
            // keepPosition: true,
            (BuildContext context, int index) => messages.isEmpty
                ? const  ExampleObject()
                :messages[index].length==1? 
                SingleMessageBody(
                    text: messages[index][0].message_text,
                    isApi: messages[index][0].isApi,
                    isAnimate: messages[index][0].isAnimate,
                    timeStamp: messages[index][0].timeStamp,
                    id: messages[index][0].id,
                    messageIndex: index,
                    sessionIndex: _textCompletionProvider.CurrentSessionIndex,
                    isCarouselMessage: false,
                    upperMessageIndex: index,
                    isLiked: messages[index][0].isLiked,
                    isDisLiked: messages[index][0].isDisLiked,
                  ):CarouselMessageBody(ms: messages[index],upeerMessageIndex: index, sessionIndex: _textCompletionProvider.CurrentSessionIndex, )
          ));
    });
  }
}

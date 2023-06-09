import 'package:chatgpt/providers/text_copletion_provider.dart';
import 'package:chatgpt/screens/homeScreen/conversation_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ConversationList extends StatelessWidget {
  const ConversationList({super.key});

  @override
  Widget build(BuildContext context) {
    final textCompletionProvider =
        Provider.of<TextCompletProvider>(context, listen: false);
    return Consumer<TextCompletProvider>(
        builder: (context, value, child) => Scrollbar(
            thickness: 0.9,
            radius: const Radius.circular(5),
          child: ListView.builder(
                physics: const BouncingScrollPhysics(
                    decelerationRate: ScrollDecelerationRate.normal),
                itemCount: textCompletionProvider.allMessages.length > 4
                    ? 4
                    : textCompletionProvider.allMessages.length,
                itemBuilder: (context, index) => textCompletionProvider
                        .allMessages.isEmpty
                    ? const Center(
                        child: Text('No items in the list.'),
                      )
                    : ConversationItem(
                        firstMessage:
                            textCompletionProvider.allMessages[index].length > 1
                                ? textCompletionProvider
                                    .allMessages[index][1][0].message_text
                                : textCompletionProvider
                                    .allMessages[index][0][0].message_text,
                        timeStamp:
                            textCompletionProvider.allMessages[index].length > 1
                                ? textCompletionProvider
                                    .allMessages[index][1][0].timeStamp
                                : textCompletionProvider
                                    .allMessages[index][0][0].timeStamp,
                      ),
              ),
        ));
  }
}

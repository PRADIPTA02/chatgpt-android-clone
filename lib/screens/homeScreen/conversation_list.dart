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
        builder: (context, value, child) => ListView.builder(
              shrinkWrap: true,
              addRepaintBoundaries: false,
              physics: const BouncingScrollPhysics(
                  decelerationRate: ScrollDecelerationRate.fast),
              itemCount: textCompletionProvider.allMessages.length > 4
                  ? 4
                  
                      : textCompletionProvider.allMessages.length,
              itemBuilder: (context, index) => ConversationItem(
                firstMessage: textCompletionProvider
                    .allMessages[index][1][0].message_text,
                timeStamp:
                    textCompletionProvider.allMessages[index][1][0].timeStamp,
              ),
            ));
  }
}

import 'package:chatgpt/models/message_model.dart';
import 'package:chatgpt/screens/chatScreen/single_message_body.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/text_copletion_provider.dart';


class CarouselMessageBody extends StatelessWidget {
     CarouselMessageBody({
    super.key,
    required this.ms,
    required this.upeerMessageIndex,
    required this.sessionIndex
    });
    final List<Message> ms;
    late int messageIndex = ms[0].indexOfUpdateMessage;
    final upeerMessageIndex;
    final sessionIndex ;

  @override
  Widget build(BuildContext context) {
    final _textCompletionProvider =
        Provider.of<TextCompletProvider>(context, listen: false);
    return Consumer<TextCompletProvider>(
      builder: (context, value, child) => Column(
        children: [
          SingleMessageBody(
            text: ms[messageIndex].message_text,
            isApi: ms[messageIndex].isApi,
            isAnimate: ms[messageIndex].isAnimate,
            timeStamp: ms[messageIndex].timeStamp,
            id: ms[messageIndex].id,
            messageIndex: messageIndex,
            sessionIndex: sessionIndex,
            isCarouselMessage: true,
            upperMessageIndex: upeerMessageIndex,
            isLiked: ms[messageIndex].isLiked,
            isDisLiked: ms[messageIndex].isDisLiked,
          ),
          ms[0].isApi? Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                  onPressed: () => {
                       _textCompletionProvider.updateCarouselMessageLowerIndex(sessionIndex,upeerMessageIndex,(messageIndex-1)%ms.length)
                      },
                  icon: const Icon(
                    Icons.arrow_back_ios,
                    color: Colors.white70,
                  )),
              Text(
                "${messageIndex + 1} ",
                style: const TextStyle(
                    color: Colors.white70,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
              const Text(
                "/",
                style:  TextStyle(
                    color: Colors.white70,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
              Text(
                " ${ms.length}",
                style: const TextStyle(
                    color: Colors.white70,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
              IconButton(
                  onPressed: () => {
                      _textCompletionProvider.updateCarouselMessageLowerIndex(sessionIndex,upeerMessageIndex,(1+messageIndex)%ms.length)
                      },
                  icon: const Icon(Icons.arrow_forward_ios, color: Colors.white70))
            ],
          ):const SizedBox()
        ],
      ),
    );
  }
}

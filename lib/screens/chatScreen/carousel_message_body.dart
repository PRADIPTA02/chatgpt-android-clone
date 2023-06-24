import 'package:chatgpt/models/message_model.dart';
import 'package:chatgpt/screens/chatScreen/single_message_body.dart';
import 'package:chatgpt/util/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../providers/text_copletion_provider.dart';


// ignore: must_be_immutable
class CarouselMessageBody extends StatelessWidget {
     CarouselMessageBody({
    super.key,
    required this.ms,
    required this.upeerMessageIndex,
    required this.sessionIndex
    });
    final List<Message> ms;
    late int messageIndex = ms[0].indexOfUpdateMessage;
    final int upeerMessageIndex;
    final int sessionIndex ;

  @override
  Widget build(BuildContext context) {
    final textCompletionProvider =
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
                       textCompletionProvider.updateCarouselMessageLowerIndex(sessionIndex,upeerMessageIndex,(messageIndex-1)%ms.length)
                      },
                  icon: const Icon(
                    Icons.arrow_back_ios,
                    color: Colors.white70,
                    size: 20,
                  )),
              Text(
                "${messageIndex + 1} ",
                style: GoogleFonts.nunito(
                    color: cgSecondary,
                    fontSize: 15,
                    fontWeight: FontWeight.bold),
              ),
              Text(
                "/",
                style:  GoogleFonts.nunito(
                    color: Colors.white70,
                    fontSize: 15,
                    fontWeight: FontWeight.bold),
              ),
              Text(
                " ${ms.length}",
                style: GoogleFonts.nunito(
                    color: cgSecondary,
                    fontSize: 15,
                    fontWeight: FontWeight.bold),
              ),
              IconButton(
                  onPressed: () => {
                      textCompletionProvider.updateCarouselMessageLowerIndex(sessionIndex,upeerMessageIndex,(1+messageIndex)%ms.length)
                      },
                  icon: const Icon(Icons.arrow_forward_ios, color: Colors.white70,size: 20,))
            ],
          ):const SizedBox()
        ],
      ),
    );
  }
}

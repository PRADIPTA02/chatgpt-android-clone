import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:chatgpt/screens/chatScreen/chat_avatar.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:like_button/like_button.dart';
import 'package:provider/provider.dart';

import '../../util/constants/constants.dart';
import '../../providers/text_copletion_provider.dart';

class SingleMessageBody extends StatelessWidget {
  const SingleMessageBody(
      {super.key,
      required this.text,
      required this.isApi,
      required this.isAnimate,
      required this.timeStamp,
      required this.id,
      required this.messageIndex,
      required this.sessionIndex,
      required this.isCarouselMessage,
      required this.upperMessageIndex,
      required this.isLiked,
      required this.isDisLiked});
  final String text;
  final bool isApi;
  final bool isAnimate;
  final int timeStamp;
  final String id;
  final int messageIndex;
  final int sessionIndex;
  final bool isCarouselMessage;
  final int upperMessageIndex;
  final bool isLiked;
  final bool isDisLiked;

  String formatTime(int timestamp) {
    DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(timestamp);
    String amOrPm = dateTime.hour < 12 ? 'AM' : 'PM';
    int hour = dateTime.hour > 12 ? dateTime.hour - 12 : dateTime.hour;
    String minute = dateTime.minute.toString().padLeft(2, '0');
    String second = dateTime.second.toString().padLeft(2, '0');

    return '$hour:$minute $amOrPm';
  }

  @override
  Widget build(BuildContext context) {
    final textCompletionProvider =
        Provider.of<TextCompletProvider>(context, listen: false);
    if (isApi &&
        isAnimate &&
        textCompletionProvider.CurrentSessionIndex == sessionIndex) {}

    Future<bool> onLikeButtonTapped(bool isLiked) async {
      isCarouselMessage
          ? textCompletionProvider.likeMessage(
              messageIndex, id, sessionIndex, upperMessageIndex, true)
          : textCompletionProvider.likeMessage(
              messageIndex, id, sessionIndex, upperMessageIndex, false);
      return !isLiked;
    }

    return Consumer<TextCompletProvider>(
      builder: (context, value, child) => Container(
        padding: const EdgeInsets.all(5),
        margin: const EdgeInsets.only(top: 5, bottom: 5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(3),
          color: isApi ? secondaryColor : Colors.transparent,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ChatAvater(
                  isApi: isApi,
                ),
                const SizedBox(
                  width: 5,
                ),
                Expanded(
                  child: isApi &&
                          isAnimate &&
                          textCompletionProvider.CurrentSessionIndex ==
                              sessionIndex
                      ? AnimatedTextKit(
                          repeatForever: false,
                          animatedTexts: [
                            TypewriterAnimatedText(
                              text.trim(),
                              textStyle: GoogleFonts.nunito(
                                  fontSize: isApi ? 15 : 16,
                                  color: isApi ? Colors.white70 : Colors.white,
                                  fontWeight: !isApi
                                      ? FontWeight.w700
                                      : FontWeight.normal),
                            ),
                          ],
                          totalRepeatCount: 1,
                          onFinished: () {
                            isCarouselMessage
                                ? textCompletionProvider.changeAnimate(
                                    messageIndex,
                                    false,
                                    upperMessageIndex,
                                    sessionIndex)
                                : textCompletionProvider.changeAnimate(
                                    messageIndex,
                                    true,
                                    upperMessageIndex,
                                    sessionIndex);
                          },
                          isRepeatingAnimation: false,
                        )
                      : Text(
                          text.trim(),
                          style: GoogleFonts.nunito(
                              fontSize: isApi ? 15 : 16,
                              color: isApi ? Colors.white70 : Colors.white,
                              fontWeight:
                                  !isApi ? FontWeight.w600 : FontWeight.normal),
                        ),
                ),
                !isApi
                    ? IconButton(
                        onPressed: () => {
                              textCompletionProvider
                                  .changeShowSaveAndCancelButton(id, true),
                              textCompletionProvider.setMessageUpdate(
                                  true, text)
                            },
                        icon: const Icon(
                          Icons.edit_note,
                          color: Colors.grey,
                        ))
                    : const SizedBox()
              ],
            ),
            isApi
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 3),
                        child: Text(
                          formatTime(timeStamp),
                          style: GoogleFonts.nunito(
                              fontSize: 14, color: Colors.grey),
                        ),
                      ),
                      Row(
                        children: [
                          LikeButton(
                              isLiked: isLiked,
                              size: 24.0,
                              onTap: onLikeButtonTapped,
                              likeBuilder: (isLiked) => Icon(
                                    isLiked
                                        ? Icons.thumb_up_alt
                                        : Icons.thumb_up_off_alt,
                                    color: isLiked
                                        ? const Color.fromARGB(
                                            255, 78, 171, 112)
                                        : Colors.grey,
                                  )),
                          IconButton(
                              onPressed: () => {
                                    isCarouselMessage
                                        ? textCompletionProvider.disLikeMessage(
                                            messageIndex,
                                            id,
                                            sessionIndex,
                                            upperMessageIndex,
                                            true)
                                        : textCompletionProvider.disLikeMessage(
                                            messageIndex,
                                            id,
                                            sessionIndex,
                                            upperMessageIndex,
                                            false),
                                  },
                              splashColor: Colors.transparent,
                              icon: isDisLiked
                                  ? const Icon(
                                      Icons.thumb_down_alt,
                                      color: Color.fromARGB(255, 244, 67, 54),
                                    )
                                  : const Icon(
                                      Icons.thumb_down_off_alt,
                                      color: Colors.grey,
                                    ))
                        ],
                      ),
                    ],
                  )
                : const SizedBox(),
            !isApi && id == value.save_and_cancel_button
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextButton(
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all<Color>(cgSecondary),
                          ),
                          onPressed: () => {
                                textCompletionProvider.updateMessage(
                                    upperMessageIndex,
                                    id,
                                    sessionIndex,
                                    context)
                              },
                          child: Text(
                            "Save & Submit",
                            style: GoogleFonts.nunito(
                                color: Colors.white70,
                                fontWeight: FontWeight.w600,
                                fontSize: 16),
                          )),
                      const SizedBox(
                        width: 15,
                      ),
                      OutlinedButton(
                          style: OutlinedButton.styleFrom(
                              side: const BorderSide(color: Colors.white70)),
                          onPressed: () => {
                                textCompletionProvider
                                    .changeShowSaveAndCancelButton(
                                  id,
                                  false,
                                ),
                                textCompletionProvider.setMessageUpdate(
                                    false, text),
                              },
                          child: Text(
                            "Cancel",
                            style: GoogleFonts.nunito(
                                color: Colors.white70,
                                fontWeight: FontWeight.w600,
                                fontSize: 16),
                          ))
                    ],
                  )
                : const SizedBox()
          ],
        ),
      ),
    );
  }
}

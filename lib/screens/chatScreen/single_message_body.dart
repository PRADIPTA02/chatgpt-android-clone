import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:chatgpt/screens/chatScreen/chat_avatar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../constants.dart';
import '../../providers/text_copletion_provider.dart';

class SingleMessageBody extends StatelessWidget {
  const SingleMessageBody({
    super.key,
    required this.text,
    required this.isApi,
    required this.isAnimate,
    required this.timeStamp,
    required this.id,
    required this.messageIndex,
    required this.sessionIndex,
  });
  final String text;
  final bool isApi;
  final bool isAnimate;
  final int timeStamp;
  final String id;
  final int messageIndex;
  final int sessionIndex;

  String getTime(int timestamp) {
    DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
    int hour = dateTime.hour % 12;
    int minute = dateTime.minute;
    int second = dateTime.second;
    return "$hour:$minute:$second";
  }

  @override
  Widget build(BuildContext context) {
    final _textCompletionProvider =
        Provider.of<TextCompletProvider>(context, listen: false);
    if(isApi && isAnimate&&_textCompletionProvider.CurrentSessionIndex==sessionIndex){
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
                  child: isApi && isAnimate&&_textCompletionProvider.CurrentSessionIndex==sessionIndex
                      ? AnimatedTextKit(
                          repeatForever: false,
                          animatedTexts: [
                            TypewriterAnimatedText(
                              text.trim(),
                              textStyle: TextStyle(
                                  fontSize: 18,
                                  color: isApi
                                      ? Colors.white70
                                      : Colors.white,
                                  fontWeight: !isApi
                                      ? FontWeight.w700
                                      : FontWeight.normal),
                            ),
                          ],
                          totalRepeatCount: 1,
                          onFinished: () {
                            if (isApi) {
                              _textCompletionProvider.changeIsloadingState();
                            }
                            _textCompletionProvider
                                .changeAnimate(messageIndex);
                          },
                          isRepeatingAnimation: false,
                        )
                      :Text(
                          text.trim(),
                          style: const TextStyle(fontSize: 18, color: Colors.white70),
                        ),
                ),
                !isApi
                    ? IconButton(
                        onPressed: () => {
                              _textCompletionProvider
                                  .changeShowSaveAndCancelButton(
                                      id, true),
                              _textCompletionProvider.setMessageUpdate(true,text )
                            },
                        icon: const Icon(
                          Icons.edit_note,
                          color: Colors.white70,
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
                          getTime(timeStamp),
                          style: const TextStyle(fontSize: 18, color: Colors.white60),
                        ),
                      ),
                      Row(
                        children: [
                          IconButton(
                              onPressed: () => {},
                              icon: const Icon(
                                Icons.thumb_up_outlined,
                                color: Colors.white70,
                              )),
                          IconButton(
                              onPressed: () => {},
                              icon: const Icon(
                                Icons.thumb_down_outlined,
                                color: Colors.white70,
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
                            _textCompletionProvider.updateMessage(messageIndex-1,id,_textCompletionProvider.CurrentSessionIndex)
                          },
                          child: const Text(
                            "Save & Submit",
                            style: TextStyle(
                                color: Colors.white70,
                                fontWeight: FontWeight.bold,
                                fontSize: 18),
                          )),
                      const SizedBox(
                        width: 15,
                      ),
                      OutlinedButton(
                          style: OutlinedButton.styleFrom(
                              side: const BorderSide(color: Colors.white70)),
                          onPressed: () => {
                                _textCompletionProvider
                                    .changeShowSaveAndCancelButton(
                                        id, false,),
                                        _textCompletionProvider.setMessageUpdate(false,text),
                              },
                          child: const Text(
                            "Cancel",
                            style: TextStyle(
                                color: Colors.white70,
                                fontWeight: FontWeight.bold,
                                fontSize: 18),
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

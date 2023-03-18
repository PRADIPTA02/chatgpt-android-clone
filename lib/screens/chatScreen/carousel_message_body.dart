import 'package:chatgpt/models/message_model.dart';
import 'package:chatgpt/screens/chatScreen/single_message_body.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/text_copletion_provider.dart';

class CarouselMessageBody extends StatefulWidget {
   CarouselMessageBody({super.key,required this.ms,required this.upeerMessageIndex});
   final List<Message> ms;
   late int messageIndex = 0;
    final upeerMessageIndex;
  

  @override
  State<CarouselMessageBody> createState() => _CarouselMessageBodyState();
}

class _CarouselMessageBodyState extends State<CarouselMessageBody> {

  @override
  Widget build(BuildContext context) {
    final _textCompletionProvider =
        Provider.of<TextCompletProvider>(context, listen: false);
    return Consumer<TextCompletProvider>(
      builder: (context, value, child) => Column(
        children: [
          SingleMessageBody(
            text: widget.ms[widget.messageIndex].message_text,
            isApi: widget.ms[widget.messageIndex].isApi,
            isAnimate: widget.ms[widget.messageIndex].isAnimate,
            timeStamp: widget.ms[widget.messageIndex].timeStamp,
            id: widget.ms[widget.messageIndex].id,
            messageIndex: widget.messageIndex,
            sessionIndex: _textCompletionProvider.CurrentSessionIndex,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                  onPressed: () => {
                       setState(()=>{
                           widget.messageIndex = --widget.messageIndex%widget.ms.length
                       })
                      },
                  icon: const Icon(
                    Icons.arrow_back_ios,
                    color: Colors.white70,
                  )),
              Text(
                "${widget.messageIndex + 1} ",
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
                " ${widget.ms.length}",
                style: const TextStyle(
                    color: Colors.white70,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
              IconButton(
                  onPressed: () => {
                       setState(()=>{
                           widget.messageIndex = ++widget.messageIndex%widget.ms.length
                       })
                      },
                  icon: const Icon(Icons.arrow_forward_ios, color: Colors.white70))
            ],
          )
        ],
      ),
    );
  }
}

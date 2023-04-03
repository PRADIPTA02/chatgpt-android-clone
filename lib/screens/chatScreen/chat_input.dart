import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/internet_connection_check_provider.dart';
import '../../providers/text_copletion_provider.dart';
import '../../util/constants/constants.dart';
 
class ChatInput extends StatelessWidget {
  const ChatInput({super.key});
  @override
  Widget build(BuildContext context) {
    final _textCompletionProvider =
        Provider.of<TextCompletProvider>(context, listen: false);
    return Consumer2<TextCompletProvider, InterNetConnectionCheck>(
      builder: (context, TextCompletProvider, InterNetConnectionCheck, child) =>
          Scrollbar(
            child: TextField(
                  controller: TextCompletProvider.chat_imput_Controler,
                  autofocus: false,
                  onChanged: (text) {
            _textCompletionProvider.onChangeTextInput(text);
                  },
                  style: const TextStyle(fontSize: 20, color: Colors.white70),
                  minLines: 1,
                  maxLines: 5,
                  cursorColor: cgSecondary,
                  decoration: const InputDecoration(
            isDense: true,
            isCollapsed: true,
            contentPadding: EdgeInsets.only(top: 11, bottom: 11, left: 5),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(3)),
                borderSide: BorderSide.none),
            filled: true,
            fillColor: secondaryColor,
                  ),
                ),
          ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/text_copletion_provider.dart';

class CustomTextWidget extends StatelessWidget {
  CustomTextWidget({
    super.key,required this.text,
    
    // required this.onTapCallback
    }){
    // onTapCallback();
    
  }
  final String text;
  // final Function() onTapCallback;

  @override
  Widget build(BuildContext context) {
        final _textCompletionProvider =
        Provider.of<TextCompletProvider>(context, listen: false);
        _textCompletionProvider.changeIsloadingState();
    return Text(
      text,
      style: TextStyle(fontSize: 18, color: Colors.white70),
    );
  }
}
import 'package:chatgpt/constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/text_copletion_provider.dart';

class SessionEditDialog extends StatelessWidget {
  final int sessionIndex;
  SessionEditDialog(
      {super.key, required String sessionName, required this.sessionIndex}) {
    _controller.text = sessionName;
  }
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final _textCompletionProvider = Provider.of<TextCompletProvider>(
        context as BuildContext,
        listen: false);
    return Consumer(
      builder: (context, value, child) => AlertDialog(
        shadowColor: Colors.transparent,
        backgroundColor: bgColor,
        title: Text(
          'Edit Session Name',
          style: TextStyle(color: Colors.white70),
        ),
        content: Container(
          width: 500,
          child: TextField(
            controller: _controller,
            style: TextStyle(fontSize: 20, color: Colors.white70),
            decoration: InputDecoration(
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.white),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.white),
              ),
            ),
          ),
        ),
        actions: [
          OutlinedButton(
              style: OutlinedButton.styleFrom(
                  side: BorderSide(color: Colors.white70)),
              onPressed: () => Navigator.of(context).pop(),
              child: Text(
                "Cancel",
                style: TextStyle(
                    color: Colors.white70,
                    fontWeight: FontWeight.bold,
                    fontSize: 18),
              )),
          TextButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(cgSecondary),
              ),
              onPressed: () => {
                    _textCompletionProvider.updateSession(
                        _textCompletionProvider.allSesions[sessionIndex],
                        _controller.text.toString()),
                    Navigator.of(context).pop()
                  },
              child: Text(
                "Save",
                style: TextStyle(
                    color: Colors.white70,
                    fontWeight: FontWeight.bold,
                    fontSize: 18),
              )),
        ],
      ),
    );
  }
}

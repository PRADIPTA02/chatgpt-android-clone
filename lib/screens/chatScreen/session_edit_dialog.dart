import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../providers/text_copletion_provider.dart';
import '../../util/constants/constants.dart';

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
        title: const Text(
          'Edit Session Name',
          style: TextStyle(color: Colors.white70),
        ),
        content: Container(
          width: 500,
          child: TextField(
            controller: _controller,
            style: GoogleFonts.nunito(fontSize: 20, color: Colors.white70),
            decoration: const InputDecoration(
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
                  side: const BorderSide(color: Colors.white70)),
              onPressed: () => Navigator.of(context).pop(),
              child: Text(
                "Cancel",
                style: GoogleFonts.nunito(
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
                style: GoogleFonts.nunito(
                    color: Colors.white70,
                    fontWeight: FontWeight.bold,
                    fontSize: 18),
              )),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../providers/text_copletion_provider.dart';

class CustomTextWidget extends StatelessWidget {
  CustomTextWidget({
    super.key,
    required this.text,

    // required this.onTapCallback
  }) {
    // onTapCallback();
  }
  final String text;
  // final Function() onTapCallback;

  @override
  Widget build(BuildContext context) {
    final textCompletionProvider =
        Provider.of<TextCompletProvider>(context, listen: false);
    textCompletionProvider.changeIsloadingState(false);
    return Text(
      text,
      style: GoogleFonts.nunito(fontSize: 18, color: Colors.white70),
    );
  }
}

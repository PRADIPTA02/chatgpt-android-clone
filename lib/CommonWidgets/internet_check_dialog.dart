import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../util/constants/constants.dart';

class InternetCheckDialog extends StatelessWidget {
  const InternetCheckDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Row(
        children:  [
          const Icon(Icons.signal_wifi_off,color: Colors.white,),
          const SizedBox(width: 10),
          Text(
            'No Internet Connection',
            style: GoogleFonts.nunito (
              color: Colors.white
            ),
          ),
        ],
      ),
      content: SingleChildScrollView(
        child: ListBody(
          children: [
            Row(
              children:  [
                const Icon(
                  Icons.info_outline,
                  color: Colors.white70,
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    'Please check your internet connection and try again.',
                    style: GoogleFonts.nunito(
                      color: Colors.white70,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          child: const Text(
            'OK',
            style: TextStyle(
              color: cgSecondary,
              fontWeight: FontWeight.bold,
            ),
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      elevation: 10.0,
      backgroundColor: bgColor,
      shadowColor: Colors.transparent,
    );
  }
}

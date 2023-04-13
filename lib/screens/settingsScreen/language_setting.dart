import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'back_button.dart';

class LanguageSetting extends StatelessWidget {
  const LanguageSetting({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Image.asset(
              'assets/images/languageicon.png',
              height: 30,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.05,
            ),
            Text(
              "Language",
              style: GoogleFonts.nunito(
                  color: const Color.fromARGB(255, 212, 211, 211),
                  fontSize: 18,
                  fontWeight: FontWeight.w700),
            ),
          ],
        ),
        Row(
          children: [
            Text(
              "English",
              style: GoogleFonts.nunito(
                  color: Colors.white30,
                  fontSize: 16,
                  fontWeight: FontWeight.w700),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.05,
            ),
            CustomBackButton(
              onTap: () => {},
            )
          ],
        ),
      ],
    );
  }
}

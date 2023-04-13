import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'back_button.dart';

class AdvanceSettings extends StatelessWidget {
  const AdvanceSettings({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Image.asset(
              'assets/images/advanceSettingsIcon.png',
              height: 30,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.05,
            ),
            Text(
              "Advance Settings",
              style: GoogleFonts.nunito(
                  color: const Color.fromARGB(255, 212, 211, 211),
                  fontSize: 18,
                  fontWeight: FontWeight.w700),
            ),
          ],
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.05,
        ),
        CustomBackButton(
          onTap: () => {},
        ),
      ],
    );
  }
}
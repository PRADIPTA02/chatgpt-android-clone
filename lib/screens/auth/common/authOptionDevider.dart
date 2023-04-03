import 'package:chatgpt/util/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AuthOptionDevider extends StatelessWidget {
  const AuthOptionDevider({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          color: Colors.white12,
          height: 3,
          width: MediaQuery.of(context).size.width * 0.40,
        ),
        Text(
          "or",
          style: GoogleFonts.nunito(
            color: Colors.white30,
            fontWeight: FontWeight.w700,
            fontSize: 25,
          ),
        ),
        Container(
          color: Colors.white12,
          height: 3,
          width: MediaQuery.of(context).size.width * 0.40,
        ),
      ],
    );
  }
}

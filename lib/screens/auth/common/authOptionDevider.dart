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
          color: cglasscolor,
          height: 2,
          width: MediaQuery.of(context).size.width * 0.40,
        ),
        Text(
          "or",
          style: GoogleFonts.nunito(
            color: cgSecondary,
            fontWeight: FontWeight.w700,
            fontSize: 20,
          ),
        ),
        Container(
          color: cglasscolor,
          height: 2,
          width: MediaQuery.of(context).size.width * 0.40,
        ),
      ],
    );
  }
}

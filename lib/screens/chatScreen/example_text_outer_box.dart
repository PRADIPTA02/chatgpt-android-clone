import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../util/constants/constants.dart';

class ExampleTextOuterBox extends StatelessWidget {
  const ExampleTextOuterBox({super.key, required this.text});
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: secondaryColor,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Center(
          child: Text(
        text,
        style: GoogleFonts.nunito(
            fontSize: 16, color: Colors.white70, fontWeight: FontWeight.w500),
        textAlign: TextAlign.center,
      )),
    );
  }
}

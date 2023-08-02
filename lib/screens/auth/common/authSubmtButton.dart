import 'package:chatgpt/providers/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../../util/constants/constants.dart';

class AuthSubmitButton extends StatelessWidget {
  const AuthSubmitButton({super.key, required this.title});
  final String title;
  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(
      builder: (context, value, child) => InkWell(
        child: Container(
          height: MediaQuery.of(context).size.height * 0.06,
          decoration: BoxDecoration(
              gradient: const LinearGradient(
                begin: Alignment.topLeft,
                
                colors: <Color>[
                  Color(0xffd62507),
                  Color(0xffe55a32)
                ], // red to yellow
                tileMode:
                    TileMode.clamp, // repeats the gradient over the canvas
              ),
              borderRadius: BorderRadius.circular(5),
              border: Border.all(color: cglasscolor, width: 2)),
          child: Center(
              child: value.isLoading
                  ? const SizedBox(
                      height: 35,
                      width: 35,
                      child: CircularProgressIndicator(
                        color: Colors.white,
                      ))
                  : Text(title,
                      style: GoogleFonts.nunito(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          color: Colors.white70))),
        ),
      ),
    );
  }
}

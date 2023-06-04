// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ChatAvater extends StatelessWidget {
  ChatAvater({super.key, this.isApi = true});
  bool isApi;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 38,
      width: 38,
      child: Center(
          child: !isApi
              ? Text(
                  "DP",
                  style: GoogleFonts.nunito(
                      fontSize: 20,
                      color: Colors.white70,
                      fontWeight: FontWeight.bold),
                )
              : Image.asset("assets/images/api_avater.png")),
      decoration: BoxDecoration(
        color: !isApi ? Color.fromRGBO(44, 123, 175, 1) : Colors.transparent,
        borderRadius: BorderRadius.circular(3),
      ),
    );
  }
}

import 'package:chatgpt/screens/startingScreen/start_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../util/constants/constants.dart';

class StartScreen extends StatelessWidget {
  const StartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: bgColor,
        elevation: 0,
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
        ),
      ),
      backgroundColor: bgColor,
      body: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
        Center(
          child: Image.asset("assets/images/logo.png"),
        ),
         Text(
          "ChatGPT",
          style:  GoogleFonts.nunito  (
              color: Colors.white, fontSize: 35, fontWeight: FontWeight.w800),
        ),
        const SizedBox(
          height: 40,
        ),
         Text(
          "Developed by OpenAI",
          style:GoogleFonts.nunito  (
              color: Color.fromRGBO(20, 167, 129, 1),
              fontSize: 20,
              fontWeight: FontWeight.w800),
        ),
        const SizedBox(
          height: 80,
        ),
        Text(
          "Millions of people have already followed \n our community. Lets start your journey",
          style:GoogleFonts.nunito  (
              color: Color.fromRGBO(122, 121, 136, 1),
              fontSize: 17,
              fontWeight: FontWeight.w500),
        ),
        const SizedBox(
          height: 80,
        ),
        const StartButton(text: "Get Startted"),
        const SizedBox(
          height: 80,
        ),
        Text(
          "Already have an account? Sign in",
          style:  GoogleFonts.nunito (
              color: Colors.white70, fontSize: 18, fontWeight: FontWeight.bold),
        )
      ]),
    );
  }
}

import 'dart:async';

import 'package:chatgpt/screens/auth/AuthScreen/auth_screen.dart';
import 'package:chatgpt/screens/chatScreen/chatScreen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../util/constants/constants.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin  {
  AnimationController? controller;
  Animation<double>? animation;
  late Timer _timer;
  late bool isloading = true;
  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      duration: const Duration(seconds: 10),
      vsync: this,
    )..repeat();
    animation = CurvedAnimation(parent: controller!, curve: Curves.easeIn);
    _timer = Timer.periodic(const Duration(seconds: 10), (timer) {
      setState(() {
        isloading = false;
      });
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const AuthScren(),
          ));
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    controller!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenHight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: bgColor,
      body: Padding(
        padding: const EdgeInsets.only(left: 8.0, top: 80, right: 8.0),
        child: Column(
          children: [
            RotationTransition(
              turns: animation!,
              child: Center(
                  child: Image.asset(
                'assets/images/api_avater.png',
                height: screenHight * 0.4,
              )),
            ),
             SizedBox(
              height: MediaQuery.of(context).size.height * 0.06,
            ),
            Text(
              "AI BUDDY",
              style: GoogleFonts.righteous(
                color: Colors.white,
                fontSize: 35,
                fontWeight: FontWeight.bold,
              ),
            ),
             SizedBox(
              height: MediaQuery.of(context).size.height * 0.3,
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Text(
                "V_1.0.0",
                style: GoogleFonts.nunito(
                  color: Colors.white70,
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

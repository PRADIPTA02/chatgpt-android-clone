import 'dart:async';

import 'package:chatgpt/screens/chatScreen/chatScreen.dart';
import 'package:flutter/material.dart';

import '../../util/constants/constants.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late Timer _timer;
  @override
  void initState() {
    super.initState();
    _timer = new Timer.periodic(const Duration(seconds: 3), (timer) {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const ChatScreen(),
          ));
    });
  }
  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: cgSecondary,
      body: Center(
          child: Image.asset(
        'assets/logo/chatgpt(1).png',
        height: screenHight,
        width: screenWidth * 0.4,
      )),
    );
  }
}

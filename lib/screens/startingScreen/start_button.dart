import 'package:chatgpt/constants.dart';
import 'package:chatgpt/screens/homescreen/home_screen.dart';
import 'package:flutter/material.dart';

class StartButton extends StatelessWidget {
  final String text;
  const StartButton({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 58,
      width: 280,
      child: OutlinedButton(
        onPressed: () => {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const HomeScreen()),
          )
        },
        style: OutlinedButton.styleFrom(
          backgroundColor: secondaryColor,
          side: BorderSide(
            width: .90,
            color: Colors.white70,
          ),
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(50))),
        ),
        child: Text(
          text,
          style: TextStyle(
              color: Colors.white70, fontSize: 25, fontWeight: FontWeight.w400),
        ),
      ),
    );
  }
}

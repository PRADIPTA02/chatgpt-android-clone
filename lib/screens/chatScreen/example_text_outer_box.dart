import 'package:chatgpt/constants.dart';
import 'package:flutter/material.dart';

class ExampleTextOuterBox extends StatelessWidget {
  const ExampleTextOuterBox({super.key, required this.text});
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(15),
      child: Center(
          child: Text(
        this.text,
        style: TextStyle(
            fontSize: 16, color: Colors.white70, fontWeight: FontWeight.w500),
        textAlign: TextAlign.center,
      )),
      decoration: BoxDecoration(
        color: secondaryColor,
        borderRadius: BorderRadius.circular(5),
      ),
    );
  }
}

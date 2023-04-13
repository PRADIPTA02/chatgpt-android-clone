import 'package:flutter/material.dart';


class CustomTextButton extends StatelessWidget {
   CustomTextButton({
    super.key,
    required this.ontap,
    required this.buttonText,
    this.color = Colors.white,
    this.textColor = Colors.black,
    });
  final String buttonText;
  final VoidCallback ontap;
  Color color;
  final Color textColor;
  @override
  Widget build(BuildContext context) {
    return TextButton(
  onPressed: ()=>{},
  child: Container(
    padding: const EdgeInsets.fromLTRB(30, 10, 30, 10),
    color: color,
    child: Text(buttonText),
  ),
);
  }
}
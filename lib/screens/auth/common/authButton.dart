import 'package:flutter/material.dart';
import '../../../util/constants/constants.dart';

class AuthButton extends StatelessWidget {
  const AuthButton({super.key, required this.ontap, required this.buttonIcon});
  final VoidCallback ontap;
  final String buttonIcon;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ontap,
      child: Container(
        width: MediaQuery.of(context).size.width*0.43,
        height:MediaQuery.of(context).size.height*0.07,
        decoration: BoxDecoration(
          color: secondaryColor,
          borderRadius: BorderRadius.circular(5),
          border: Border.all(
            color: cglasscolor,
            width: 2
          )
        ),
        child: Center(child: Image.asset(buttonIcon,height: 35,))
        ),
    );
  }
}

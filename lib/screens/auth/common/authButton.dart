import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../util/constants/constants.dart';

class AuthButton extends StatelessWidget {
  const AuthButton({super.key, required this.ontap, required this.buttonIcon});
  final VoidCallback ontap;
  final String buttonIcon;
  @override
  Widget build(BuildContext context) {
    return Container(
      height:MediaQuery.of(context).size.height*0.06,
      decoration: BoxDecoration(
        color: secondaryColor,
        borderRadius: BorderRadius.circular(5),
        border: Border.all(
          color: cglasscolor,
          width: 2
        )
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(buttonIcon,height: 20,),
          SizedBox(width: MediaQuery.of(context).size.width*0.05,),
          Text("Sign in with Google",style: GoogleFonts.nunito(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Colors.white70
          ),)
        ],
      )
      );
  }
}

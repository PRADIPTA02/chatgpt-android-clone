import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../util/constants/constants.dart';

class AuthSubmitButton extends StatelessWidget {
  const AuthSubmitButton({super.key,required this.ontap,required this.title});
  final VoidCallback ontap;
  final String title;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ontap,
      child: Container(
        width: MediaQuery.of(context).size.width*0.95,
        height:MediaQuery.of(context).size.height*0.06,
        decoration: BoxDecoration(
          color: cgSecondary,
          borderRadius: BorderRadius.circular(5),
          border: Border.all(
            color: cglasscolor,
            width: 2
          )
        ),
        child: Center(child: Text(title,style: GoogleFonts.nunito(
          fontSize: 21,
          fontWeight: FontWeight.w800,
          color: Colors.white
        ))),
        ),
    );
  }
}
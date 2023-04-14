import 'package:chatgpt/providers/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../../util/constants/constants.dart';

class AuthSubmitButton extends StatelessWidget {
  const AuthSubmitButton({super.key,required this.ontap,required this.title});
  final VoidCallback ontap;
  final String title;
  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(
      builder: (context, value, child) => InkWell(
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
          child: Center(child: value.isLoading? const SizedBox(height:35,width:35,child: CircularProgressIndicator(color: Colors.white, )): Text(title,style: GoogleFonts.nunito(
            fontSize: 18,
            fontWeight: FontWeight.w800,
            color: Colors.white70
          ))),
          ),
      ),
    );
  }
}
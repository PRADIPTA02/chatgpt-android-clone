import 'package:chatgpt/providers/auth_provider.dart';
import 'package:chatgpt/util/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class SignOutDialog extends StatelessWidget {
  const SignOutDialog({super.key});
  static const spinKit = SizedBox(
    height: 50,
    width: 50,
    child: SpinKitRing(
      color: Colors.white,
      size: 50.00,
    ),
  );
  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    return AlertDialog(
      backgroundColor: secondaryColor,
      shadowColor: Colors.transparent,
      insetPadding: const EdgeInsets.all(20),
      actionsAlignment: MainAxisAlignment.spaceAround,
      elevation: 0,
      title: Text(
        "Sign Out",
        style: GoogleFonts.nunito(
            color: Colors.white, fontWeight: FontWeight.bold),
      ),
      content: Consumer<AuthProvider>(
        builder: (context, value, child) => value.isLoading
            ? const SizedBox(
                height: 50,
                width: 50,
                child: Center(
                    child: CircularProgressIndicator(
                  color: cgSecondary,
                )))
            : Text(
                "Are you sure you want to log-out? ",
                style: GoogleFonts.nunito(
                  color: Colors.white70,
                  fontWeight: FontWeight.w500,
                ),
              ),
      ),
      actions: [
        TextButton(
          onPressed: () => {
            Navigator.pop(context),
          },
          child: Text(
            'CANCEL',
            style: GoogleFonts.nunito(
                color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
        Container(
          width: 2,
          height: MediaQuery.of(context).size.height*0.03,
          
          decoration: BoxDecoration(color: cglasscolor,borderRadius: BorderRadius.circular(5)),
        ),
        TextButton(
          onPressed: () => {
            authProvider.SignOut(),
            Navigator.pop(context),
          },
          style: const ButtonStyle(),
          child: Text(
            'CONFIRM',
            style: GoogleFonts.nunito(
                color: cgSecondary, fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }
}

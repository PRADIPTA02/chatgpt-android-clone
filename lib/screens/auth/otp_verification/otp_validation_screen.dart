import 'package:chatgpt/providers/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../../util/constants/constants.dart';
import '../common/authSubmtButton.dart';
import '../common/heading.dart';

class OtpValidationScreen extends StatelessWidget {
  const OtpValidationScreen(
      {super.key, required this.address, required this.verificationId});
  final String address;
  final String verificationId;
  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    return Scaffold(
          backgroundColor: bgColor,
          body: SafeArea(
              child: Padding(
                  padding: const EdgeInsets.only(
                      left: 15, right: 15, top: 15, bottom: 0),
                  child: SingleChildScrollView(
                      reverse: true,
                      physics: const BouncingScrollPhysics(
                        decelerationRate: ScrollDecelerationRate.fast,
                      ),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Heading(title: "Enter OTP"),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.04,
                            ),
                            Text(
                              overflow: TextOverflow.ellipsis,
                              "A 6 digit code has been sent to\n$address",
                              style: GoogleFonts.nunito(
                                  fontSize: 15, color: Colors.white70),
                            ),
                            SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.05),
                            SizedBox(
                              child: OtpTextField(
                                fieldWidth:
                                    MediaQuery.of(context).size.width * 0.13,
                                numberOfFields: 6,
                                showFieldAsBox: true,
                             
                                borderWidth: 2.0,
                                filled: true,
                                textStyle: GoogleFonts.nunito(
                                    color: Colors.white70,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold),
                                cursorColor: cgSecondary,
                                borderRadius: BorderRadius.circular(3),
                                fillColor: secondaryColor,
                                borderColor: cglasscolor,
                                enabledBorderColor: cglasscolor,
                                focusedBorderColor: cgSecondary,
                                disabledBorderColor: cglasscolor,
                                onCodeChanged: (String code) {},
                                onSubmit: (String verificationCode) {
                                  authProvider.setVerificationCode(verificationCode);
                                },
                              ),
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.04,
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.89,
                              child: RichText(
                                  textAlign: TextAlign.end,
                                  text: TextSpan(
                                      text: "Didn't you receive the OPT? ",
                                      style: GoogleFonts.nunito(
                                          color: Colors.white70),
                                      children: <TextSpan>[
                                        TextSpan(
                                          text: '59',
                                          style: GoogleFonts.nunito(
                                              color: cgSecondary,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        const TextSpan(text: 's '),
                                        TextSpan(
                                          text: "Resend OTP",
                                          style: GoogleFonts.nunito(
                                              color: cgSecondary,
                                              fontWeight: FontWeight.bold),
                                        )
                                      ])),
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.05,
                            ),
                            AuthSubmitButton(
                                ontap: () {
                                  authProvider.verify_otp(verificationId, authProvider.verificationCode,context);
                                },
                                title: "Submit"),
                          ])))));
  }
}

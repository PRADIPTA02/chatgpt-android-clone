// ignore_for_file: must_be_immutable

import 'package:chatgpt/providers/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../../util/constants/constants.dart';
import '../common/authSubmtButton.dart';
import '../common/heading.dart';

class ForgotPasswordScreen extends StatelessWidget {
  ForgotPasswordScreen({super.key});
    GlobalKey<FormState> _forgot_password_formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
  FocusNode _focusNode1 = FocusNode();
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
                          const Align(
                              alignment: Alignment.topLeft,
                              child: Heading(title: "Forgot\nPassword?")),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.04,
                          ),
                           Text(
                              "Don't worry! It happens. Please enter the address associated with your account.",
                              style: GoogleFonts.nunito(
                                fontSize: 15,
                                color: Colors.white70
                              ),
                              ),
                               SizedBox(
                              height:
                                  MediaQuery.of(context).size.height * 0.05),
                          Text("Email / Phone",
                              style: GoogleFonts.nunito(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 15)),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            child: Consumer<AuthProvider>(
                              builder: (context, value, child) => Form(
                                key: _forgot_password_formKey,
                                child: TextFormField(
                                  focusNode: _focusNode1,
                                  onFieldSubmitted: (e) =>
                                      {},
                                  controller: authProvider.forgot_password_email_controller,
                                  cursorColor: cgSecondary,
                                  cursorRadius: const Radius.circular(5),
                                  keyboardType: TextInputType.emailAddress,
                                  // autovalidateMode:
                                  //     AutovalidateMode.onUserInteraction,
                                  style: GoogleFonts.nunito(
                                      color: Colors.white70,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'please enter a valid cradetial';
                                    }
                                    final emailRegex =
                                        RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
                                    final phoneRegex = 
                                        RegExp(r'^\s*(?:\+?(\d{1,3}))?[-. (]*(\d{3})[-. )]*(\d{3})[-. ]*(\d{4})(?: *x(\d+))?\s*$');
                                       return emailRegex.hasMatch(value)?null:phoneRegex.hasMatch(value)?null:'please enter a valid credentials';
                                  },
                                  decoration: const InputDecoration(
                                    contentPadding: EdgeInsets.symmetric(
                                        vertical: 15, horizontal: 12),
                                    filled: true,
                                    fillColor: secondaryColor,
                                    hintText: 'Email ID / Mobile number',
                                    hintStyle: TextStyle(
                                      color: Colors.white30,
                                      fontWeight: FontWeight.w600,
                                    ),
                                    errorStyle: TextStyle(
                                        fontWeight: FontWeight.bold),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(width: 2, color: cglasscolor),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(width: 2, color: cgSecondary),
                                    ),
                                    errorBorder: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(width: 2, color: errorColor),
                                    ),
                                    focusedErrorBorder: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(width: 2, color: errorColor),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height*0.03,
                          ),
                          AuthSubmitButton(
                              ontap: () {
                                if (_forgot_password_formKey.currentState!.validate()) {
                                  print(authProvider.forgot_password_email_controller.value);
                                }
                              },
                              title: "Submit"),
                              
                        ])))));
  }
}

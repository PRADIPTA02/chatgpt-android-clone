// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'package:chatgpt/screens/auth/common/authButton.dart';
import 'package:chatgpt/screens/auth/common/authOptionDevider.dart';
import 'package:chatgpt/screens/auth/common/authSubmtButton.dart';
import 'package:chatgpt/screens/auth/signUpScreen/signUp_screen.dart';
import 'package:chatgpt/util/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../../providers/auth_provider.dart';
import '../common/heading.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});
  GlobalKey<FormState> _login_formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    FocusNode _focusNode1 = FocusNode();
    FocusNode _focusNode2 = FocusNode();
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: bgColor,
        elevation: 0,
        title: const Heading(title: "Log in"),
      ),
      backgroundColor: bgColor,
      body: SafeArea(
        child: Padding(
          padding:
              const EdgeInsets.only(left: 15, right: 15, top: 15, bottom: 0),
          child: SingleChildScrollView(
            reverse: true,
            physics: const BouncingScrollPhysics(
              decelerationRate: ScrollDecelerationRate.fast,
            ),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.05,
                  ),
                  Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        "Log in with one of the following options.",
                        style: GoogleFonts.nunito(
                            color: Colors.white60,
                            fontSize: 15,
                            fontWeight: FontWeight.w700),
                      )),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.02,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      AuthButton(
                          ontap: () => {},
                          buttonIcon: 'assets/images/googleIcon.png'),
                      AuthButton(
                          ontap: () => {},
                          buttonIcon: 'assets/images/github_icon.png')
                    ],
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.03,
                  ),
                  const AuthOptionDevider(),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.03),
                  Form(
                      key: _login_formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Email / Phone",
                              style: GoogleFonts.nunito(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 15)),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            child: TextFormField(
                              focusNode: _focusNode1,
                              onFieldSubmitted: (e) =>
                                  {_focusNode2.requestFocus()},
                              controller: authProvider.login_email_controller,
                              cursorColor: cgSecondary,
                              cursorRadius: const Radius.circular(5),
                              keyboardType: TextInputType.emailAddress,
                              style: GoogleFonts.nunito(
                                  color: Colors.white70,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'please enter a valid cradetial';
                                }
                                final emailRegex = RegExp(
                                    r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
                                final phoneRegex = RegExp(
                                    r'^\s*(?:\+?(\d{1,3}))?[-. (]*(\d{3})[-. )]*(\d{3})[-. ]*(\d{4})(?: *x(\d+))?\s*$');
                                return emailRegex.hasMatch(value)
                                    ? null
                                    : phoneRegex.hasMatch(value)
                                        ? null
                                        : 'please enter valid cradetial';
                              },
                              decoration: const InputDecoration(
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: 15, horizontal: 12),
                                filled: true,
                                fillColor: secondaryColor,
                                hintText: 'Email ID / Phone number',
                                hintStyle: TextStyle(
                                  color: Colors.white30,
                                  fontWeight: FontWeight.w500,
                                ),
                                errorStyle:
                                    TextStyle(fontWeight: FontWeight.bold),
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
                          SizedBox(
                              height:
                                  MediaQuery.of(context).size.height * 0.02),
                          Text("Password",
                              style: GoogleFonts.nunito(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 15)),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            child: Consumer<AuthProvider>(
                              builder: (context, value, child) => TextFormField(
                                focusNode: _focusNode2,
                                onEditingComplete: () => {
                                  _focusNode2.unfocus(),
                                  authProvider.SignIn(
                                      address: authProvider
                                          .login_email_controller.text,
                                      password: authProvider
                                          .login_password_controller.text,
                                      context: context),
                                },
                                keyboardType: TextInputType.emailAddress,
                                controller:
                                    authProvider.login_password_controller,
                                cursorColor: cgSecondary,
                                cursorRadius: const Radius.circular(5),
                                style: GoogleFonts.nunito(
                                    color: Colors.white70,
                                    fontWeight: FontWeight.w500),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter a password';
                                  }
                                  if (value.length < 6) {
                                    return 'Password must be at least 6 characters';
                                  }
                                  return null;
                                },
                                obscureText: !authProvider.showLoginPassword,
                                decoration: InputDecoration(
                                    filled: true,
                                    fillColor: secondaryColor,
                                    contentPadding: const EdgeInsets.symmetric(
                                        vertical: 15, horizontal: 12),
                                    suffixIcon: IconButton(
                                      splashColor: Colors.transparent,
                                      onPressed: () => {
                                        authProvider
                                            .changeLoginPasswordVisibility(),
                                      },
                                      icon: Icon(authProvider.showLoginPassword
                                          ? Icons.visibility_outlined
                                          : Icons.visibility_off_outlined),
                                      color: Colors.white70,
                                    ),
                                    hintText: 'Enter your password',
                                    hintStyle: const TextStyle(
                                        color: Colors.white30,
                                        fontWeight: FontWeight.w500),
                                    enabledBorder: const OutlineInputBorder(
                                      borderSide: BorderSide(
                                          width: 2, color: cglasscolor),
                                    ),
                                    focusedBorder: const OutlineInputBorder(
                                      borderSide: BorderSide(
                                          width: 2, color: cgSecondary),
                                    ),
                                    errorBorder: const OutlineInputBorder(
                                      borderSide: BorderSide(
                                          width: 2, color: errorColor),
                                    ),
                                    focusedErrorBorder:
                                        const OutlineInputBorder(
                                      borderSide: BorderSide(
                                          width: 2, color: errorColor),
                                    ),
                                    errorStyle: const TextStyle(
                                        // fontSize: 15,
                                        fontWeight: FontWeight.bold)),
                              ),
                            ),
                          ),
                          InkWell(
                            // splashColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            onTap: () => {},
                            child: Align(
                              alignment: Alignment.bottomRight,
                              child: Text(
                                'Forgot your password?',
                                style: GoogleFonts.nunito(
                                    color: cgSecondary,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 40,
                          ),
                          AuthSubmitButton(
                              ontap: () {
                                if (_login_formKey.currentState!.validate()) {
                                  _login_formKey.currentState!.save();
                                  authProvider.SignIn(
                                      address: authProvider
                                          .login_email_controller.text,
                                      password: authProvider
                                          .login_password_controller.text,
                                      context: context);
                                }
                              },
                              title: "Log in"),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.07,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Don't have an account? ",
                                style: GoogleFonts.nunito(
                                    fontSize: 16,
                                    color: Colors.white70,
                                    fontWeight: FontWeight.w600),
                              ),
                              InkWell(
                                splashColor: Colors.transparent,
                                onTap: () => {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) => SignUpScreen())),
                                },
                                child: Text(
                                  "Sign up",
                                  style: GoogleFonts.nunito(
                                      fontSize: 16,
                                      color: cgSecondary,
                                      fontWeight: FontWeight.w700),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.03,
                          ),
                        ],
                      ))
                ]),
          ),
        ),
      ),
    );
  }
}

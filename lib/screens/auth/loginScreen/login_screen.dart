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
  const LoginScreen({super.key});
  @override
  Widget build(BuildContext context) {
    GlobalKey<FormState> _login_formKey = GlobalKey<FormState>();
    FocusNode _focusNode1 = FocusNode();
    FocusNode _focusNode2 = FocusNode();
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    return Scaffold(
      // resizeToAvoidBottomInset: false,
      
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
            // keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Align(
                      alignment: Alignment.topLeft,
                      child: Heading(title: "Log in")),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.05,
                  ),
                  Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        "Log in with one of the following options.",
                        style: GoogleFonts.nunito(
                            color: Colors.white60,
                            fontSize: 17,
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
                          buttonIcon: 'assets/images/phoneIcon.png')
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
                          Text("Email",
                              style: GoogleFonts.nunito(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16)),
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
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              style: GoogleFonts.nunito(
                                  color: Colors.white70,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter an email address';
                                }
                                final emailRegex =
                                    RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
                                if (!emailRegex.hasMatch(value)) {
                                  return 'Please enter a valid email address';
                                }
                                return null;
                              },
                              decoration: const InputDecoration(
                                prefixIcon: Icon(
                                  Icons.alternate_email,
                                  color: Colors.white70,
                                ),
                                hintText: 'example@gmail.com',
                                hintStyle: TextStyle(
                                  color: Colors.white30,
                                  fontWeight: FontWeight.w600,
                                ),
                                errorStyle: TextStyle(
                                    // fontSize: 16, 
                                    fontWeight: FontWeight.bold),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      width: 2, color: Colors.white30),
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
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16)),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            child: Consumer<AuthProvider>(
                              builder: (context, value, child) => TextFormField(
                                focusNode: _focusNode2,
                                onEditingComplete: () => {
                                  _focusNode2.unfocus(),
                                  authProvider.SignIn(
                                      email: authProvider
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
                                    // fontSize: 16,
                                    fontWeight: FontWeight.w700),
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
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
                                    prefixIcon: const Icon(
                                      Icons.lock_outline,
                                      color: Colors.white70,
                                    ),
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
                                        fontWeight: FontWeight.w600),
                                    enabledBorder: const OutlineInputBorder(
                                      borderSide: BorderSide(
                                          width: 2, color: Colors.white30),
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
                            onTap: () => {},
                            child: Align(
                              alignment: Alignment.bottomRight,
                              child: Text(
                                'Forgot your password?',
                                style: GoogleFonts.nunito(
                                    color: cgSecondary,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 16),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 40,
                          ),
                          AuthSubmitButton(
                              ontap: () {
                                if (_login_formKey.currentState!.validate()){
                                   _login_formKey.currentState!.save();
                                authProvider.SignIn(
                                    email: authProvider
                                        .login_email_controller.text,
                                    password: authProvider
                                        .login_password_controller.text,
                                    context: context);
                              }},
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
                                    fontWeight: FontWeight.w700),
                              ),
                              InkWell(
                                splashColor: Colors.transparent,
                                onTap: () => {
                                  Navigator.of(context).push(MaterialPageRoute(builder: (context)=> SignUpScreen())),
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

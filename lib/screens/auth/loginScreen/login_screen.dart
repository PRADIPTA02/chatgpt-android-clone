// ignore_for_file: no_leading_underscores_for_local_identifiers, must_be_immutable

import 'package:chatgpt/screens/auth/common/authButton.dart';
import 'package:chatgpt/screens/auth/common/authOptionDevider.dart';
import 'package:chatgpt/screens/auth/common/authSubmtButton.dart';
import 'package:chatgpt/screens/auth/signUpScreen/signUp_screen.dart';
import 'package:chatgpt/screens/settingsScreen/profile_edit_screen.dart';
import 'package:chatgpt/util/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../../providers/auth_provider.dart';
import '../../homeScreen/home_screen.dart';
import '../forgot_password/forgot_password_screen.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});
  GlobalKey<FormState> _login_formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    FocusNode _focusNode1 = FocusNode();
    FocusNode _focusNode2 = FocusNode();
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    return Consumer<AuthProvider>(
      builder: (context, value, child) => Scaffold(
        backgroundColor: bgColor,
        body: SafeArea(
          child: SingleChildScrollView(
            padding:
                const EdgeInsets.only(left: 8, right: 8, top: 60, bottom: 0),
            reverse: true,
            physics: const BouncingScrollPhysics(
              decelerationRate: ScrollDecelerationRate.fast,
            ),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Wellcome Back!",
                    style: GoogleFonts.nunito(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w700),
                  ),
                  Text(
                    "Please sign in to your account",
                    style: GoogleFonts.nunito(
                        color: Colors.white30,
                        fontSize: 13,
                        fontWeight: FontWeight.w500),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.1,
                  ),
                  Form(
                      key: _login_formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            child: TextFormField(
                              focusNode: _focusNode1,
                              autovalidateMode: AutovalidateMode.onUserInteraction,
                              onFieldSubmitted: (e) =>
                                  {_focusNode2.requestFocus()},
                              controller: authProvider.login_email_controller,
                              cursorColor: cgSecondary,
                              cursorRadius: const Radius.circular(5),
                              keyboardType: TextInputType.emailAddress,
                              style: GoogleFonts.nunito(
                                  color: Colors.white70,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500),
                              validator: (value) {
                                final emailRegex = RegExp(
                                    r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
                                if (!emailRegex.hasMatch(value!) ||
                                    value.isEmpty) {
                                  return 'please enter a valid cradetial';
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                contentPadding: const EdgeInsets.symmetric(
                                    vertical: 15, horizontal: 12),
                                filled: true,
                                fillColor: secondaryColor,
                                hintText: 'Email Address',
                                hintStyle: GoogleFonts.nunito(
                                  color: Colors.white30,
                                  fontWeight: FontWeight.w500,
                                ),
                                errorStyle:
                                    GoogleFonts.nunito(color: Colors.white70),
                                enabledBorder: const OutlineInputBorder(
                                  borderSide:
                                      BorderSide(width: 2, color: cglasscolor),
                                ),
                                focusedBorder: const OutlineInputBorder(
                                  borderSide:
                                      BorderSide(width: 2, color: cgSecondary),
                                ),
                                errorBorder: const OutlineInputBorder(
                                  borderSide:
                                      BorderSide(width: 2, color: errorColor),
                                ),
                                focusedErrorBorder: const OutlineInputBorder(
                                  borderSide:
                                      BorderSide(width: 2, color: errorColor),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                              height:
                                  MediaQuery.of(context).size.height * 0.01),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            child: TextFormField(
                              focusNode: _focusNode2,
                              autovalidateMode: AutovalidateMode.onUserInteraction,
                              keyboardType: TextInputType.emailAddress,
                              controller: authProvider.login_password_controller,
                              cursorColor: cgSecondary,
                              cursorRadius: const Radius.circular(5),
                              style: GoogleFonts.nunito( color: Colors.white70, fontWeight: FontWeight.w500),
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
                                    color: Colors.white60,
                                  ),
                                  hintText: 'Enter your password',
                                  hintStyle: GoogleFonts.nunito(
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
                                    borderSide:
                                        BorderSide(width: 2, color: errorColor),
                                  ),
                                  focusedErrorBorder: const OutlineInputBorder(
                                    borderSide:
                                        BorderSide(width: 2, color: errorColor),
                                  ),
                                  errorStyle: GoogleFonts.nunito(
                                      color: Colors.white70)),
                            ),
                          ),
                          InkWell(
                            // splashColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            splashColor: Colors.transparent,
                            onTap: () => {
                              HapticFeedback.lightImpact(),
                              Navigator.of(context).push(
                                  MaterialPageRoute(
                                      builder: (context) => const ForgotPasswordScreen())),
                            },
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
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.10,
                          ),
                          InkWell(
                            onTap: ()async{
                                HapticFeedback.lightImpact();
                                  if (_login_formKey.currentState!.validate()) {
                                    _login_formKey.currentState!.save();
                                    await authProvider.SignIn(
                                        email: authProvider
                                            .login_email_controller.text,
                                        password: authProvider
                                            .login_password_controller.text,
                                        context: context);
                                        
                                        Navigator.pop(context);
                                  }
                            },
                            child: const AuthSubmitButton(
                                title: "Log in"),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.02,
                          ),
                          const AuthOptionDevider(),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.02,
                          ),
                          InkWell(
                            onTap: () async{
                              HapticFeedback.lightImpact();
                              await authProvider.signInWithGoogle();
                              if(context.mounted){
                                Navigator.of(context).push(
                                    MaterialPageRoute(
                                        builder: (context) =>  ProfileEditScreen(user_data: authProvider.User_Data.values.toList())));
                                }
                            },
                            child: AuthButton(
                                ontap: (){ },
                                buttonIcon: 'assets/images/googleIcon.png'),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.05,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Don't have an account? ",
                                style: GoogleFonts.nunito(
                                    fontSize: 15,
                                    color: Colors.white70,
                                    fontWeight: FontWeight.w500),
                              ),
                              InkWell(
                                splashColor: Colors.transparent,
                                onTap: () => {
                                  HapticFeedback.lightImpact(),
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) => const SignUpScreen())),
                                },
                                child: Text(
                                  "Sign up",
                                  style: GoogleFonts.nunito(
                                      fontSize: 15,
                                      color: cgSecondary,
                                      fontWeight: FontWeight.w600),
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

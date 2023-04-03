import 'package:chatgpt/screens/auth/common/authButton.dart';
import 'package:chatgpt/screens/auth/common/authOptionDevider.dart';
import 'package:chatgpt/screens/auth/common/authSubmtButton.dart';
import 'package:chatgpt/util/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../common/heading.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  String _email = '';
  String _password = '';
  bool showPassword =false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: bgColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(
              decelerationRate: ScrollDecelerationRate.fast,
            ),
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Align(
                      alignment: Alignment.topLeft,
                      child: Heading(title: "Log in")),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.08,
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
                  const SizedBox(
                    height: 15,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      AuthButton(
                          ontap: () => {},
                          buttonIcon:'assets/images/googleIcon.png'),
                      AuthButton(
                          ontap: () => {},
                          buttonIcon: 'assets/images/phoneIcon.png')
                    ],
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  const AuthOptionDevider(),
                  const SizedBox(
                    height: 40,
                  ),
                  Form(
                      key: _formKey,
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
                              cursorColor: cgSecondary,
                              keyboardType: TextInputType.emailAddress,
                              autovalidateMode: AutovalidateMode.onUserInteraction,
                              style: GoogleFonts.nunito(
                                  color: Colors.white70,
                                  fontSize: 18,
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
                              onSaved: (value) {
                                _email = value!;
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
                                    fontSize: 15, fontWeight: FontWeight.bold),
                                enabledBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(width: 2, color: Colors.white30),
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
                          const SizedBox(
                            height: 20,
                          ),
                          Text("Password",
                              style: GoogleFonts.nunito(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16)),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            child: TextFormField(
                              cursorColor: cgSecondary,
                              style: GoogleFonts.nunito(
                                  color: Colors.white70,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w700),
                                  autovalidateMode: AutovalidateMode.onUserInteraction,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter a password';
                                }
                                if (value.length < 6) {
                                  return 'Password must be at least 6 characters';
                                }
                                return null;
                              },
                              onSaved: (value) {
                                _password = value!;
                              },
                              obscureText: !showPassword,
                              decoration:  InputDecoration(
                                  prefixIcon: const Icon(
                                    Icons.lock_outline,
                                    color: Colors.white70,
                                  ),
                                  suffixIcon: IconButton(
                                    splashColor: Colors.transparent,
                                    onPressed: () => {
                                      setState(() => showPassword =!showPassword,)
                                    },
                                    icon :
                                   Icon( showPassword?Icons.visibility_outlined:Icons.visibility_off_outlined),
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
                                    borderSide:
                                        BorderSide(width: 2, color: errorColor),
                                  ),
                                  focusedErrorBorder: const OutlineInputBorder(
                                    borderSide:
                                        BorderSide(width: 2, color: errorColor),
                                  ),
                                  errorStyle: const TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold)),
                            ),
                          ),
                          InkWell(
                            onTap: ()=>{},
                            child: Align(
                              alignment: Alignment.bottomRight,
                              child: Text('Forgot your password?',
                              style: GoogleFonts.nunito(
                                color: cgSecondary,
                                fontWeight: FontWeight.w600,
                                fontSize: 17
                              ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 40,
                          ),
                          AuthSubmitButton(
                              ontap: () => {
                                    if (_formKey.currentState!.validate())
                                      {
                                        _formKey.currentState!.save(),
                                        
                                      }
                                  },
                              title: "Log in"),
                          const SizedBox(
                            height: 100,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Don't have an account? ",
                                style: GoogleFonts.nunito(
                                    fontSize: 17,
                                    color: Colors.white70,
                                    fontWeight: FontWeight.w700),
                              ),
                              Text(
                                "Sign up",
                                style: GoogleFonts.nunito(
                                    fontSize: 17,
                                    color: cgSecondary,
                                    fontWeight: FontWeight.w700),
                              )
                            ],
                          )
                        ],
                      ))
                ]),
          ),
        ),
      ),
    );
  }
}

// ignore_for_file: non_constant_identifier_names, prefer_final_fields, use_build_context_synchronously
import 'package:chatgpt/screens/auth/otp_verification/otp_validation_screen.dart';
import 'package:chatgpt/screens/homescreen/home_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../CommonWidgets/custom_snakebar.dart';
import 'package:animated_snack_bar/animated_snack_bar.dart';

class AuthProvider extends ChangeNotifier {
  bool _isLoading = false;
  bool _showLoginPassword = false;
  String _loginErrorMessage = "";
  String get loginErrorMessage => _loginErrorMessage;
  String _verificationCode = '';
  late UserCredential _userCredential;
  final _login_email_controller = TextEditingController();
  final _signup_username_controller = TextEditingController();
  final _login_password_controller = TextEditingController();
  final _signup_email_controller = TextEditingController();
  final _signup_password_controller = TextEditingController();
  final _forgot_password_email_controller = TextEditingController();
  bool get isLoading => _isLoading;
  String get verificationCode => _verificationCode;
  bool get showLoginPassword => _showLoginPassword;
  UserCredential get CurrentUserCredential => _userCredential;
  TextEditingController get login_email_controller => _login_email_controller;
  TextEditingController get login_password_controller =>
      _login_password_controller;
  TextEditingController get signup_username_controller =>
      _signup_username_controller;
  TextEditingController get signup_email_controller => _signup_email_controller;
  TextEditingController get forgot_password_email_controller =>
      _forgot_password_email_controller;
  TextEditingController get signup_password_controller =>
      _signup_password_controller;
  final emailRegex = RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
  final phoneRegex = RegExp(
      r'^\s*(?:\+?(\d{1,3}))?[-. (]*(\d{3})[-. )]*(\d{3})[-. ]*(\d{4})(?: *x(\d+))?\s*$');

  void changeIsLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  void changeLoginPasswordVisibility() {
    _showLoginPassword = !_showLoginPassword;
    notifyListeners();
  }

  void setVerificationCode(String code) {
    _verificationCode = code;
    notifyListeners();
  }

  void changeLoginErrorMessage(String value) {
    _loginErrorMessage = value;
    notifyListeners();
  }

  void SignOut() async {
    _isLoading = true;
    await FirebaseAuth.instance.signOut();
    _isLoading = false;
    notifyListeners();
  }

  void SignIn(
      {required String address,
      required String password,
      required BuildContext context}) async {
    changeIsLoading(true);
    if (emailRegex.hasMatch(address)) {
      try {
        final userCredential = await FirebaseAuth.instance
            .signInWithEmailAndPassword(email: address, password: password);
        _userCredential = userCredential;
        CustomSnackeBar.show(
            context: context,
            message: 'Welcome! You have successfully logged in',
            status: Status.success);
        changeIsLoading(false);
        _login_email_controller.text = "";
        _login_password_controller.text = "";
      } on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found') {
          CustomSnackeBar.show(
              context: context,
              message:
                  'Error: The username or password you entered is incorrect. ',
              status: Status.warning);
          changeIsLoading(false);
        } else if (e.code == 'wrong-password') {
          CustomSnackeBar.show(
              context: context,
              message:
                  'Error: The username or password you entered is incorrect. ',
              status: Status.warning);
          changeIsLoading(false);
        } else {
          CustomSnackeBar.show(
              context: context,
              message:
                  'Warning: You have exceeded the maximum number of login attempts',
              status: Status.error);
          changeIsLoading(false);
        }
      }
    } else {
      String phNumber =
          address.toString().length == 10 ? '+91 $address' : address;
      await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: phNumber.toString(),
        verificationCompleted: (PhoneAuthCredential credential) {
          Navigator.pop(context);
        },
        verificationFailed: (FirebaseAuthException e) {
          if (e.code == 'invalid-phone-number') {}
        },
        codeSent: (String verificationId, int? resendToken) {
          changeIsLoading(false);
          _login_email_controller.text = "";
          _login_password_controller.text = "";
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => OtpValidationScreen(
                      address: phNumber, verificationId: verificationId)));
        },
        codeAutoRetrievalTimeout: (String verificationId) {},
      );
    }
    // changeIsLoading(false);

    notifyListeners();
  }

  void verify_otp(
      String verificationId, String otp, BuildContext context) async {
    changeIsLoading(true);
    await FirebaseAuth.instance.signInWithCredential(
        PhoneAuthProvider.credential(
            verificationId: verificationId, smsCode: otp));
    Navigator.pop(
        context, MaterialPageRoute(builder: (context) => const HomeScreen()));
    changeIsLoading(false);
    notifyListeners();
  }

//function to add user into firebase firestore database
  Future adduserDetails(
      {required String userEmail,
      String userID = "",
      required String userName,
      required String userPassword,
      int userPhone = 0,
      required String? userUID}) async {
    var user = await FirebaseFirestore.instance.collection('users').add({
      'created_at': FieldValue.serverTimestamp(),
      'user_email': userEmail,
      'user_id': userID,
      'user_login_date' : FieldValue.serverTimestamp(),
      'user_name': userName,
      'user_password': userPassword,
      'user_uid': userUID,
      'user_phone': userPhone
    });
    return user.id;
  }

  void SignUp(
      {required String username,
      required String email,
      required String password,
      required BuildContext context}) async {
    _isLoading = true;
    try {
      final user = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      final userInDatabase = await adduserDetails(
          userEmail: email,
          userName: username,
          userPassword: password,
          userUID: user.user?.uid,
          );
      await FirebaseFirestore.instance.collection('users').doc(userInDatabase).update({
        'user_id' : userInDatabase,
      });
      changeIsLoading(false);
      _signup_username_controller.text = "";
      _signup_email_controller.text = "";
      _signup_password_controller.text = "";
      Navigator.pop(
          context, MaterialPageRoute(builder: (context) => const HomeScreen()));
    } catch (e) {
      _signup_username_controller.text = "";
      _signup_email_controller.text = "";
      _signup_password_controller.text = "";
      print(e);
      changeIsLoading(false);
    }
  }
}

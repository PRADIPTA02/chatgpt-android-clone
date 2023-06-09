// ignore_for_file: non_constant_identifier_names, prefer_final_fields, use_build_context_synchronously
import 'package:chatgpt/screens/auth/otp_verification/otp_validation_screen.dart';
import 'package:chatgpt/screens/homescreen/home_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../CommonWidgets/custom_snakebar.dart';

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
  String _chat_model = "text-davinci-003";
  String _app_language = "English";
  String get App_language => _app_language;
  bool _isExpanded = false;
  bool get IsExpanded => _isExpanded;
  //ai advance settings
  //***********************************************************************************************************//
  bool _is_advance_mode_on = false;
  bool get IsAdvanceModeOn => _is_advance_mode_on;
  double _temperature = 0;
  int _maximum_length = 0;
  double _top_p = 0;
  double _frequency_penalty = 0;
  double _presence_penalty = 0;
  int _best_of = 1;
  double get Temperature => _temperature;
  int get Maximum_length => _maximum_length;
  double get Top_P => _top_p;
  double get Frequency_penalty => _frequency_penalty;
  double get Presence_penalty => _presence_penalty;
  int get Best_of => _best_of;
  //***********************************************************************************************************//
  String get Chat_model => _chat_model;
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
  void changeTemperature(double value) {
    if (_is_advance_mode_on) {
      _temperature = value;
    }
    notifyListeners();
  }

  void change_maximum_length(double value) {
    if (_is_advance_mode_on) {
      _maximum_length = value.round ();
    }
    notifyListeners();
  }

  void changeTop_P(double value) {
    if(_is_advance_mode_on){
      _top_p = value;
    }
    notifyListeners();
  }

  void changeIsAdvanceModeONOF(bool value) {
    _is_advance_mode_on = value;
    notifyListeners();
  }

  void changeFrequency_penalty(double value) {
    if(_is_advance_mode_on){
    _frequency_penalty = value;
    }
    notifyListeners();
  }

  void changePresence_penalty(double value) {
    if(_is_advance_mode_on){
    _presence_penalty = value;
    }
    notifyListeners();
  }

  void changeBest_of(double value) {
    if(_is_advance_mode_on){
    _best_of = value.round();
    }
    notifyListeners();
  }

  void changeIsLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  void changeLoginPasswordVisibility() {
    _showLoginPassword = !_showLoginPassword;
    notifyListeners();
  }

  void changeChatModel(String model) {
    _chat_model = model;
    notifyListeners();
  }

  void changeLanguage(String language) {
    _app_language = language;
    notifyListeners();
  }

  void changeIsExpanded(bool value) {
    _isExpanded = value;
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
      'user_login_date': FieldValue.serverTimestamp(),
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
      await FirebaseFirestore.instance
          .collection('users')
          .doc(userInDatabase)
          .update({
        'user_id': userInDatabase,
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

// ignore_for_file: non_constant_identifier_names, prefer_final_fields
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
  late UserCredential _userCredential;
  final _login_email_controller = TextEditingController();
  final _signup_username_controller = TextEditingController();
  final _login_password_controller = TextEditingController();
  final _signup_email_controller = TextEditingController();
  final _signup_password_controller = TextEditingController();
  bool get isLoading => _isLoading;
  bool get showLoginPassword => _showLoginPassword;
  UserCredential get CurrentUserCredential => _userCredential;
  TextEditingController get login_email_controller => _login_email_controller;
  TextEditingController get login_password_controller =>
      _login_password_controller;
  TextEditingController get signup_username_controller =>
      _signup_username_controller;
  TextEditingController get signup_email_controller => _signup_email_controller;
  TextEditingController get signup_password_controller =>
      _signup_password_controller;
  RegExp get emailRegex => RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
  RegExp get phoneNumberRegex => RegExp(r'^\s*(?:\+?(\d{1,3}))?[-. (]*(\d{3})[-. )]*(\d{3})[-. ]*(\d{4})(?: *x(\d+))?\s*$');

  void changeIsLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  void changeLoginPasswordVisibility() {
    _showLoginPassword = !_showLoginPassword;
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
      {required String email,
      required String password,
      required BuildContext context}) async {
    changeIsLoading(true);
    try {
      final userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      _userCredential = userCredential;
      _login_email_controller.text = "";
      _login_password_controller.text = "";
      CustomSnackeBar.show(
          context: context,
          message: 'Welcome! You have successfully logged in',
          status: Status.success);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        CustomSnackeBar.show(
            context: context,
            message:
                'Error: The username or password you entered is incorrect. ',
            status: Status.warning);
      } else if (e.code == 'wrong-password') {
        CustomSnackeBar.show(
            context: context,
            message:
                'Error: The username or password you entered is incorrect. ',
            status: Status.warning);
      } else {
        CustomSnackeBar.show(
            context: context,
            message:
                'Warning: You have exceeded the maximum number of login attempts',
            status: Status.error);
      }
    }
    changeIsLoading(false);
    notifyListeners();
  }

  String phoneAndEmailvalidator(String ?value){
    if(emailRegex.hasMatch(value!)||phoneNumberRegex.hasMatch(value)){
      print(value);
    }
    return 'please enter valid cradential';
  }

  void SignUp(
      {required String username,
      required String email,
      required String password,
      required BuildContext context}) {
    var obj = {"user": username, "userEmail": email, "password": password};
    print(obj.toString());
  }
}

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
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final _login_email_controller = TextEditingController();
  final _login_password_controller = TextEditingController();
  bool get isLoading => _isLoading;
  bool get showLoginPassword => _showLoginPassword;
  UserCredential get CurrentUserCredential => _userCredential;
  GlobalKey<FormState> get fromKey => _formKey;
  TextEditingController get login_email_controller => _login_email_controller;
  TextEditingController get login_password_controller =>
      _login_password_controller;

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
    if (_formKey.currentState!.validate()) {
      changeIsLoading(true);

      _formKey.currentState!.save();
      try {
        final userCredential = await FirebaseAuth.instance
            .signInWithEmailAndPassword(email: email, password: password);
        _userCredential = userCredential;
        _login_email_controller.text = "";
        _login_password_controller.text = "";
              CustomSnackeBar.show(
              context: context,
              message:  'Welcome! You have successfully logged in',
              status: Status.success);
      } on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found') {
          CustomSnackeBar.show(
              context: context,
              message: 'Error: The username or password you entered is incorrect. ',
              status: Status.warning);
        } else if (e.code == 'wrong-password') {
          CustomSnackeBar.show(
              context: context,
              message:'Error: The username or password you entered is incorrect. ',
              status: Status.warning);
        } else {
          CustomSnackeBar.show(
              context: context,
              message:  'Warning: You have exceeded the maximum number of login attempts',
              status: Status.error);
        }
      }
      changeIsLoading(false);
      notifyListeners();
    }
  }
}

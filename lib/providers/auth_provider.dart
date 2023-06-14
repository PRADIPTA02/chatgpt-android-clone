// ignore_for_file: non_constant_identifier_names, use_build_context_synchronously

import 'package:chatgpt/models/user_data_model.dart';
import 'package:chatgpt/screens/auth/otp_verification/otp_validation_screen.dart';
import 'package:chatgpt/screens/homescreen/home_screen.dart';
import 'package:chatgpt/screens/settingsScreen/profile_edit_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import '../CommonWidgets/custom_snakebar.dart';

class AuthProvider extends ChangeNotifier {
  late Box<UserData> User_data;
  AuthProvider() {
    User_data = Hive.box('userData');
    if (User_data.values.toList().isNotEmpty) {
      final user = User_data.values.toList()[0];
      _temperature = user.Temperature;
      _maximum_length = user.Maximum_length;
      _top_p = user.Top_p;
      _frequency_penalty = user.Frequency_penalty;
      _presence_penalty = user.Presence_penalty;
      _best_of = user.Best_of;
      _chat_model = user.Model;
      _app_language = user.Language;
      _user_image = user.Profile_image;
      _user_gender = user.Gender;
      _user_age = user.Age;
      _user_email = user.Email_id;
      _user_phone_number = user.Phone_number;
      _primary_address = user.primary_address;
      _user_form_filled = user.database_updated;
      _user_name = user.Display_name;
      _first_name = user.Firstname;
      _last_name = user.Lastname;
      _user_dob = user.Birthday;
    }
  }
  final List<String>_avater_images =[
    "assets/images/avater_1.png",
    "assets/images/avater_2.png",
    "assets/images/avater_3.png",
    "assets/images/avater_4.png",
    "assets/images/avater_5.png",
    "assets/images/avater_6.png",
    "assets/images/avater_7.png",
    "assets/images/avater_8.png",
    "assets/images/avater_9.png",
    "assets/images/avater_10.png",
    "assets/images/avater_11.png",
    "assets/images/avater_12.png",
    "assets/images/avater_13.png",
    "assets/images/avater_14.png",
    "assets/images/avater_15.png",
  ];
  List<String> get Avater_images => _avater_images;
  bool _isLoading = false;
  String _primary_address = "";
  String get primary_address => _primary_address;
  bool _showLoginPassword = false;
  String _loginErrorMessage = "";
  String get loginErrorMessage => _loginErrorMessage;
  String _verificationCode = '';
  String _user_image = "";
  String _user_gender = "";
  String _user_email = "";
  String _user_name = "";
  String _first_name = "";
  String _last_name = "";

  String get fast_name => _first_name;
  String get last_name => _last_name;
  String get user_name => _user_name;
  String get user_email => _user_email;
  String get user_gender => _user_gender;
  String get User_image => _user_image;
  DateTime _user_dob = DateTime.now();
  DateTime get user_dob => _user_dob;
  String _user_age = "";
  String get user_age => _user_age;
  String _user_phone_number = "";
  bool _user_form_filled = false;
  bool get User_form_filled => _user_form_filled;
  String get user_phone_number => _user_phone_number;
  late UserCredential _userCredential;
  final _login_email_controller = TextEditingController();
  Box<UserData> get User_Data => User_data;
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
      _maximum_length = value.round();
    }
    notifyListeners();
  }

  void changeTop_P(double value) {
    if (_is_advance_mode_on) {
      _top_p = value;
    }
    notifyListeners();
  }

  void changeIsAdvanceModeONOF(bool value) {
    _is_advance_mode_on = value;
    notifyListeners();
  }

  void changeFrequency_penalty(double value) {
    if (_is_advance_mode_on) {
      _frequency_penalty = value;
    }
    notifyListeners();
  }

  void changePresence_penalty(double value) {
    if (_is_advance_mode_on) {
      _presence_penalty = value;
    }
    notifyListeners();
  }

  void changeBest_of(double value) {
    if (_is_advance_mode_on) {
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
    await deleteUserLocaly();
    _isLoading = false;
    notifyListeners();
  }

  Future<void> userDataAddDuringSignin(
      {required String? uid, required String emailOrPhone}) async {
    try {
      final QuerySnapshot<Map<String, dynamic>> snapshot =
          await FirebaseFirestore.instance
              .collection('users')
              .where('user_uid', isEqualTo: uid)
              .limit(1)
              .get();
      if (snapshot.docs.isNotEmpty) {
        await userDetailsAddLocaly(
            id: snapshot.docs.toList()[0]['user_id'],
            uid: snapshot.docs.toList()[0]['user_uid'],
            user_password: snapshot.docs.toList()[0]['user_password'],
            display_name: snapshot.docs.toList()[0]['user_name'],
            address: emailRegex.hasMatch(emailOrPhone)
                ? snapshot.docs.toList()[0]['user_email']
                : snapshot.docs.toList()[0]['user_phone']);
        await aiModelUpdate();
        await userLoginTimeUpdate(id: snapshot.docs.toList()[0]['user_id']);
        await userDetailesUpdateFromFirebaseToLocal(
            user_id: snapshot.docs.toList()[0]['user_id']);
      } else {
        throw Exception('User not found');
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

//////////////////////////////////////////@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@/////////////////////////////////////
  Future<void> SignIn(
      {required String address,
      required String password,
      required BuildContext context}) async {
    changeIsLoading(true);

    if (emailRegex.hasMatch(address)) {
      try {
        final userCredential = await FirebaseAuth.instance
            .signInWithEmailAndPassword(email: address, password: password);
        _primary_address = "email";
        _user_email = address;
        _userCredential = userCredential;
        // CustomSnackeBar.show(
        //     context: context,
        //     message: 'Welcome! You have successfully logged in',
        //     status: Status.success);
        await userDataAddDuringSignin(
            uid: userCredential.user?.uid, emailOrPhone: address);
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
          _primary_address = "phone";
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

  Future<void> aiModelUpdate() async {
    if (User_data.values.toList().isNotEmpty) {
      final user = User_data.values.toList()[0];
      _temperature = user.Temperature;
      _maximum_length = user.Maximum_length;
      _top_p = user.Top_p;
      _frequency_penalty = user.Frequency_penalty;
      _presence_penalty = user.Presence_penalty;
      _best_of = user.Best_of;
      _chat_model = user.Model;
      _app_language = user.Language;
    }
    notifyListeners();
  }

  Future<void> uerFormFillUpUpdate() async {
    if (User_data.values.toList().isNotEmpty) {
      final user = User_data.values.toList()[0];
      debugPrint(user.database_updated.toString());
      if (user.database_updated == true) {
        _user_form_filled = true;
      } else {
        _user_form_filled = false;
      }
    }
    notifyListeners();
  }

////////////////////////////////////////////////@@@@@@@@@@  @@@@@@@@@@@@@@@  @@@@@@@@@@@@@@//////////////////////////////////////////////////////////
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
      _user_email = email;
      await userLoginTimeUpdate(id: userInDatabase);
      await FirebaseFirestore.instance
          .collection('users')
          .doc(userInDatabase)
          .update({
        'user_id': userInDatabase,
      });
      await userDetailsAddLocaly(
          id: userInDatabase,
          uid: user.user?.uid,
          user_password: password,
          display_name: username,
          address: email);
      await aiModelUpdate();
      changeIsLoading(false);
      _signup_username_controller.text = "";
      _signup_email_controller.text = "";
      _signup_password_controller.text = "";
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => ProfileEditScreen(
                    user_data: User_data.values.toList(),
                  )));
    } catch (e) {
      _signup_username_controller.text = "";
      _signup_email_controller.text = "";
      _signup_password_controller.text = "";
      changeIsLoading(false);
    }
  }

  Future<void> deleteUserLocaly() async {
    if (User_data.values.toList().isNotEmpty) {
      User_data.values.toList()[0].delete();
    }
    notifyListeners();
  }

  Future<void> userLoginTimeUpdate({required String id}) async {
    await FirebaseFirestore.instance.collection('users').doc(id).update({
      'user_login_date': FieldValue.serverTimestamp(),
    });
    notifyListeners();
  }

  Future<void> userDetailesUpdateFromFirebaseToLocal(
      {required String user_id}) async {
    final user = User_data.values.toList()[0];
    await FirebaseFirestore.instance
        .collection('users')
        .doc(user_id)
        .get()
        .then((value) async {
      user.Firstname = value['user_firstname'];
      user.Lastname = value['user_lastname'];
      user.Age = value['user_age'];
      user.Email_id = value['user_email'];
      user.Phone_number = value['user_phone'];
      user.Password = value['user_password'];
      user.Gender = value['user_gender'];
      user.Birthday = value['user_dob'].toDate();
      user.Country = value['user_country'];
      user.database_updated = true;
      user.Profile_image = value['user_image_path'];
      _user_form_filled = true;
      _first_name = value['user_firstname'];
      _last_name = value['user_lastname'];
      _user_age = value['user_age'];
      _user_image = value['user_image_path'];
      _user_dob = value['user_dob'].toDate();
    });
    await user.save();
    notifyListeners();
  }

  Future<void> advanceSettingsValus() async{
    changeIsLoading(true);
    if(User_data.values.toList().isNotEmpty){
      final user = User_data.values.toList()[0];
      user.Temperature = _temperature;
      user.Maximum_length = _maximum_length;
      user.Top_p = _top_p;
      user.Frequency_penalty = _frequency_penalty;
      user.Presence_penalty = _presence_penalty;
      user.Best_of = _best_of;
      user.Model = _chat_model;
      user.Language = _app_language;
      user.save();
    }
    changeIsLoading(false);
    notifyListeners();
  }
  ////////////////////////@ chakig the user form data during signup updated or not in localy or in firebase @///////////////////////
  Future<void> userDetailsUpdateInFirebase(
      {First_name,
      Last_name,
      User_age,
      User_dob,
      User_email,
      User_phone_number,
      User_gender,
      User_country,
      User_image_path}) async {
    if (User_data.values.toList().isNotEmpty) {
      final user = User_data.values.toList()[0];
      await FirebaseFirestore.instance
          .collection('users')
          .doc(user.User_id)
          .update({
        'user_firstname': First_name,
        'user_lastname': Last_name,
        'user_age': User_age,
        'user_dob': User_dob,
        'user_email': User_email,
        'user_phone': User_phone_number,
        'user_gender': User_gender,
        'user_country': User_country,
        'user_image_path': User_image_path
      });
    }
  }

  Future<void> userDetailsAddLocaly(
      {required String id,
      required String? uid,
      required String user_password,
      required String display_name,
      required String address}) async {
    final UserData user = UserData(
        User_id: id,
        User_uid: uid!,
        Display_name: display_name,
        primary_address: "email");
    if (User_data.values.toList().isEmpty) {
      await User_data.add(user);
      user.Email_id = address;
      user.Password = user_password;
      user.save();
      _user_name = display_name;
    }
    notifyListeners();
  }

  Future<void> userDetailsUpdateLocaly(
      {first_name,
      last_name,
      user_age,
      user_dob,
      user_email,
      user_phone_number,
      user_gender,
      user_country,
      user_image_path}) async {
    final user = User_data.values.toList()[0];
    if (User_data.values.toList().isNotEmpty) {
      user.Firstname = first_name;
      user.Lastname = last_name;
      user.Age = user_age;
      user.Email_id = user_email;
      user.Phone_number = user_phone_number;
      user.Gender = user_gender;
      user.Birthday = user_dob;
      user.Country = user_country;
      user.Profile_image = user_image_path;
      user.database_updated = true;
      _user_image = user_image_path;

      /// **********************@@************change notice
    }
    user.save();
    _user_form_filled = true;
    await userDetailsUpdateInFirebase(
      First_name: first_name,
      Last_name: last_name,
      User_age: user_age,
      User_dob: user_dob,
      User_email: user_email,
      User_country: user_country,
      User_gender: user_gender,
      User_phone_number: user_phone_number,
      User_image_path: user_image_path,
    );

    notifyListeners();
  }

  Future<void> profileEditForm(
      {required String firstname,
      required String lastname,
      required String email_id,
      required String gender,
      required DateTime dob,
      required String age,
      required String country,
      required String? img_path,
      required String phone_number,
      required BuildContext context}) async {
    if (User_data.values.toList().isNotEmpty) {
      changeIsLoading(true);
      debugPrint(
          "$firstname,$lastname,$email_id,$gender,$dob,$age,$country,$img_path");
      final user = User_data.values.toList()[0];
      user.Firstname = firstname;
      user.Lastname = lastname;
      user.Email_id = email_id;
      user.Gender = gender;
      user.Birthday = dob;
      user.Age = age;
      user.Country = country;
      user.Profile_image = img_path!;
      user.Phone_number = phone_number;
      user.database_updated = true;
      user.save();
      _user_form_filled = true;
      _user_image = img_path;
      _user_age = age;
      _first_name = firstname;
      _last_name = lastname;
      _user_phone_number = phone_number;
      _user_dob = dob;
    }
    await userDetailsUpdateInFirebase(
      First_name: firstname,
      Last_name: lastname,
      User_age: age,
      User_dob: dob,
      User_email: email_id,
      User_country: country,
      User_gender: gender,
      User_phone_number: user_phone_number,
      User_image_path: img_path,
    );
    changeIsLoading(false);

    notifyListeners();
  }

  Future<void> aiDetailsUpdateLocaly({
    ai_Temperature,
    ai_Maximum_length,
    ai_Top_p,
    ai_Frequency_penalty,
    ai_Presence_penalty,
    ai_Best_of,
  }) async {
    final user = User_data.values.toList()[0];
    if (User_data.values.toList().isNotEmpty) {
      user.Temperature = ai_Temperature;
      user.Maximum_length = ai_Maximum_length;
      user.Top_p = ai_Top_p;
      user.Frequency_penalty = ai_Frequency_penalty;
      user.Presence_penalty = ai_Presence_penalty;
      user.Best_of = ai_Best_of;
    }
    user.save();
    notifyListeners();
  }

  Future<void> imageLayoutUpdate({required String image_layout}) async {
    final user = User_data.values.toList()[0];
    if (User_data.values.toList().isNotEmpty) {
      user.Image_show_layout = image_layout;
    }
    user.save();
    notifyListeners();
  }

  Future<void> imageSizeUpdate(
      {required String image_size, required int num}) async {
    final user = User_data.values.toList()[0];
    if (User_data.values.toList().isNotEmpty) {
      user.Image_size = image_size;
      user.Number_of_images = num;
    }
    user.save();
    notifyListeners();
  }

  Future<void> aiModelUpdatesingle({required String ai_model}) async {
    final user = User_data.values.toList()[0];
    if (User_data.values.toList().isNotEmpty) {
      user.Model = ai_model;
    }
    user.save();
    notifyListeners();
  }

  Future<void> userLanguageUpdate({required String user_language}) async {
    final user = User_data.values.toList()[0];
    if (User_data.values.toList().isNotEmpty) {
      user.Language = user_language;
    }
    user.save();
    notifyListeners();
  }

  void changeProfileImage(String? img) {
    if (User_data.values.toList().isNotEmpty) {
      User_data.values.toList()[0].Profile_image = img!;
      User_data.values.toList()[0].save();
    }
    _user_image = img!;
    print(_user_image);
    notifyListeners();
  }

  void changeUserGender(String gender) {
    if (User_data.values.toList().isNotEmpty) {
      User_data.values.toList()[0].Gender = gender;
      User_data.values.toList()[0].save();
    }
    _user_gender = gender;
    notifyListeners();
  }
}

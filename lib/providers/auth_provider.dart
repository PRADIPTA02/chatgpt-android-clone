// ignore_for_file: non_constant_identifier_names, use_build_context_synchronously
import 'dart:math';

import 'package:chatgpt/models/user_data_model.dart';
import 'package:chatgpt/screens/settingsScreen/profile_edit_screen.dart';
import 'package:chatgpt/util/constants/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hive/hive.dart';
import 'package:google_sign_in/google_sign_in.dart';

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
      _user_email = user.Email_id;
      _user_phone_number = user.Phone_number;
      _first_name = user.Firstname;
      _last_name = user.Lastname;
      _user_dob = user.Birthday;
      _user_country = user.Country;
    }
  }
  //box data
    Box<UserData> get User_Data => User_data;

  //avater images(all images)

  final List<String> _avater_images = [
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
final List<String> countries = [
      'Select Country',
    'Afghanistan',
    'Albania',
    'Algeria',
    'Andorra',
    'Angola',
    'Argentina',
    'Armenia',
    'Australia',
    'Austria',
    'Azerbaijan',
    'Bahamas',
    'Bahrain',
    'Bangladesh',
    'Barbados',
    'Belarus',
    'Belgium',
    'Belize',
    'Benin',
    'Bhutan',
    'Bolivia',
    'Botswana',
    'Brazil',
    'Brunei',
    'Bulgaria',
    'Burkina Faso',
    'Burundi',
    'Cabo Verde',
    'Cambodia',
    'Cameroon',
    'Canada',
    'Chad',
    'Chile',
    'China',
    'Colombia',
    'Comoros',
    'Congo',
    'Costa Rica',
    'Croatia',
    'Cuba',
    'Cyprus',
    'Czech Republic',
    'Denmark',
    'Djibouti',
    'Dominica',
    'East Timor',
    'Ecuador',
    'Egypt',
    'El Salvador',
    'Eritrea',
    'Estonia',
    'Eswatini',
    'Ethiopia',
    'Fiji',
    'Finland',
    'France',
    'Gabon',
    'Gambia',
    'Georgia',
    'Germany',
    'Ghana',
    'Greece',
    'Grenada',
    'Guatemala',
    'Guinea',
    'Guinea-Bissau',
    'Guyana',
    'Haiti',
    'Honduras',
    'Hungary',
    'Iceland',
    'India',
    'Indonesia',
    'Iran',
    'Iraq',
    'Ireland',
    'Israel',
    'Italy',
    'Jamaica',
    'Japan',
    'Jordan',
    'Kazakhstan',
    'Kenya',
    'Kiribati',
    'Korea, North',
    'Korea, South',
    'Kosovo',
    'Kuwait',
    'Kyrgyzstan',
    'Laos',
    'Latvia',
    'Lebanon',
    'Lesotho',
    'Liberia',
    'Libya',
    'Lithuania',
    'Luxembourg',
    'Madagascar',
    'Malawi',
    'Malaysia',
    'Maldives',
    'Mali',
    'Malta',
    'Mauritania',
    'Mauritius',
    'Mexico',
    'Micronesia',
    'Moldova',
    'Monaco',
    'Mongolia',
    'Montenegro',
    'Morocco',
    'Mozambique',
    'Myanmar',
    'Namibia',
    'Nauru',
    'Nepal',
    'Netherlands',
    'New Zealand',
    'Nicaragua',
    'Niger',
    'Nigeria',
    'North Macedonia',
    'Norway',
    'Oman',
    'Pakistan',
    'Palau',
    'Palestine',
    'Panama',
    'Papua New Guinea',
    'Paraguay',
    'Peru',
    'Philippines',
    'Poland',
    'Portugal',
    'Qatar',
    'Romania',
    'Russia',
    'Rwanda',
    'Samoa',
    'San Marino',
    'Saudi Arabia',
    'Senegal',
    'Serbia',
    'Seychelles',
    'Sierra Leone',
    'Singapore',
    'Slovakia',
    'Slovenia',
    'Solomon Islands',
    'Somalia',
    'South Africa',
    'South Sudan',
    'Spain',
    'Sri Lanka',
    'Sudan',
    'Suriname',
    'Sweden',
    'Switzerland',
    'Syria',
    'Taiwan',
    'Tajikistan',
    'Tanzania',
    'Thailand',
    'Togo',
    'Tonga',
    'Tunisia',
    'Turkey',
    'Turkmenistan',
    'Tuvalu',
    'Uganda',
    'Ukraine',
    'United Kingdom',
    'United States',
    'Uruguay',
    'Uzbekistan',
    'Vanuatu',
    'Vatican City',
    'Venezuela',
    'Vietnam',
    'Yemen',
    'Zambia',
    'Zimbabwe'
];

  List<String> get Avater_images => _avater_images;

  //User related data (variable)

  String    _first_name        =   "";
  String    _last_name         =   "";
  String?    _user_email        =   "";
  DateTime  _user_dob          =   DateTime.now();
  String    _user_phone_number =   "";
  String    _user_country      =   "";
  String    _user_gender       =   "";
  String    _user_image        =   "";

//User related data (getter)

  String    get fast_name         =>   _first_name;
  String    get last_name         =>   _last_name;
  String?   get user_email       =>   _user_email;
  DateTime  get user_dob          =>   _user_dob;
  String    get user_phone_number =>   _user_phone_number;
  String    get user_country      =>   _user_country;
  String    get user_gender       =>   _user_gender;
  String    get User_image        =>   _user_image;

  //all loadings (variable)

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  //all login controllers (variable)

  bool  _showLoginPassword         =  false;
  final _login_email_controller    =  TextEditingController();
  final _login_password_controller =  TextEditingController();

  //all login controllers (getter)

  bool                  get showLoginPassword         =>  _showLoginPassword;
  TextEditingController get login_email_controller    =>  _login_email_controller;
  TextEditingController get login_password_controller =>  _login_password_controller;


  //forget password controllers (variable)

  final _forgot_password_email_controller = TextEditingController();

  //forget password controllers (getter)

  TextEditingController get forgot_password_email_controller =>_forgot_password_email_controller;

  //ai model related data (variable)

  bool   _is_advance_mode_on  =     false;
  String _chat_model          =     "text-davinci-003";
  String _app_language        =     "English";
  double _temperature         =     0;
  int    _maximum_length      =     0;
  double _top_p               =     0;
  double _frequency_penalty   =     0;
  double _presence_penalty    =     0;
  int    _best_of             =     1;

//ai model related data (getter)

  bool   get IsAdvanceModeOn    =>  _is_advance_mode_on;
  String get Chat_model         =>  _chat_model;
  String get App_language       =>  _app_language;
  double get Temperature        =>  _temperature;
  int    get Maximum_length     =>  _maximum_length;
  double get Top_P              =>  _top_p;
  double get Frequency_penalty  =>  _frequency_penalty;
  double get Presence_penalty   =>  _presence_penalty;
  int    get Best_of            =>  _best_of;

  //all user Firebase (variable)
  String              _verificationCode = '';
  late UserCredential _userCredential;


  //all user Firebase (getter)

  String         get verificationCode       => _verificationCode;
  UserCredential get CurrentUserCredential  => _userCredential;

  //miscellaneous (variable)

  bool                    _isExpanded = false;
  bool get IsExpanded  => _isExpanded;
  bool                    _isGoogleSingInRunning = false;
  bool get isGoogleSingInRunning  => _isGoogleSingInRunning;

//email and phone number regex

  final emailRegex = RegExp (r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
  final phoneRegex = RegExp (r'^\s*(?:\+?(\d{1,3}))?[-. (]*(\d{3})[-. )]*(\d{3})[-. ]*(\d{4})(?: *x(\d+))?\s*$');

//all modifires methods

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

  void changeIsAdvanceModeONOF(bool value) {
      _is_advance_mode_on = value;
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

    String giveRandomavater() {
    final random = Random();
    final randomIndex = random.nextInt(_avater_images.length);
    final randomString = _avater_images[randomIndex];
    return randomString;
  }

  void SignOut() async {
    _isLoading = true;
    await FirebaseAuth.instance.signOut();
    await deleteUserLocaly();
    _isLoading = false;
    notifyListeners();
  }
  Future<void> deleteUserLocaly() async {
    if (User_data.values.toList().isNotEmpty) {
      User_data.values.toList()[0].delete();
    }
    notifyListeners();
  }
  //////////////////////////////////////////////////////////////// SIGNIN WITH GOOGLE ////////////////////////////////////////////////////////////
  
  Future<void> signInWithGoogle() async{
    UserCredential? user;
    try{
          changeIsLoading(true);
          final GoogleSignInAccount? googleUser         = await GoogleSignIn().signIn();
          final GoogleSignInAuthentication? googleAuth  =  await googleUser?.authentication;
          final credential = GoogleAuthProvider.credential( accessToken: googleAuth?.accessToken, idToken: googleAuth?.idToken,);
          user =  await FirebaseAuth.instance.signInWithCredential(credential);
          if(user.additionalUserInfo!.isNewUser){
            _isGoogleSingInRunning = true;
            var tempUser = await FirebaseFirestore.instance.collection('users').add({
              'created_at': DateTime.now(),
              'user_email': user.user!.email,
              'user_firstname': user.user!.displayName!.split(' ')[0],
              'user_lastname': user.user!.displayName!.split(' ')[1],
              'user_uid':     user.user!.uid,
              'user_login_date': DateTime.now(),
              'user_name': user.user!.displayName,
            });
              await createUserLocaly(
                    user_id :tempUser.id,
                    user_uid:user.user!.uid,
                    firstname:user.user!.displayName!.split(' ')[0],
                    lastname:user.user!.displayName!.split(' ')[1],
                    email_id:user.user!.email,
                    password:"password",
                    birthday:DateTime.now(), 
                    country:'Select Country', 
                    profile_image:giveRandomavater(),
                    gender:'Gender');
            changeIsLoading(false);
            notifyListeners();
          }

    }catch(e){
      Fluttertoast.showToast(
        msg: "Error: $e",
        textColor: Colors.white,
        backgroundColor: errorColor,
        gravity: ToastGravity.TOP,
      );
    }
  }

  ///////////////////////////////////////////////////// SIGN IN WITH EMAIL AND PASSWORD //////////////////////////////////////////////////////////
    Future<void> SignIn({
      required String email,
      required String password,
      required BuildContext context
      }) async {
      changeIsLoading(true);
      try {
        final user = await  FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
        await loadUserDataLocalyFromFirebase(uid: user.user!.uid);
        changeIsLoading(false);
        _login_email_controller.text = "";
        _login_password_controller.text = "";
      } on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found') {
          Fluttertoast.showToast(
              msg:
                  'Error: The username or password you entered is incorrect. ',
                  textColor: Colors.white,
                  backgroundColor: errorColor,
                  gravity: ToastGravity.TOP,
                  );
          changeIsLoading(false);
        } else if (e.code == 'wrong-password') {
          Fluttertoast.showToast(
              msg:
                  'Error: The username or password you entered is incorrect. ',
                  textColor: Colors.white,
                  backgroundColor: errorColor,
                  gravity: ToastGravity.TOP,);
          changeIsLoading(false);
        } else {
          Fluttertoast.showToast(
              msg: 'Error: ${e.code}',
              textColor: Colors.white,
              backgroundColor: errorColor,
              gravity: ToastGravity.TOP,);
          changeIsLoading(false);
        }
      }
        notifyListeners();
    }

    Future<void>loadUserDataLocalyFromFirebase({required String uid}) async {
      if (User_data.values.toList().isNotEmpty && User_data.values.toList()[0].User_uid != uid) {
        await User_data.clear();
        final QuerySnapshot<Map<String,dynamic>> snapshot = await FirebaseFirestore.instance
            .collection('users')
            .where('user_uid', isEqualTo: uid)
            .limit(1)
            .get();
            if(snapshot.docs.isNotEmpty){
              await createUserLocaly(
                user_id:        snapshot.docs.toList()[0]['user_id'],
                user_uid:       snapshot.docs.toList()[0]['user_uid'],
                firstname:      snapshot.docs.toList()[0]['user_firstname'],
                lastname:       snapshot.docs.toList()[0]['user_lastname'],
                email_id:       snapshot.docs.toList()[0]['user_email'],
                password:       snapshot.docs.toList()[0]['user_password'],
                birthday:       snapshot.docs.toList()[0]['user_dob'].toDate(),
                country:        snapshot.docs.toList()[0]['user_country'],
                profile_image:  snapshot.docs.toList()[0]['user_image_path'],
                gender:         snapshot.docs.toList()[0]['user_gender'],
              );
            }
      }else if(User_data.values.toList().isEmpty){
        final QuerySnapshot<Map<String,dynamic>> snapshot = await FirebaseFirestore.instance
            .collection('users')
            .where('user_uid', isEqualTo: uid)
            .limit(1)
            .get();
            if(snapshot.docs.isNotEmpty){
              await createUserLocaly(
                user_id:        snapshot.docs.toList()[0]['user_id'],
                user_uid:       snapshot.docs.toList()[0]['user_uid'],
                firstname:      snapshot.docs.toList()[0]['user_firstname'],
                lastname:       snapshot.docs.toList()[0]['user_lastname'],
                email_id:       snapshot.docs.toList()[0]['user_email'],
                password:       snapshot.docs.toList()[0]['user_password'],
                birthday:       snapshot.docs.toList()[0]['user_dob'].toDate(),
                country:        snapshot.docs.toList()[0]['user_country'],
                profile_image:  snapshot.docs.toList()[0]['user_image_path'],
                gender:         snapshot.docs.toList()[0]['user_gender'],
              );
            }
            updateLocalstate();
      }
      notifyListeners();
    }

    Future<void> createUserLocaly({
    required String   user_id,
    required String   user_uid,
    required String   firstname,
    required String   lastname,
    required String?   email_id,
    required String   password,
    required DateTime birthday,
    required String   country,
    required String   profile_image,
    required String   gender,
    }) async {
      final UserData user = UserData(
        User_id:        user_id,
        User_uid:       user_uid,
        Firstname:      firstname,
        Lastname:       lastname,
        Email_id:       email_id,
        Password:       password,
        Birthday:       birthday,
        Gender:         gender,
        Country:        country,
        Profile_image:  profile_image
        
      );
      await User_data.add(user);
      user.save();
      updateLocalstate();
      notifyListeners();
    }

    void updateLocalstate(){
      if(User_data.values.toList().isNotEmpty){
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
          _user_email = user.Email_id;
          _user_phone_number = user.Phone_number;
          _first_name = user.Firstname;
          _last_name = user.Lastname;
          _user_dob = user.Birthday;
          _user_country = user.Country;
      }
      notifyListeners();
    }

    /////////////////////////////////////////////////// SIGN UP WITH EMAIL AND PASSWORD ////////////////////////////////////////////////////////
    
    Future<void>signUp({
      required String email,
      required String password,
      required String fullname,
      required String country,
      required DateTime birthday,
      required String gender,
      required String profile_image,
    }) async{
        try{
          changeIsLoading(true);
          final UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword( email: email, password: password);
          var user = await FirebaseFirestore.instance.collection('users').add({
            'created_at': FieldValue.serverTimestamp(),
            'user_firstname':   fullname.split(" ")[0],
            'user_lastname':    fullname.split(" ")[1],
            'user_country':     country,
            'user_dob':         birthday,
            'user_gender':      gender,
            'user_email':       email,
            'user_id': "",
            'user_login_date':  FieldValue.serverTimestamp(),
            'user_name':        fullname.split(" ")[0],
            'user_password':    password,
            'user_uid':         userCredential.user!.uid,
            'user_image_path':  profile_image
          });
          await FirebaseFirestore.instance.collection('users').doc(user.id).update({
            'user_id': user.id
          });
          await User_data.clear();
          await createUserLocaly(
            user_id:        user.id,
            user_uid:       userCredential.user!.uid,
            firstname:      fullname.split(" ")[0],
            lastname:       fullname.split(" ")[1],
            email_id:       email,
            password:       password,
            birthday:       birthday,
            country:        country,
            profile_image:  profile_image,
            gender:         gender,
          );
          changeIsLoading(false);

        }catch(e){
          if (e.toString().contains('email address is already in use')){
             Fluttertoast.showToast(
              msg: 'Error: User already exists',
              textColor: Colors.white,
              backgroundColor: errorColor,
              gravity: ToastGravity.TOP,);
          changeIsLoading(false);
          }else{
            Fluttertoast.showToast(
              msg: 'Error: Unknown error occured',
              textColor: Colors.white,
              backgroundColor: errorColor,
              gravity: ToastGravity.TOP,);
          }
          changeIsLoading(false);
         
        }
        notifyListeners();
    }

  Future<void> advanceSettingsValusUpdate() async {
    changeIsLoading(true);
    if (User_data.values.toList().isNotEmpty) {
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

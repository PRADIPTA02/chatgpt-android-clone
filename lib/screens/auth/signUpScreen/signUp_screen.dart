// ignore_for_file: no_leading_underscores_for_local_identifiers
import 'package:chatgpt/screens/auth/common/authSubmtButton.dart';
import 'package:chatgpt/screens/auth/loginScreen/login_screen.dart';
import 'package:chatgpt/screens/homeScreen/home_screen.dart';
import 'package:chatgpt/util/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../../../CommonWidgets/internet_check_dialog.dart';
import '../../../providers/auth_provider.dart';
import 'package:flutter/cupertino.dart';

import '../../../providers/internet_connection_check_provider.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  late GlobalKey<FormState> signupformKey;
  late TextEditingController _dateTimeController;
  late String _selectedGender = 'Gender';
  late DateTime pickedtime;
  late String _selectedCountry = 'Select Country';
  late TextEditingController signupEmailController;
  late TextEditingController signupPasswordController;
  late TextEditingController signupFullNameController;
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

  RegExp fullNameRegex = RegExp(r'^[a-zA-Z]+( [a-zA-Z]+)+$');

  @override
  initState() {
    super.initState();
    signupformKey = GlobalKey<FormState>();
    _dateTimeController = TextEditingController();
    signupEmailController = TextEditingController();
    signupPasswordController = TextEditingController();
    signupFullNameController = TextEditingController();
    pickedtime = DateTime.now();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showCupertinoModalPopup(
        context: context,
        builder: (BuildContext context) => Container(
              height: MediaQuery.of(context).size.height * 0.3,
              padding: const EdgeInsets.only(top: 6.0),
              margin: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom,
              ),
              child: Theme(
                data: Theme.of(context).copyWith(
                  colorScheme: const ColorScheme.dark(),
                ),
                child: CupertinoDatePicker(
                  initialDateTime: DateTime.now(),
                  mode: CupertinoDatePickerMode.date,
                  backgroundColor: secondaryColor,
                  onDateTimeChanged: (value) => setState(() {
                    SystemSound.play(SystemSoundType.click);
                    HapticFeedback.lightImpact();
                    _dateTimeController.text = DateFormat.yMMMd().format(value);
                    pickedtime = value;
                  }),
                ),
              ),
            )
        // initialDate: DateTime.now(),
        // firstDate: DateTime(1900),
        // lastDate: DateTime.now(),
        );
    if (picked != null) {
      setState(() {
        _dateTimeController.text = DateFormat.yMMMd().format(picked);
        pickedtime = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    FocusNode _focusNode1 = FocusNode();
    FocusNode _focusNode2 = FocusNode();
    FocusNode _focusNode3 = FocusNode();
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final interNetConnectionCheck =
        Provider.of<InterNetConnectionCheck>(context, listen: false);
    return Scaffold(
      backgroundColor: bgColor,
      body: SafeArea(
        child: SingleChildScrollView(
          padding:
              const EdgeInsets.only(left: 15, right: 15, top: 60, bottom: 0),
          reverse: true,
          physics: const BouncingScrollPhysics(
            decelerationRate: ScrollDecelerationRate.fast,
          ),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
            Text(
              "Create new account",
              style: GoogleFonts.nunito(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w700),
            ),
            Text(
              "Please fill the form to continue",
              style: GoogleFonts.nunito(
                  color: Colors.white60,
                  fontSize: 13,
                  fontWeight: FontWeight.w500),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.1,
            ),
            Form(
                key: signupformKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: TextFormField(
                        focusNode: _focusNode1,
                        onFieldSubmitted: (e) => {_focusNode2.requestFocus()},
                        controller: signupFullNameController,
                        cursorColor: cgSecondary,
                        cursorRadius: const Radius.circular(5),
                        keyboardType: TextInputType.name,
                        style: GoogleFonts.nunito(
                            color: Colors.white70,
                            fontSize: 16,
                            fontWeight: FontWeight.w500),
                        validator: (value) {
                          if (!fullNameRegex.hasMatch(value!) ||
                              value.isEmpty) {
                            return 'Please enter a valid username';
                          }
                          return null;
                        },
                        decoration: const InputDecoration(
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 15, horizontal: 12),
                          filled: true,
                          fillColor: secondaryColor,
                          labelText: 'Full Name',
                          labelStyle: TextStyle(
                            color: Colors.white70,
                            fontWeight: FontWeight.w500,
                          ),
                          errorStyle: TextStyle(fontWeight: FontWeight.bold),
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(width: 2, color: cglasscolor),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(width: 2, color: cgSecondary),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderSide: BorderSide(width: 2, color: errorColor),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderSide: BorderSide(width: 2, color: errorColor),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: Consumer<AuthProvider>(
                        builder: (context, value, child) => TextFormField(
                          focusNode: _focusNode2,
                          onFieldSubmitted: (e) => {_focusNode3.requestFocus()},
                          controller: authProvider.login_email_controller,
                          cursorColor: cgSecondary,
                          cursorRadius: const Radius.circular(5),
                          keyboardType: TextInputType.emailAddress,
                          style: GoogleFonts.nunito(
                              color: Colors.white70,
                              fontWeight: FontWeight.w500),
                          validator: (value) {
                            final emailRegex = RegExp(
                                r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
                            if (!emailRegex.hasMatch(value!) || value.isEmpty) {
                              return 'please enter a valid cradetial';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 15, horizontal: 12),
                            filled: true,
                            fillColor: secondaryColor,
                            labelText: 'Email Address',
                            labelStyle: GoogleFonts.nunito(
                              color: Colors.white70,
                            ),
                            errorStyle:
                                GoogleFonts.nunito(fontWeight: FontWeight.bold),
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
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                    Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: DropdownButtonFormField<String>(
                            dropdownColor: secondaryColor,
                            alignment: Alignment.topRight,
                            value: _selectedGender,
                            onChanged: (String? value) {
                              setState(() {
                                _selectedGender = value!;
                              });
                            },
                            items: [
                              DropdownMenuItem(
                                value: 'Gender',
                                child: Text(
                                  'Gender',
                                  style: GoogleFonts.nunito(
                                    color: Colors.white30,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                              DropdownMenuItem(
                                value: 'Male',
                                child: Text(
                                  'Male',
                                  style: GoogleFonts.nunito(
                                    color: Colors.white70,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                              DropdownMenuItem(
                                value: 'Female',
                                child: Text(
                                  'Female',
                                  style: GoogleFonts.nunito(
                                    color: Colors.white70,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                              DropdownMenuItem(
                                value: 'Other',
                                child: Text(
                                  'Other',
                                  style: GoogleFonts.nunito(
                                    color: Colors.white70,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ],
                            decoration: InputDecoration(
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 15, horizontal: 12),
                              filled: true,
                              labelText: 'Gander',
                              labelStyle: GoogleFonts.nunito(
                                color: Colors.white70,
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                              fillColor: secondaryColor,
                              errorStyle: const TextStyle(height: 0),
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
                            validator: (value) {
                              if (value == null || value == 'Gender') {
                                return '';
                              }
                              return null;
                            },
                          ),
                        ),
                        SizedBox(
                            width: MediaQuery.of(context).size.width * 0.02),
                        Expanded(
                          child: GestureDetector(
                            onTap: () => _selectDate(context),
                            child: AbsorbPointer(
                              child: TextFormField(
                                style: GoogleFonts.nunito(
                                  color: Colors.white70,
                                  fontWeight: FontWeight.w500,
                                ),
                                controller: _dateTimeController,
                                decoration: InputDecoration(
                                  contentPadding: const EdgeInsets.symmetric(
                                      vertical: 15, horizontal: 12),
                                  filled: true,
                                  fillColor: secondaryColor,
                                  labelText: 'Date of Birth',
                                  labelStyle: GoogleFonts.nunito(
                                    color: Colors.white70,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                                  hintStyle: GoogleFonts.nunito(
                                    color: Colors.white30,
                                    fontWeight: FontWeight.w500,
                                  ),
                                  errorStyle: const TextStyle(height: 0),
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
                                ),
                                validator: (value) {
                                  if (value == "") {
                                    return '';
                                  }
                                  return null;
                                },
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.01,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: Consumer<AuthProvider>(
                        builder: (context, value, child) => TextFormField(
                          focusNode: _focusNode3,
                          keyboardType: TextInputType.emailAddress,
                          controller: signupPasswordController,
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
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 15, horizontal: 12),
                              filled: true,
                              fillColor: secondaryColor,
                              labelText: 'Password',
                              labelStyle: GoogleFonts.nunito(
                                color: Colors.white70,
                              ),
                              suffixIcon: IconButton(
                                splashColor: Colors.transparent,
                                onPressed: () => {
                                  authProvider.changeLoginPasswordVisibility(),
                                },
                                icon: Icon(authProvider.showLoginPassword
                                    ? Icons.visibility_outlined
                                    : Icons.visibility_off_outlined),
                                color: Colors.white60,
                              ),
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
                              errorStyle: GoogleFonts.nunito(
                                  fontWeight: FontWeight.bold)),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.01,
                    ),
                    DropdownButtonFormField<String>(
                      value: _selectedCountry,
                      dropdownColor: secondaryColor,
                      menuMaxHeight: 300,
                      onChanged: (String? newValue) {
                        setState(() {
                          _selectedCountry = newValue!;
                        });
                      },
                      items: countries
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(
                            value,
                            style: GoogleFonts.nunito(
                              color: Colors.white70,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        );
                      }).toList(),
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 15, horizontal: 12),
                        filled: true,
                        fillColor: secondaryColor,
                        labelText: 'Country',
                        labelStyle: GoogleFonts.nunito(
                          color: Colors.white70,
                          fontWeight: FontWeight.w500,
                        ),
                        errorStyle: const TextStyle(height: 0),
                        enabledBorder: const OutlineInputBorder(
                          borderSide: BorderSide(width: 2, color: cglasscolor),
                        ),
                        focusedBorder: const OutlineInputBorder(
                          borderSide: BorderSide(width: 2, color: cgSecondary),
                        ),
                        errorBorder: const OutlineInputBorder(
                          borderSide: BorderSide(width: 2, color: errorColor),
                        ),
                        focusedErrorBorder: const OutlineInputBorder(
                          borderSide: BorderSide(width: 2, color: errorColor),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value == 'Select Country') {
                          return '';
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.10,
                    ),
                    InkWell(
                      onTap: () async {
                        HapticFeedback.lightImpact();
                        if (!interNetConnectionCheck.isOnline) {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return const InternetCheckDialog();
                            },
                          );
                        } else if (signupformKey.currentState!.validate()) {
                          authProvider.changeIsLoading(true);
                          await authProvider.signUp(
                            profile_image: authProvider.giveRandomavater(),
                            gender: _selectedGender,
                            birthday: pickedtime,
                            country: _selectedCountry,
                            fullname: signupFullNameController.text,
                            email: authProvider.login_email_controller.text,
                            password: signupPasswordController.text,
                            context: context,
                          );
                        }
                      },
                      child: const AuthSubmitButton(title: "Sign up"),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.05,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Already have a account? ",
                          style: GoogleFonts.nunito(
                              fontSize: 15,
                              color: Colors.white70,
                              fontWeight: FontWeight.w500),
                        ),
                        InkWell(
                          splashColor: Colors.transparent,
                          onTap: () => {
                            HapticFeedback.lightImpact(),
                            Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                    builder: (context) => LoginScreen())),
                          },
                          child: Text(
                            "Log in",
                            style: GoogleFonts.nunito(
                                fontSize: 15,
                                color: cgSecondary,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                      ],
                    ),
                  ],
                ))
          ]),
        ),
      ),
    );
  }
}

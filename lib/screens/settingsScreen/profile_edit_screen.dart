// ignore_for_file: non_constant_identifier_names, avoid_types_as_parameter_names

import 'dart:io';

import 'package:chatgpt/util/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'coustom_image_picker_button.dart';

class ProfileEditScreen extends StatefulWidget {
  const ProfileEditScreen({super.key});
  @override
  State<ProfileEditScreen> createState() => _ProfileEditScreenState();
}

class _ProfileEditScreenState extends State<ProfileEditScreen> {
  File? _image;

  final _formKey = GlobalKey<FormState>();
  late TextEditingController _firstNameController;
  late TextEditingController _lastNameController;
  late TextEditingController _phoneNumberController;
  late TextEditingController _emailController;
  late TextEditingController _ageController;
  late TextEditingController _dateTimeController;
  late DateTime _selectedDate;
  late String _selectedCountry = '';
  late String _selectedGender = '';
  List<String> countries = [
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

  //validator for phonr number
  bool _isValidPhoneNumber(String value) {
    final RegExp phoneRegExp = RegExp(r'^[0-9]{10}$');
    return phoneRegExp.hasMatch(value);
  }

  //validator for email

  bool _isValidEmail(String value) {
    // You can use a regular expression to define your email address format
    // Here's a basic example of an email address format validation
    final RegExp emailRegExp = RegExp(
        r'^[\w-]+(\.[\w-]+)*@[a-zA-Z0-9-]+(\.[a-zA-Z0-9-]+)*(\.[a-zA-Z]{2,})$');

    return emailRegExp.hasMatch(value);
  }

  Future _pickImage(ImageSource source) async {
    try {
      final image = await ImagePicker().pickImage(source: source);
      if (image == null) return;
      File? img = File(image.path);
      setState(() {
        _image = img;
      });
    } on PlatformException catch (e) {
      print(e);
      Navigator.of(context).pop;
    }
  }

  @override
  void initState() {
    super.initState();
    _firstNameController = TextEditingController();
    _lastNameController = TextEditingController();
    _phoneNumberController = TextEditingController();
    _emailController = TextEditingController();
    _ageController = TextEditingController();
    _dateTimeController = TextEditingController();
    _selectedCountry = 'Select Country';
    _selectedGender = 'Gender';
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _phoneNumberController.dispose();
    _emailController.dispose();
    _ageController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      setState(() {
        _dateTimeController.text = DateFormat.yMd().format(picked);
      });
    }
  }

  void _showImageSelectionBottomSheet(BuildContext context) {
    showModalBottomSheet(
        context: context,
        backgroundColor: const Color(0xFF141C1C),
        isScrollControlled: true,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(25.0))),
        builder: (BuildContext context) => DraggableScrollableSheet(
            initialChildSize: 0.25,
            maxChildSize: 0.4,
            minChildSize: 0.25,
            expand: false,
            builder: (context, ScrollController) {
              return SingleChildScrollView(
                controller: ScrollController,
                child: Stack(
                  alignment: Alignment.topCenter,
                  clipBehavior: Clip.none,
                  children: [
                    Positioned(
                        top: -15,
                        child: Container(
                          width: 60,
                          height: 7,
                          decoration: BoxDecoration(
                              color: cgSecondary,
                              borderRadius: BorderRadius.circular(5)),
                        )),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.05,
                        ),
                        ImagePickerButton(
                          title: "Chose from Gallery",
                          ontap: () => {
                            _pickImage(ImageSource.gallery),
                            Navigator.of(context).pop(),
                          },
                          icon: Icons.photo_library,
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.02,
                        ),
                        ImagePickerButton(
                          title: "Capture from Camera",
                          ontap: () => {
                            _pickImage(ImageSource.camera),
                            Navigator.of(context).pop(),
                          },
                          icon: Icons.camera,
                        ),
                      ],
                    ),
                  ],
                ),
              );
            }));
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      // Form fields are valid, do something with the data
      // Example: Save to a database
      // _firstNameController.text
      // _lastNameController.text
      // _phoneNumberController.text
      // _emailController.text
      // _ageController.text
      // _selectedDate
      // _selectedCountry
      // _isMale
      // _isFemale

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Form submitted')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: bgColor,
        title: Text(
          "Edit Profile",
          style: GoogleFonts.nunito(fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
      ),
      backgroundColor: bgColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(
                  decelerationRate: ScrollDecelerationRate.normal),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Stack(
                    alignment: Alignment.bottomRight,
                    children: [
                      _image == null
                          ? const CircleAvatar(
                              radius: 50.0,
                              backgroundColor: secondaryColor,
                              backgroundImage: AssetImage(
                                  'assets/images/defaultAccountIcon.png'),
                            )
                          : CircleAvatar(
                              radius: 50.0,
                              backgroundColor: secondaryColor,
                              backgroundImage: FileImage(_image!),
                            ),
                      IconButton(
                          onPressed: () {
                            _showImageSelectionBottomSheet(context);
                          },
                          icon: const Icon(
                            Icons.edit,
                            color: cgSecondary,
                          ))
                    ],
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _firstNameController,
                    cursorColor: cgSecondary,
                    cursorRadius: const Radius.circular(5),
                    keyboardType: TextInputType.emailAddress,
                    style: GoogleFonts.nunito(
                        color: Colors.white70,
                        fontSize: 16,
                        fontWeight: FontWeight.w500),
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 15, horizontal: 12),
                      filled: true,
                      fillColor: secondaryColor,
                      labelText: 'First Name',
                      labelStyle: GoogleFonts.nunito(
                        color: Colors.white70,
                        fontWeight: FontWeight.w500,
                      ),
                      errorStyle: TextStyle(height: 0),
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
                      if (value!.isEmpty) {
                        return '';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                  TextFormField(
                    controller: _lastNameController,
                    style: GoogleFonts.nunito(
                      color: Colors.white70,
                      fontWeight: FontWeight.w500,
                    ),
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 15, horizontal: 12),
                      filled: true,
                      fillColor: secondaryColor,
                      labelText: 'Last Name',
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
                      if (value!.isEmpty) {
                        return '';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                  TextFormField(
                    style: GoogleFonts.nunito(
                      color: Colors.white70,
                      fontWeight: FontWeight.w500,
                    ),
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 15, horizontal: 12),
                      filled: true,
                      fillColor: secondaryColor,
                      labelText: "Email ID",
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
                      if (value!.isEmpty) {
                        return '';
                      }
                      if (!_isValidEmail(value)) {
                        return '';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                  TextFormField(
                    controller: _phoneNumberController,
                    style: GoogleFonts.nunito(
                      color: Colors.white70,
                      fontWeight: FontWeight.w500,
                    ),
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 15, horizontal: 12),
                      filled: true,
                      fillColor: secondaryColor,
                      labelText: "Phone number",
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
                      if (value!.isEmpty) {
                        return '';
                      }
                      if (!_isValidPhoneNumber(value)) {
                        return '';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.02),
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
                      SizedBox(width: MediaQuery.of(context).size.width * 0.02),
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
                                  fontWeight: FontWeight.w500,
                                ),
                                hintStyle: GoogleFonts.nunito(
                                  color: Colors.white30,
                                  fontWeight: FontWeight.w500,
                                ),
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
                  SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: _ageController,
                          style: GoogleFonts.nunito(
                            color: Colors.white70,
                            fontWeight: FontWeight.w500,
                          ),
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 15, horizontal: 12),
                            filled: true,
                            fillColor: secondaryColor,
                            labelText: 'Age',
                            labelStyle: GoogleFonts.nunito(
                              color: Colors.white70,
                              fontWeight: FontWeight.w500,
                            ),
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
                            if (value!.isEmpty) {
                              return '';
                            }
                            int? age = int.tryParse(value);
                            if (age == null || age <= 0) {
                              return '';
                            }
                            return null;
                          },
                        ),
                      ),
                      SizedBox(width: MediaQuery.of(context).size.width * 0.03),
                      Expanded(
                        flex: 2,
                        child: DropdownButtonFormField<String>(
                          value: _selectedCountry,
                          dropdownColor: secondaryColor,
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
                            if (value == null || value == 'Select Country') {
                              return '';
                            }
                            return null;
                          },
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                  Column(
                    children: [
                      InkWell(
                        onTap: null,
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.95,
                          height: MediaQuery.of(context).size.height * 0.06,
                          decoration: BoxDecoration(
                              color: secondaryColor,
                              borderRadius: BorderRadius.circular(5),
                              border: Border.all(color: cgSecondary, width: 2)),
                          child: Center(
                              child: Text('Cancel',
                                  style: GoogleFonts.nunito(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w700,
                                      color: cgSecondary))),
                        ),
                      ),
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.02),
                      InkWell(
                        onTap: () => {
                          if (_formKey.currentState!.validate()) {_submitForm()}
                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.95,
                          height: MediaQuery.of(context).size.height * 0.06,
                          decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                begin: Alignment.topLeft,

                                colors: <Color>[
                                  Color(0xffd62507),
                                  Color(0xffe55a32)
                                ], // red to yellow
                                tileMode: TileMode
                                    .clamp, // repeats the gradient over the canvas
                              ),
                              borderRadius: BorderRadius.circular(5),
                              border: Border.all(color: cglasscolor, width: 2)),
                          child: Center(
                              child: Text('Save',
                                  style: GoogleFonts.nunito(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.white70))),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

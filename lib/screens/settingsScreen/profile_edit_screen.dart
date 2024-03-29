// ignore_for_file: non_constant_identifier_names, avoid_types_as_parameter_names

import 'dart:io';
import 'package:chatgpt/providers/auth_provider.dart';
import 'package:chatgpt/util/constants/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../../CommonWidgets/custom_snakebar.dart';
import '../../CommonWidgets/internet_check_dialog.dart';
import '../../models/user_data_model.dart';
import '../../providers/internet_connection_check_provider.dart';
import '../homeScreen/home_screen.dart';
import 'coustom_image_picker_button.dart';

class ProfileEditScreen extends StatefulWidget {
  final List<UserData> user_data;
  const ProfileEditScreen({super.key, required this.user_data});
  @override
  State<ProfileEditScreen> createState() => _ProfileEditScreenState();
}

class _ProfileEditScreenState extends State<ProfileEditScreen> {
  File? _image;
  late DateTime picked_time;

  final _formKey = GlobalKey<FormState>();
  late TextEditingController _firstNameController;
  late TextEditingController _lastNameController;
  late TextEditingController _phoneNumberController;
  late TextEditingController _emailController;
  late TextEditingController _ageController;
  late TextEditingController _dateTimeController;
  // late DateTime _selectedDate;
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

  //validator for email

  bool _isValidEmail(String value) {
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
      CustomSnackeBar.show(
          context: context, message: e.toString(), status: Status.error);
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
    if (widget.user_data.isNotEmpty) {
      final user = widget.user_data[0];
      _firstNameController.text = user.Firstname;
      _lastNameController.text = user.Lastname;
      _phoneNumberController.text = user.Phone_number.toString();
      _emailController.text = user.Email_id!;
      _ageController.text =
          (DateTime.now().year - user.Birthday.year).toString();
      // _ageController.text = user.Age.toString();
      picked_time = user.Birthday;
      _dateTimeController.text = DateFormat.yMMMd().format(user.Birthday);
      // _selectedDate = user.Birthday;
      _image = user.Profile_image != "" ? File(user.Profile_image) : null;
    }
    _selectedCountry = widget.user_data.isNotEmpty
        ? widget.user_data[0].Country != ""
            ? widget.user_data[0].Country
            : 'Select Country'
        : 'Select Country';
    _selectedGender = widget.user_data.isNotEmpty
        ? widget.user_data[0].Gender != ""
            ? widget.user_data[0].Gender
            : 'Gender'
        : 'Gender';
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

  // Future<void> _selectDate(BuildContext context) async {
  //   final DateTime? picked = await showDatePicker(
  //     context: context,
  //     initialDate: widget.user_data.isNotEmpty
  //         ? widget.user_data[0].Birthday
  //         : DateTime.now(),
  //     firstDate: DateTime(1900),
  //     lastDate: DateTime.now(),
  //   );
  //   if (picked != null) {
  //     setState(() {
  //       _dateTimeController.text = DateFormat.yMMMd().format(picked);
  //       picked_time = picked;
  //       _ageController.text = (DateTime.now().year - picked.year).toString();
  //     });
  //   }
  // }

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
                  initialDateTime: widget.user_data.isNotEmpty
          ? widget.user_data[0].Birthday
          : DateTime.now(),
                  mode: CupertinoDatePickerMode.date,
                  backgroundColor: secondaryColor,
                  onDateTimeChanged: (value) => 
                    setState(() {
                    SystemSound.play(SystemSoundType.click);
                    HapticFeedback.lightImpact();
                      _dateTimeController.text =
                          DateFormat.yMMMd().format(value);
                       picked_time = value;
                       setState(() {
                         _ageController.text = (DateTime.now().year - picked_time.year).toString();
                       });
                      
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
         picked_time = picked;
         _ageController.text = (DateTime.now().year - picked.year).toString();
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
            initialChildSize: 0.35,
            maxChildSize: 0.5,
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
                            HapticFeedback.lightImpact(),
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
                            HapticFeedback.lightImpact(),
                            _pickImage(ImageSource.camera),
                            Navigator.of(context).pop(),
                          },
                          icon: Icons.camera,
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.02,
                        ),
                        ImagePickerButton(
                          title: "Remove Photo",
                          ontap: () => {
                            HapticFeedback.lightImpact(),
                            setState(() {
                              _image = null;
                            }),
                            Navigator.of(context).pop(),
                          },
                          icon: Icons.delete,
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.02,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                InkWell(
                                  splashColor: Colors.transparent,
                                  onTap: () {
                                    HapticFeedback.lightImpact();
                                    setState(() {
                                      _image =
                                          File("assets/images/avater_1.png");
                                      Navigator.of(context).pop();
                                    });
                                  },
                                  child: const CircleAvatar(
                                    radius: 30,
                                    backgroundColor: Colors.transparent,
                                    backgroundImage: AssetImage(
                                        "assets/images/avater_1.png"),
                                  ),
                                ),
                                InkWell(
                                  splashColor: Colors.transparent,
                                  onTap: () {
                                    HapticFeedback.lightImpact();
                                    setState(() {
                                      _image =
                                          File("assets/images/avater_2.png");
                                      Navigator.of(context).pop();
                                    });
                                  },
                                  child: const CircleAvatar(
                                    radius: 30,
                                    backgroundColor: Colors.transparent,
                                    backgroundImage: AssetImage(
                                        "assets/images/avater_2.png"),
                                  ),
                                ),
                                InkWell(
                                  splashColor: Colors.transparent,
                                  onTap: () {
                                    HapticFeedback.lightImpact();
                                    setState(() {
                                      _image =
                                          File("assets/images/avater_3.png");
                                      Navigator.of(context).pop();
                                    });
                                  },
                                  child: const CircleAvatar(
                                    radius: 30,
                                    backgroundColor: Colors.transparent,
                                    backgroundImage: AssetImage(
                                        "assets/images/avater_3.png"),
                                  ),
                                ),
                                InkWell(
                                  splashColor: Colors.transparent,
                                  onTap: () {
                                    HapticFeedback.lightImpact();
                                    setState(() {
                                      _image =
                                          File("assets/images/avater_4.png");
                                      Navigator.of(context).pop();
                                    });
                                  },
                                  child: const CircleAvatar(
                                    radius: 30,
                                    backgroundColor: Colors.transparent,
                                    backgroundImage: AssetImage(
                                        "assets/images/avater_4.png"),
                                  ),
                                ),
                                InkWell(
                                  splashColor: Colors.transparent,
                                  onTap: () {
                                    HapticFeedback.lightImpact();
                                    setState(() {
                                      _image =
                                          File("assets/images/avater_5.png");
                                      Navigator.of(context).pop();
                                    });
                                  },
                                  child: const CircleAvatar(
                                    radius: 30,
                                    backgroundColor: Colors.transparent,
                                    backgroundImage: AssetImage(
                                        "assets/images/avater_5.png"),
                                  ),
                                ),
                              ]),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.02,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              InkWell(
                                splashColor: Colors.transparent,
                                onTap: () {
                                  HapticFeedback.lightImpact();
                                  setState(() {
                                    _image = File("assets/images/avater_6.png");
                                    Navigator.of(context).pop();
                                  });
                                },
                                child: const CircleAvatar(
                                  radius: 30,
                                  backgroundColor: Colors.transparent,
                                  backgroundImage:
                                      AssetImage("assets/images/avater_6.png"),
                                ),
                              ),
                              InkWell(
                                splashColor: Colors.transparent,
                                onTap: () {
                                  HapticFeedback.lightImpact();
                                  setState(() {
                                    _image = File("assets/images/avater_7.png");
                                    Navigator.of(context).pop();
                                  });
                                },
                                child: const CircleAvatar(
                                  radius: 30,
                                  backgroundColor: Colors.transparent,
                                  backgroundImage:
                                      AssetImage("assets/images/avater_7.png"),
                                ),
                              ),
                              InkWell(
                                splashColor: Colors.transparent,
                                onTap: () {
                                  HapticFeedback.lightImpact();
                                  setState(() {
                                    _image = File("assets/images/avater_8.png");
                                    Navigator.of(context).pop();
                                  });
                                },
                                child: const CircleAvatar(
                                  radius: 30,
                                  backgroundColor: Colors.transparent,
                                  backgroundImage:
                                      AssetImage("assets/images/avater_8.png"),
                                ),
                              ),
                              InkWell(
                                splashColor: Colors.transparent,
                                onTap: () {
                                  HapticFeedback.lightImpact();
                                  setState(() {
                                    _image = File("assets/images/avater_9.png");
                                    Navigator.of(context).pop();
                                  });
                                },
                                child: const CircleAvatar(
                                  radius: 30,
                                  backgroundColor: Colors.transparent,
                                  backgroundImage:
                                      AssetImage("assets/images/avater_9.png"),
                                ),
                              ),
                              InkWell(
                                splashColor: Colors.transparent,
                                onTap: () {
                                  HapticFeedback.lightImpact();
                                  setState(() {
                                    _image =
                                        File("assets/images/avater_10.png");
                                    Navigator.of(context).pop();
                                  });
                                },
                                child: const CircleAvatar(
                                  radius: 30,
                                  backgroundColor: Colors.transparent,
                                  backgroundImage:
                                      AssetImage("assets/images/avater_12.png"),
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              );
            }));
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(
      builder: (context, authProvider, child) => Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: bgColor,
          leading: IconButton(
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            icon: const Icon(Icons.arrow_back),
            onPressed: () async {
              HapticFeedback.lightImpact();
              Navigator.of(context).pop();
            },
          ),
          title: Text(
            "Edit Profile",
            style: GoogleFonts.nunito(fontWeight: FontWeight.w700),
            textAlign: TextAlign.center,
          ),
        ),
        backgroundColor: bgColor,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(8),
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
                            : _image?.path.split('/').toList()[0] == 'assets'
                                ? CircleAvatar(
                                    radius: 50,
                                    backgroundColor: secondaryColor,
                                    backgroundImage: AssetImage(_image!.path),
                                  )
                                : CircleAvatar(
                                    radius: 50.0,
                                    backgroundColor: secondaryColor,
                                    backgroundImage: FileImage(_image!),
                                  ),
                        Positioned(
                          bottom: -8,
                          right: -2,
                          child: IconButton(
                              splashColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              onPressed: () {
                                HapticFeedback.lightImpact();
                                _showImageSelectionBottomSheet(context);
                              },
                              icon: Container(
                                height:
                                    MediaQuery.of(context).size.height * 0.04,
                                width:
                                    MediaQuery.of(context).size.height * 0.04,
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: cgSecondary,
                                    boxShadow: [
                                      BoxShadow(
                                          color: Colors.black.withOpacity(0.5),
                                          blurRadius: 5,
                                          offset: const Offset(0, 3))
                                    ]),
                                child: const Icon(
                                  Icons.edit,
                                  color: Colors.white,
                                  size: 25,
                                ),
                              )),
                        )
                      ],
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.05),
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
                      controller: _lastNameController,
                      style: GoogleFonts.nunito(
                        color: Colors.white70,
                        fontSize: 16,
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
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                      readOnly: true,
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
                                authProvider.changeUserGender(value);
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
                            readOnly: true,
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
                          ),
                        ),
                        SizedBox(
                            width: MediaQuery.of(context).size.width * 0.03),
                        Expanded(
                          flex: 2,
                          child: DropdownButtonFormField<String>(
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
                    Consumer2<AuthProvider,InterNetConnectionCheck>(
                      builder: (context, value,interNetConnectionCheck, child) => Column(
                        children: [
                          InkWell(
                            splashColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            onTap: () {
                              HapticFeedback.lightImpact();
                              if (!mounted) return;
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => const HomeScreen()));
                            },
                            child: Container(
                              width: MediaQuery.of(context).size.width * 0.95,
                              height: MediaQuery.of(context).size.height * 0.06,
                              decoration: BoxDecoration(
                                  color: secondaryColor,
                                  borderRadius: BorderRadius.circular(5),
                                  border:
                                      Border.all(color: cgSecondary, width: 2)),
                              child: Center(
                                  child: Text('Cancel',
                                      style: GoogleFonts.nunito(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w700,
                                          color: cgSecondary))),
                            ),
                          ),
                          SizedBox(
                              height:
                                  MediaQuery.of(context).size.height * 0.02),
                          InkWell(
                            splashColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            onTap: () async {
                              HapticFeedback.lightImpact();
                               if (!interNetConnectionCheck
                                                      .isOnline)
                                                    {
                                                      showDialog(
                                                        context: context,
                                                        builder: (BuildContext
                                                            context) {
                                                          return const InternetCheckDialog();
                                                        },
                                                      );
                                                    }
                              else if (_formKey.currentState!.validate()) {
                                await value.profileUpdate(
                                  user_id: widget.user_data[0].User_id,
                                  firstname: _firstNameController.text,
                                  lastname: _lastNameController.text,
                                  birthday: picked_time,
                                  country: _selectedCountry,
                                  profile_image:
                                      _image == null ? "" : _image!.path,
                                  gender: _selectedGender,
                                );
                                Fluttertoast.showToast(
                                    msg: "Profile Updated Successfully",
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.TOP,
                                    timeInSecForIosWeb: 1,
                                    backgroundColor: successColor,
                                    textColor: Colors.white,
                                    fontSize: 16.0);
                              }
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
                                  border:
                                      Border.all(color: cglasscolor, width: 2)),
                              child: Center(
                                  child: value.isLoading
                                      ? const SizedBox(
                                          height: 35,
                                          width: 35,
                                          child: CircularProgressIndicator(
                                            color: Colors.white,
                                          ))
                                      : Text("Submit",
                                          style: GoogleFonts.nunito(
                                              fontSize: 20,
                                              fontWeight: FontWeight.w700,
                                              color: Colors.white70))),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

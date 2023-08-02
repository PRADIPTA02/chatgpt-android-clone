// ignore_for_file: non_constant_identifier_names, avoid_types_as_parameter_names

import 'dart:io';

import 'package:chatgpt/providers/auth_provider.dart';
import 'package:chatgpt/screens/settingsScreen/gender_widget.dart';
import 'package:chatgpt/screens/settingsScreen/profile_edit_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../util/constants/constants.dart';
import '../settingsScreen/info_widgets.dart';

class AccountInfo extends StatefulWidget {
  const AccountInfo({super.key});

  @override
  State<AccountInfo> createState() => _AccountInfoState();
}

class _AccountInfoState extends State<AccountInfo> {
  File? _image; 


  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(
      builder: (context, value, child) => Scaffold(
        appBar: AppBar(
          backgroundColor: bgColor,
          elevation: 0,
          leading: IconButton(
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              onPressed: () {
                HapticFeedback.lightImpact();
                Navigator.of(context).pop();
                },
              icon: const Icon(Icons.arrow_back)),
              title: Text(
                "Account",
                style: GoogleFonts.nunito(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.w700),
              ),
          actions: [
            IconButton(
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              onPressed: () => {
                HapticFeedback.lightImpact(),
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ProfileEditScreen(
                              user_data: value.User_Data.values.toList(),
                            )))
              },
              icon: const Icon(
                Icons.edit_note,
                color: Colors.white,
                size: 30,
              ),
            )
          ],
        ),
        backgroundColor: bgColor,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 25),
          child: ListView(
            physics: const BouncingScrollPhysics(
                decelerationRate: ScrollDecelerationRate.normal),
            children: [
              
              SizedBox(height: MediaQuery.of(context).size.height * 0.08),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Photo",
                    style: GoogleFonts.nunito(
                        color: Colors.white30,
                        fontSize: 15,
                        fontWeight: FontWeight.w700),
                  ),
                  SizedBox(width: MediaQuery.of(context).size.width * 0.25),
                  Column(
                    children: [
                      Center(
                          child: Hero(
                              tag: "profile123",
                              child: _image == null
                                  ? value.User_image == ""
                                      ? const CircleAvatar(
                                          radius: 50.0,
                                          backgroundColor: secondaryColor,
                                          backgroundImage: AssetImage(
                                              'assets/images/defaultAccountIcon.png'),
                                        )
                                      : value.User_image.split('/').toList()[0]=='assets'?  CircleAvatar(
                                          radius: 50.0,
                                          backgroundColor: secondaryColor,
                                          backgroundImage: AssetImage(
                                              value.User_image),
                                        ):
                                      CircleAvatar(
                                          radius: 50.0,
                                          backgroundColor: secondaryColor,
                                          backgroundImage:
                                              FileImage(File(value.User_image)),
                                        )
                                  : CircleAvatar(
                                      radius: 50.0,
                                      backgroundColor: secondaryColor,
                                      backgroundImage: FileImage(
                                        File(_image!.path),
                                      ),
                                    ))),
                      
                    ],
                  )
                ],
              ),
              SizedBox(height: MediaQuery.of(context).size.width * 0.15),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Name",
                    style: GoogleFonts.nunito(
                        color: Colors.white30,
                        fontSize: 15,
                        fontWeight: FontWeight.w700),
                  ),
                  InfoWidget(
                    data: "${value.first_name} ${value.last_name}",
                  )
                ],
              ),
              SizedBox(height: MediaQuery.of(context).size.width * 0.15),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Gender",
                    style: GoogleFonts.nunito(
                        color: Colors.white30,
                        fontSize: 15,
                        fontWeight: FontWeight.w700),
                  ),
                  GenderWidget(
                      gender:
                          value.user_gender != "" ? value.user_gender : "Male"),
                ],
              ),
              SizedBox(height: MediaQuery.of(context).size.width * 0.15),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Age",
                    style: GoogleFonts.nunito(
                        color: Colors.white30,
                        fontSize: 15,
                        fontWeight: FontWeight.w700),
                  ),
                  InfoWidget(
                    data:  (DateTime.now().year-value.user_dob.year).toString(),
                  )
                ],
              ),
              SizedBox(height: MediaQuery.of(context).size.width * 0.15),
             
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Email",
                    style: GoogleFonts.nunito(
                        color: Colors.white30,
                        fontSize: 15,
                        fontWeight: FontWeight.w700),
                  ),
                  InfoWidget(
                    data: value.user_email!,
                  ),
                ],
              ),
              SizedBox(height: MediaQuery.of(context).size.width * 0.14),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Birthday",
                    style: GoogleFonts.nunito(
                        color: Colors.white30,
                        fontSize: 15,
                        fontWeight: FontWeight.w700),
                  ),
                  InfoWidget(
                    data: value.user_dob.toString().split(' ')[0],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

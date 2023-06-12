import 'dart:io';

import 'package:chatgpt/providers/auth_provider.dart';
import 'package:chatgpt/screens/settingsScreen/gender_widget.dart';
import 'package:chatgpt/screens/settingsScreen/profile_edit_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import '../../CommonWidgets/custom_snakebar.dart';
import '../../util/constants/constants.dart';
import '../settingsScreen/coustom_image_picker_button.dart';
import '../settingsScreen/info_widgets.dart';

class AccountInfo extends StatefulWidget {
  const AccountInfo({super.key});

  @override
  State<AccountInfo> createState() => _AccountInfoState();
}

class _AccountInfoState extends State<AccountInfo> {
  File? _image;

  Future<void> _pickImage(ImageSource source) async {
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
              return Consumer<AuthProvider>(
                builder:(context, value, child) => SingleChildScrollView(
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
                              ontap: ()async{
                                Navigator.of(context).pop();
                                await _pickImage(ImageSource.gallery);
                                if(_image!=null){
                                value.changeProfileImage(_image?.path);
                                }
                              },
                              icon: Icons.photo_library,
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.02,
                            ),
                            ImagePickerButton(
                              title: "Capture from Camera",
                              ontap: () async{
                                Navigator.of(context).pop();
                                await _pickImage(ImageSource.camera);
                                 if(_image!=null){
                                value.changeProfileImage(_image?.path);
                                }
                              },
                              icon: Icons.camera,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
              );
            }));
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(
        builder: (context, value, child) =>  Scaffold(
      appBar: AppBar(
        backgroundColor: bgColor,
        elevation: 0,
        leading: IconButton(
            splashColor: Colors.transparent,
            onPressed: () => Navigator.of(context).pop(),
            icon: const Icon(Icons.arrow_back)),
        actions: [
          IconButton(
            onPressed: () => {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>  ProfileEditScreen(user_data: value.User_Data.values.toList(),)))
            },
            icon: const Icon(
              Icons.edit_note,
              color: Colors.white,
            ),
          )
        ],
      ),
      backgroundColor: bgColor,
      body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 17, vertical: 25),
          child: ListView(
            physics: const BouncingScrollPhysics(
                decelerationRate: ScrollDecelerationRate.fast),
            children: [
              Text(
                "Account",
                style: GoogleFonts.nunito(
                    color: Colors.white,
                    fontSize: 35,
                    fontWeight: FontWeight.w700),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.08),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Photo",
                    style: GoogleFonts.nunito(
                        color: Colors.white30,
                        fontSize: 16,
                        fontWeight: FontWeight.w700),
                  ),
                  SizedBox(width: MediaQuery.of(context).size.width * 0.25),
                  Column(
                    children: [
                      Center(
                          child: Hero(
                        tag: "profile123",
                        child: _image == null
                            ?value.User_image==""?const CircleAvatar(
                                radius: 50.0,
                                backgroundColor: secondaryColor,
                                backgroundImage: AssetImage('assets/images/defaultAccountIcon.png'),
                              ):CircleAvatar(
                                radius: 50.0,
                                backgroundColor: secondaryColor,
                                backgroundImage: FileImage(File(value.User_image)),
                              )
                            : CircleAvatar(
                                radius: 50.0,
                                backgroundColor: secondaryColor,
                                backgroundImage: FileImage(File(_image!.path),
                              ),
                      ))),
                      SizedBox(
                          height: MediaQuery.of(context).size.width * 0.08),
                      GestureDetector(
                        onTap: (){
                           _showImageSelectionBottomSheet(context);
                        },
                        child: Text(
                          "Upload Image",
                          style: GoogleFonts.nunito(
                              color: cgSecondary,
                              fontSize: 18,
                              fontWeight: FontWeight.w700),
                        ),
                      ),
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
                        fontSize: 16,
                        fontWeight: FontWeight.w700),
                  ),
                   InfoWidget(
                    data: "${value.fast_name} ${value.last_name}",
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
                        fontSize: 16,
                        fontWeight: FontWeight.w700),
                  ),
                   GenderWidget(gender: value.user_gender!=""?value.user_gender:"male"),
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
                        fontSize: 16,
                        fontWeight: FontWeight.w700),
                  ),
                   InfoWidget(
                    data: value.user_age.toString(),
                  )
                ],
              ),
              SizedBox(height: MediaQuery.of(context).size.width * 0.15),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Phone",
                    style: GoogleFonts.nunito(
                        color: Colors.white30,
                        fontSize: 16,
                        fontWeight: FontWeight.w700),
                  ),
                  // SizedBox(width: MediaQuery.of(context).size.width * 0.15),
                   InfoWidget(
                    data: value.user_phone_number.toString(),
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
                        fontSize: 16,
                        fontWeight: FontWeight.w700),
                  ),
                  // SizedBox(width: MediaQuery.of(context).size.width * 0.15),
                   InfoWidget(
                    data: value.user_email,
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

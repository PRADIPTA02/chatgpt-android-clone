import 'dart:io';
import 'package:chatgpt/providers/auth_provider.dart';
import 'package:chatgpt/screens/accountInfo/account_info.dart';
import 'package:chatgpt/screens/settingsScreen/language_setting.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../util/constants/constants.dart';
import 'advance_settings.dart';
import 'ai_model_setting.dart';
import 'back_button.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(builder: (context, value, child) {
      return Scaffold(
        appBar: AppBar(
          title: Text(
            "Settings",
            style: GoogleFonts.nunito(
                color: const Color.fromARGB(255, 212, 211, 211),
                fontSize: 24,
                fontWeight: FontWeight.w700),
          ),
          leading: IconButton(
              splashColor: Colors.transparent,
              onPressed: () {
                value.changeIsExpanded(false);
                value.changeIsAdvanceModeONOF(false);
                Navigator.pop(context);
              },
              icon: const Icon(Icons.arrow_back)),
          backgroundColor: bgColor,
          elevation: 0,
        ),
        backgroundColor: bgColor,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 25),
          child: ListView(
            physics: const BouncingScrollPhysics(
                decelerationRate: ScrollDecelerationRate.fast),
            children: [
              Text(
                "Account",
                style: GoogleFonts.nunito(
                    color: cgSecondary,
                    fontSize: 18,
                    fontWeight: FontWeight.w600),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.04),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      value.User_image == ""
                          ? const CircleAvatar(
                              radius: 28,
                              backgroundColor: secondaryColor,
                              backgroundImage: AssetImage(
                                  'assets/images/defaultAccountIcon.png'),
                            )
                          : value.User_image.split('/').toList()[0] ==
                                  'assets'
                              ? CircleAvatar(
                                  backgroundColor: secondaryColor,
                                  backgroundImage:
                                      AssetImage(value.User_image),
                                )
                              : CircleAvatar(
                                  radius: 28,
                                  backgroundColor: secondaryColor,
                                  backgroundImage:
                                      FileImage(File(value.User_image)),
                                ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.03,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "",
                            style: GoogleFonts.nunito(
                                color:
                                    const Color.fromARGB(255, 212, 211, 211),
                                fontSize: 16,
                                fontWeight: FontWeight.w600),
                          ),
                          Text(
                            "Personal info",
                            style: GoogleFonts.nunito(
                                color: Colors.white30,
                                fontSize: 15,
                                fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                    ],
                  ),
                  CustomBackButton(
                    onTap: () => {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const AccountInfo()))
                    },
                  )
                ],
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              Text(
                "Settings",
                style: GoogleFonts.nunito(
                    color: cgSecondary,
                    fontSize: 18,
                    fontWeight: FontWeight.w600),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.04),
              const LanguageSetting(),
              SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              const AiModelSetting(),
              SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              const AdvanceSettings(),
            ],
          ),
        ),
      );
    });
  }
}

import 'package:chatgpt/screens/accountInfo/account_info.dart';
import 'package:chatgpt/screens/settingsScreen/language_setting.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../util/constants/constants.dart';
import 'account_widget.dart';
import 'advance_settings.dart';
import 'ai_model_setting.dart';
import 'back_button.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: bgColor,
        elevation: 0,
      ),
      backgroundColor: bgColor,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 17, vertical: 25),
        child: ListView(
          physics: const BouncingScrollPhysics(decelerationRate: ScrollDecelerationRate.fast),
          children: [
            Text(
              "Settings",
              style: GoogleFonts.nunito(
                  color: const Color.fromARGB(255, 212, 211, 211),
                  fontSize: 35,
                  fontWeight: FontWeight.w700),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.08),
            Text(
              "Account",
              style: GoogleFonts.nunito(
                  color: cgSecondary,
                  fontSize: 23,
                  fontWeight: FontWeight.w500),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.04),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const CircleAvatar(
                      radius: 30,
                      backgroundImage:
                          AssetImage('assets/images/default_avatar.png'),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.03,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Pradipta Karmakar",
                          style: GoogleFonts.nunito(
                              color: const Color.fromARGB(255, 212, 211, 211),
                              fontSize: 18,
                              fontWeight: FontWeight.w700),
                        ),
                        Text(
                          "Personal info",
                          style: GoogleFonts.nunito(
                              color: Colors.white30,
                              fontSize: 16,
                              fontWeight: FontWeight.w700),
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
                  fontSize: 23,
                  fontWeight: FontWeight.w500),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.04),
            const LanguageSetting(),
            SizedBox(height: MediaQuery.of(context).size.height * 0.05),
            const AdvanceSettings(),
            SizedBox(height: MediaQuery.of(context).size.height * 0.05),
            const AiModelSetting(),
          ],
        ),
      ),
    );
  }
}

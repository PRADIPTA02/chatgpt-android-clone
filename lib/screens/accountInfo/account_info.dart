import 'package:chatgpt/screens/settingsScreen/gender_widget.dart';
import 'package:chatgpt/screens/settingsScreen/profile_edit_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../util/constants/constants.dart';
import '../auth/common/user_details_form.dart';
import '../settingsScreen/info_widgets.dart';

class AccountInfo extends StatelessWidget {
  const AccountInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                      builder: (context) => const ProfileEditScreen()))
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
                    const Center(
                        child: Hero(
                      tag: "profile123",
                      child: CircleAvatar(
                        radius: 50,
                        backgroundImage:
                            AssetImage('assets/images/default_avatar.png'),
                      ),
                    )),
                    SizedBox(height: MediaQuery.of(context).size.width * 0.08),
                    Text(
                      "Upload Image",
                      style: GoogleFonts.nunito(
                          color: cgSecondary,
                          fontSize: 18,
                          fontWeight: FontWeight.w700),
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
                const InfoWidget(
                  data: "Pradipta Karmakar",
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
                const GenderWidget(),
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
                const InfoWidget(
                  data: "20",
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
                const InfoWidget(
                  data: "6295258586",
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
                const InfoWidget(
                  data: "pradiptakarmakarmajdia62@gmail.com",
                )
              ],
            ),
          ],
        ),
      ),
    );
    ;
  }
}

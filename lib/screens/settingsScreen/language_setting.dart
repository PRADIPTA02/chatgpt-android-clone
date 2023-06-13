import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../providers/auth_provider.dart';
import '../../util/constants/constants.dart';

class LanguageSetting extends StatelessWidget {
  const LanguageSetting({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Image.asset(
              'assets/images/languageicon.png',
              height: 25,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.05,
            ),
            Text(
              "Language",
              style: GoogleFonts.nunito(
                  color: const Color.fromARGB(255, 212, 211, 211),
                  fontSize: 16,
                  fontWeight: FontWeight.w600),
            ),
          ],
        ),
        Row(
          children: [
            Container(
              decoration: const BoxDecoration(
                  color: secondaryColor,
                  borderRadius: BorderRadius.all(Radius.circular(5))),
              child: Consumer<AuthProvider>(builder: (context, value, child) {
                return Center(
                  child: DropdownButton<String>(
                    alignment: Alignment.center,
                    menuMaxHeight: 200.10,
                    underline: const SizedBox(),
                    dropdownColor: secondaryColor,
                    value: value.App_language,
                    onChanged: (String? newValue) {
                      value.changeLanguage(newValue!);
                      value.userLanguageUpdate(user_language: newValue);
                    },
                    items: [
                      'English',
                      '国语',
                      'हिंदी',
                      'Española',
                      'Français',
                      'عربي',
                      'বাংলা',
                      'Русский',
                      'Português',
                      'bahasa Indonesia',
                      'اردو',
                      '日本',
                      'Deutsch',
                      'ਪੰਜਾਬੀ',
                      'basa jawa',
                    ].map((String language) {
                      return DropdownMenuItem<String>(
                        value: language,
                        child: Text(
                          language,
                          style: GoogleFonts.nunito(
                              color: Colors.white70,
                              fontSize: 14,
                              fontWeight: FontWeight.w500),
                        ),
                      );
                    }).toList(),
                  ),
                );
              }),
            ),
          ],
        ),
      ],
    );
  }
}

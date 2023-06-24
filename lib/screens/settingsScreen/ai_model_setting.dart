import 'package:chatgpt/providers/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../util/constants/constants.dart';

class AiModelSetting extends StatelessWidget {
  const AiModelSetting({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Image.asset(
              'assets/images/aiModelIcon.png',
              height: 25,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.05,
            ),
            Text(
              "Ai Model",
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
                    menuMaxHeight: 200.10,
                    alignment: Alignment.topCenter,
                    underline: const SizedBox(),
                    dropdownColor: secondaryColor,
                    value: value.Chat_model,
                    onChanged: (String? newValue) {
                      value.changeChatModel(newValue!);
                      value.aiModelUpdatesingle(ai_model: newValue);
                    },
                    items: [
                      'text-davinci-003',
                      'text-curie-001',
                      'text-babbage-001',
                      'text-ada-001',
                      'text-davinci-002',
                      'text-davinci-001',
                      'davinci-instruct-beta',
                      'davinci',
                      'curie-instruct-beta',
                      'curie'
                    ].map((String model) {
                      return DropdownMenuItem<String>(
                        value: model,
                        child: Text(
                          model,
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

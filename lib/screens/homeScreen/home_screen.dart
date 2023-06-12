import 'dart:io';

import 'package:chatgpt/providers/auth_provider.dart';
import 'package:chatgpt/providers/text_copletion_provider.dart';
import 'package:chatgpt/screens/accountInfo/account_info.dart';
import 'package:chatgpt/screens/chatScreen/chatScreen.dart';
import 'package:chatgpt/screens/homeScreen/conversation_list.dart';
import 'package:chatgpt/screens/homeScreen/menu_items.dart';
import 'package:chatgpt/screens/settingsScreen/settings_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../CommonWidgets/sign_out_dialog.dart';
import '../../models/home_screen_menu_item.dart';
import '../../util/constants/constants.dart';
import '../imageGenerationScreen/image_generate_screen.dart';
import 'package:share_plus/share_plus.dart';

import '../imageGenerationScreen/resent_images_carousel.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final textCompletionProvider =
        Provider.of<TextCompletProvider>(context, listen: false);
    return Consumer2<TextCompletProvider,AuthProvider>(
            builder: (context, value1,value2, child) => Scaffold(
      appBar: AppBar(
        backgroundColor: bgColor,
        elevation: 0,
        title: Text(
          "OpenAI",
          style: GoogleFonts.nunito(
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          Theme(
            data: Theme.of(context).copyWith(
                dividerColor: const Color.fromARGB(68, 158, 158, 158),
                dividerTheme: const DividerThemeData(
                    indent: 20, endIndent: 20, thickness: 1.5)),
            child: PopupMenuButton<MenuItem>(
                iconSize: 50,
                onSelected: (value) => {
                      if (value.text.toString() == 'Sign Out')
                        {
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return const SignOutDialog();
                              })
                        }
                      else if (value.text.toString() == 'Account')
                        {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const AccountInfo()))
                        }
                      else if (value.text.toString() == 'Settings')
                        {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const SettingsScreen()))
                        }
                      else if (value.text.toString() == 'Share')
                        {Share.share('https://www.google.com')}
                    },
                shape: BeveledRectangleBorder(
                    borderRadius: BorderRadius.circular(3)),
                color: secondaryColor,
                icon:value2.User_image==""? const CircleAvatar(
                  backgroundColor: secondaryColor,
                  backgroundImage:
                      AssetImage('assets/images/defaultAccountIcon.png'),
                ):CircleAvatar(
                  backgroundColor: secondaryColor,
                  backgroundImage:
                      FileImage(File(value2.User_image)),
                ),
                itemBuilder: (context) => [
                      ...MenuItems.itemsFirst.map(buildItem).toList(),
                      const PopupMenuDivider(),
                      ...MenuItems.itemsSecond.map(buildItem).toList(),
                    ]),
          ),
        ],
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
        ),
      ),
      backgroundColor: bgColor,
      body: Padding(
        padding: const EdgeInsets.only(left: 15,right:15,top:15),
        child: Column(
                  children: [
                    Text(
                      "Explore the World of AI",
                      style: GoogleFonts.nunito(
                          color: Colors.white70,
                          fontSize: 16,
                          fontWeight: FontWeight.w500),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.02,
                    ),
                    const ResentImagesCarousel(),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.005,
                    ),
                    InkWell(
                      onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  const ImageGenerateScreen())),
                      child: Row(
                        children: [
                          Container(
                            height: 50,
                            width: 50,
                            decoration: BoxDecoration(
                                color: const Color.fromRGBO(121, 80, 224, 1),
                                borderRadius: BorderRadius.circular(5)),
                            child: const Icon(
                              Icons.image,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Image generation",
                                style: GoogleFonts.nunito(
                                    color: Colors.white70,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500),
                              ),
                              Text("Generate and edit images",
                                  style: GoogleFonts.nunito(
                                      color: Colors.grey,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w300))
                            ],
                          )
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      child: InkWell(
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const ChatScreen()),
                        ),
                        child: Row(
                          children: [
                            Container(
                              height: 50,
                              width: 50,
                              decoration: BoxDecoration(
                                  color: const Color.fromRGBO(51, 196, 145, 1),
                                  borderRadius: BorderRadius.circular(5)),
                              child: const Icon(
                                Icons.edit,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(width: 8),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Text completion",
                                  style: GoogleFonts.nunito(
                                      color: Colors.white70,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500),
                                ),
                                Text("Generate and edit text",
                                    style: GoogleFonts.nunito(
                                        color: Colors.grey,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w300))
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                    // SizedBox(
                    //   height: MediaQuery.of(context).size.height * 0.01,
                    // ),
                    textCompletionProvider.allMessages.isEmpty
                        ? const SizedBox()
                        : Text(
                            'Resent Chats',
                            style: GoogleFonts.nunito(
                                color: Colors.white70,
                                fontWeight: FontWeight.bold,
                                fontSize: 15),
                          ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.01,
                    ),
                    const Flexible(child: ConversationList()),
                  ],
                )),
      ),
    );
  }

  PopupMenuItem<MenuItem> buildItem(MenuItem item) => PopupMenuItem<MenuItem>(
      value: item,
      child: Row(
        children: [
          Padding(
            padding: item == MenuItems.itemProfile
                ? const EdgeInsets.all(0.0)
                : const EdgeInsets.all(8.0),
            child: item.icon,
          ),
          const SizedBox(
            width: 12,
          ),
          Text(
            item.text,
            style: GoogleFonts.nunito(
              color: Colors.white70,
              fontWeight: FontWeight.w800,
            ),
          ),
        ],
      ));
}

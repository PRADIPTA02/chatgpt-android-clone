import 'dart:io';

import 'package:chatgpt/providers/auth_provider.dart';
import 'package:chatgpt/providers/text_copletion_provider.dart';
import 'package:chatgpt/screens/accountInfo/account_info.dart';
import 'package:chatgpt/screens/chatScreen/chatScreen.dart';
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
import '../settingsScreen/back_button.dart';
import 'conversation_item.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final textCompletionProvider =
        Provider.of<TextCompletProvider>(context, listen: false);
    return Consumer2<TextCompletProvider, AuthProvider>(
        builder: (context, value1, value2, child) => Scaffold(
              appBar: AppBar(
                backgroundColor: bgColor,
                elevation: 0,
                title: Text(
                  "OpenAI",
                  style: GoogleFonts.nunito(
                    fontSize: 24,
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
                                          builder: (context) =>
                                              const AccountInfo()))
                                }
                              else if (value.text.toString() == 'Settings')
                                {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const SettingsScreen()))
                                }
                              else if (value.text.toString() == 'Share')
                                {Share.share('https://www.google.com')}
                            },
                        shape: BeveledRectangleBorder(
                            borderRadius: BorderRadius.circular(3)),
                        color: secondaryColor,
                        icon: value2.User_image == ""
                            ? const CircleAvatar(
                                backgroundColor: secondaryColor,
                                backgroundImage: AssetImage(
                                    'assets/images/defaultAccountIcon.png'),
                              )
                            : value2.User_image.split('/').toList()[0] ==
                                    'assets'
                                ? CircleAvatar(
                                    backgroundColor: secondaryColor,
                                    backgroundImage:
                                        AssetImage(value2.User_image),
                                  )
                                : CircleAvatar(
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
                padding:
                    const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(
                        decelerationRate: ScrollDecelerationRate.normal),
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
                          splashColor: cglasscolor,
                          highlightColor: Colors.transparent,
                          onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const ImageGenerateScreen())),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Container(
                                    height: MediaQuery.of(context).size.width *
                                        0.12,
                                    width: MediaQuery.of(context).size.width *
                                        0.12,
                                    decoration: BoxDecoration(
                                        color: const Color.fromRGBO(
                                            121, 80, 224, 1),
                                        borderRadius: BorderRadius.circular(5)),
                                    child: const Icon(
                                      Icons.image,
                                      color: Colors.white,
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "Image generation",
                                        style: GoogleFonts.nunito(
                                            color: Colors.white70,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600),
                                      ),
                                      Text("Generate and edit images",
                                          style: GoogleFonts.nunito(
                                              color: Colors.grey,
                                              fontSize: 15,
                                              fontWeight: FontWeight.w500))
                                    ],
                                  ),
                                ],
                              ),
                              CustomBackButton(
                                onTap: () => Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const ImageGenerateScreen())),
                              )
                            ],
                          ),
                        ),
                        const SizedBox(height: 20),
                        SizedBox(
                          child: InkWell(
                            splashColor: cglasscolor,
                            highlightColor: Colors.transparent,
                            onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const ChatScreen()),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      height:
                                          MediaQuery.of(context).size.width *
                                              0.12,
                                      width: MediaQuery.of(context).size.width *
                                          0.12,
                                      decoration: BoxDecoration(
                                          color: const Color.fromRGBO(
                                              51, 196, 145, 1),
                                          borderRadius:
                                              BorderRadius.circular(5)),
                                      child: const Icon(
                                        Icons.edit,
                                        color: Colors.white,
                                      ),
                                    ),
                                    SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.02),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Text completion",
                                          style: GoogleFonts.nunito(
                                              color: Colors.white70,
                                              fontSize: 16,
                                              fontWeight: FontWeight.w600),
                                        ),
                                        Text("Generate and edit text",
                                            style: GoogleFonts.nunito(
                                                color: Colors.grey,
                                                fontSize: 16,
                                                fontWeight: FontWeight.w500))
                                      ],
                                    ),
                                  ],
                                ),
                                CustomBackButton(
                                  onTap: () => Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const ChatScreen()),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.018,
                        ),
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
                          height: MediaQuery.of(context).size.height * 0.017,
                        ),
                        SizedBox(
                          child: ListView.builder(
                            // primary: false,
                            shrinkWrap: true,
                            physics: const BouncingScrollPhysics(
                                decelerationRate:
                                    ScrollDecelerationRate.normal),
                            itemCount:
                                textCompletionProvider.allMessages.length > 4
                                    ? 4
                                    : textCompletionProvider.allMessages.length,
                            itemBuilder: (context, index) =>
                                textCompletionProvider.allMessages.isEmpty
                                    ? const Center(
                                        child: Text('No items in the list.'),
                                      )
                                    : ConversationItem(
                                        firstMessage: textCompletionProvider
                                                    .allMessages[index].length >
                                                1
                                            ? textCompletionProvider
                                                .allMessages[index][1][0]
                                                .message_text
                                            : textCompletionProvider
                                                .allMessages[index][0][0]
                                                .message_text,
                                        timeStamp: textCompletionProvider
                                                    .allMessages[index].length >
                                                1
                                            ? textCompletionProvider
                                                .allMessages[index][1][0]
                                                .timeStamp
                                            : textCompletionProvider
                                                .allMessages[index][0][0]
                                                .timeStamp,
                                        index: textCompletionProvider
                                                    .allMessages[index].length >
                                                1
                                            ? textCompletionProvider
                                                .allMessages[index][1][0]
                                                .sessionId
                                            : textCompletionProvider
                                                .allMessages[index][0][0]
                                                .sessionId,
                                      ),
                          ),
                        ),
                      ],
                    )),
              ),
            ));
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
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ));
}

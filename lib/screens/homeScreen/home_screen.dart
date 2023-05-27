import 'package:chatgpt/screens/accountInfo/account_info.dart';
import 'package:chatgpt/screens/chatScreen/chatScreen.dart';
import 'package:chatgpt/screens/homeScreen/conversation_list.dart';
import 'package:chatgpt/screens/homeScreen/menu_items.dart';
import 'package:chatgpt/screens/settingsScreen/settings_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../CommonWidgets/sign_out_dialog.dart';
import '../../models/home_screen_menu_item.dart';
import '../../util/constants/constants.dart';
import '../imageGenerationScreen/image_generate_screen.dart';
import 'package:share_plus/share_plus.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: bgColor,
        elevation: 0,
        title: const Text(
          "OpenAI",
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
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
                icon: const CircleAvatar(
                  backgroundImage:
                      AssetImage('assets/images/default_avatar.png'),
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
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'AI Tools',
              style: GoogleFonts.nunito(
                  color: cgSecondary,
                  fontWeight: FontWeight.bold,
                  fontSize: 15),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.005,
            ),
            InkWell(
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ChatScreen()),
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
                    children: const [
                      Text(
                        "Text completion",
                        style: TextStyle(
                            color: Colors.white70,
                            fontSize: 18,
                            fontWeight: FontWeight.w500),
                      ),
                      Text("Generate and edit text",
                          style: TextStyle(
                              color: Colors.grey,
                              fontSize: 16,
                              fontWeight: FontWeight.w300))
                    ],
                  )
                ],
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.01,
            ),
            Text(
              'Resent Chats',
              style: GoogleFonts.nunito(
                  color: cgSecondary,
                  fontWeight: FontWeight.bold,
                  fontSize: 15),
            ),
            const Flexible(flex: 2, child: ConversationList()),
            const SizedBox(height: 20),
            InkWell(
              onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const ImageGenerateScreen())),
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
                    children: const [
                      Text(
                        "Image generation",
                        style: TextStyle(
                            color: Colors.white70,
                            fontSize: 20,
                            fontWeight: FontWeight.w700),
                      ),
                      Text("Generate and edit images",
                          style: TextStyle(
                              color: Colors.white54,
                              fontSize: 17,
                              fontWeight: FontWeight.w500))
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
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

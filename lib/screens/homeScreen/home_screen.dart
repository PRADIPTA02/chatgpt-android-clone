import 'package:chatgpt/constants.dart';
import 'package:chatgpt/screens/chatScreen/chatScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../imageGenerationScreen/image_generate_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: bgColor,
        elevation: 0,
        title: Text(
          "OpenAI",
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
              onPressed: () => {},
              icon: Icon(
                Icons.settings_outlined,
                size: 30,
                color: Colors.white70,
              )),
        ],
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
        ),
      ),
      backgroundColor: bgColor,
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: ListView(
          children: [
            Center(
              child: Image.asset("assets/images/logo.png"),
            ),
            SizedBox(
              height: 20,
            ),
            InkWell(
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ChatScreen()),
              ),
              child: Row(
                children: [
                  Container(
                    height: 50,
                    width: 50,
                    child: Icon(
                      Icons.edit,
                      color: Colors.white,
                    ),
                    decoration: BoxDecoration(
                        color: Color.fromRGBO(51, 196, 145, 1),
                        borderRadius: BorderRadius.circular(5)),
                  ),
                  SizedBox(width: 8),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Text completion",
                        style: TextStyle(
                            color: Colors.white70,
                            fontSize: 20,
                            fontWeight: FontWeight.w700),
                      ),
                      Text("Generate and edit text",
                          style: TextStyle(
                              color: Colors.white54,
                              fontSize: 17,
                              fontWeight: FontWeight.w500))
                    ],
                  )
                ],
              ),
            ),
            SizedBox(height: 20),
            InkWell(
              onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ImageGenerateScreen())),
              child: Row(
                children: [
                  Container(
                    height: 50,
                    width: 50,
                    child: Icon(
                      Icons.image,
                      color: Colors.white,
                    ),
                    decoration: BoxDecoration(
                        color: Color.fromRGBO(121, 80, 224, 1),
                        borderRadius: BorderRadius.circular(5)),
                  ),
                  SizedBox(width: 8),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
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
            )
          ],
        ),
      ),
    );
  }
}

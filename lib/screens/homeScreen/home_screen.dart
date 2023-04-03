import 'package:chatgpt/screens/chatScreen/chatScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../util/constants/constants.dart';
import '../imageGenerationScreen/image_generate_screen.dart';

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
          IconButton(
              onPressed: () => {},
              icon: const Icon(
                Icons.settings_outlined,
                size: 30,
                color: Colors.white70,
              )),
        ],
        systemOverlayStyle: const SystemUiOverlayStyle(
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
            const SizedBox(
              height: 20,
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
            )
          ],
        ),
      ),
    );
  }
}

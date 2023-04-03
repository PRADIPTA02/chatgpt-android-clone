import 'package:chatgpt/screens/imageGenerationScreen/text_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../../util/constants/constants.dart';
import '../../providers/image_generation_provider.dart';
import 'image_frame.dart';

class ImageGenerateScreen extends StatelessWidget {
  const ImageGenerateScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: bgColor,
        elevation: 0,
        title: Text(
          "Image Generation",
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
              onPressed: () => {},
              icon: Icon(
                Icons.menu_rounded,
                size: 30,
                color: Colors.white70,
              )),
        ],
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
        ),
      ),
      backgroundColor: bgColor,
      body: Consumer<ImageGenerationProvider>(
        builder: (context, value, child) => Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(children: [
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: SearchTextInput(),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: GridView.builder(
                    itemCount: value.AllImages.length,
                    physics: BouncingScrollPhysics(
                        decelerationRate: ScrollDecelerationRate.fast),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2),
                    itemBuilder: (BuildContext context, index) =>
                        ImageFrame(url: value.AllImages[index].url)),
              ),
            )
          ]),
        ),
      ),
    );
  }
}

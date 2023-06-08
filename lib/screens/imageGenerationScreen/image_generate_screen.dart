import 'package:chatgpt/screens/imageGenerationScreen/image_option_dialog.dart';
import 'package:chatgpt/screens/imageGenerationScreen/text_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
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
        title: const Text(
          "Image Generation",
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
        ),
        actions: [
          Consumer<ImageGenerationProvider>(
              builder: (context, value, child) => PopupMenuButton<String>(
                    color: bgColor,
                    icon: value.GetImageViewType == 'grid'
                        ? const Icon(
                            Icons.grid_view,
                            color: Colors.white,
                          )
                        : const Icon(
                            Icons.list_rounded,
                            color: Colors.white,
                          ),
                    position: PopupMenuPosition
                        .under, // Icon for the popup menu button
                    onSelected: (newValue) {
                      value.changeImageViewType(newValue);
                    },
                    itemBuilder: (BuildContext context) => [
                      PopupMenuItem<String>(
                        value: 'grid',
                        child: Row(
                          children: [
                            Icon(
                              Icons.grid_view,
                              color: value.GetImageViewType == 'grid'
                                  ? Colors.white
                                  : Colors.white70,
                            ),
                          ],
                        ),
                      ),
                      PopupMenuItem<String>(
                        value: 'list',
                        child: Row(
                          children: [
                            Icon(
                              Icons.list_rounded,
                              color: value.GetImageViewType == 'grid'
                                  ? Colors.white70
                                  : Colors.white,
                            ),
                          ],
                        ),
                      ),
                    ],
                  )),
          IconButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return const ImageOptionDialog();
                  },
                );
              },
              icon: const Icon(
                Icons.more_vert_rounded,
                color: Colors.white,
                size: 30,
              ))
        ],
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
        ),
      ),
      backgroundColor: bgColor,
      body: Consumer<ImageGenerationProvider>(
        builder: (context, value, child) => Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(children: [
            const Padding(
              padding: EdgeInsets.all(5.0),
              child: SearchTextInput(),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
                onTap: value.giveRandomImageSuggetion,
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: const BoxDecoration(
                      color: cglasscolor,
                      borderRadius: BorderRadius.all(Radius.circular(3))),
                  child: Text(
                    'Surprise me',
                    style: GoogleFonts.nunito(
                        color: cgSecondary,
                        fontWeight: FontWeight.bold,
                        fontSize: 16),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: GridView.builder(
                    itemCount: value.AllImages.length,
                    physics: const BouncingScrollPhysics(
                        decelerationRate: ScrollDecelerationRate.normal),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount:
                            value.GetImageViewType == 'grid' ? 2 : 1,
                        childAspectRatio:
                            value.GetImageViewType == 'list' ? 1.5 : 1.0,
                        mainAxisExtent: MediaQuery.of(context).size.height*0.40    
                            ),
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

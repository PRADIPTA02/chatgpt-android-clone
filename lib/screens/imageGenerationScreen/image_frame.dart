import 'package:chatgpt/providers/image_generation_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../util/constants/constants.dart';
import '../../util/constants/constants.dart';

class ImageFrame extends StatelessWidget {
  const ImageFrame({super.key, required this.url});
  final String url;

  @override
  Widget build(BuildContext context) {
    return Consumer<ImageGenerationProvider>(
        builder: (context, value, child) => Padding(
              padding: const EdgeInsets.all(3.0),
              child: Column(
                children: [
                  Container(
                    width: 450,
                    height: value.GetImageViewType == 'grid'? MediaQuery.of(context).size.height * 0.20: MediaQuery.of(context).size.height * 0.30,
                    decoration: const BoxDecoration(
                        border: Border(
                            top: BorderSide(color: cglasscolor, width: 2),
                            left: BorderSide(color: cglasscolor, width: 2),
                            right: BorderSide(color: cglasscolor, width: 2))),
                    child: Image.network(
                      url,
                      fit: BoxFit.fill,
                      loadingBuilder: (BuildContext context, Widget child,
                          ImageChunkEvent? loadingProgress) {
                        if (loadingProgress == null) return child;
                        return Center(
                          child: CircularProgressIndicator(
                            color: cgSecondary,
                            backgroundColor:
                                const Color.fromRGBO(73, 111, 101, 1),
                            value: loadingProgress.expectedTotalBytes != null
                                ? loadingProgress.cumulativeBytesLoaded /
                                    loadingProgress.expectedTotalBytes!
                                : null,
                          ),
                        );
                      },
                    ),
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height * 0.08,
                    color: cglasscolor,
                  )
                ],
              ),
            ));
  }
}

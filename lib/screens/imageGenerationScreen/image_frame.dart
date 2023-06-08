import 'package:chatgpt/providers/image_generation_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../util/constants/constants.dart';

class ImageFrame extends StatelessWidget {
  const ImageFrame({super.key, required this.url});
  final String url;
  final bool isFavourit = false;
  @override
  Widget build(BuildContext context) {
    return Consumer<ImageGenerationProvider>(
        builder: (context, value, child) => Padding(
              padding: const EdgeInsets.all(3.0),
              child: Column(
                children: [
                  Stack(
                    alignment: Alignment.topRight,
                    children: [
                      Container(
                        width: 450,
                        height: value.GetImageViewType == 'grid'
                            ? MediaQuery.of(context).size.height * 0.25
                            : MediaQuery.of(context).size.height * 0.30,
                        decoration: BoxDecoration(
                            border: value.GetImageViewType == 'grid'
                                ? Border.all(color: cglasscolor, width: 2)
                                : const Border(
                                    top: BorderSide(
                                        color: cglasscolor, width: 2),
                                    left: BorderSide(
                                        color: cglasscolor, width: 2),
                                    right: BorderSide(
                                        color: cglasscolor, width: 2),
                                  )),
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
                                value: loadingProgress.expectedTotalBytes !=
                                        null
                                    ? loadingProgress.cumulativeBytesLoaded /
                                        loadingProgress.expectedTotalBytes!
                                    : null,
                              ),
                            );
                          },
                        ),
                      ),
                      value.GetImageViewType == 'grid'
                          ? Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                PopupMenuButton(
                                    icon: const Icon(
                                      Icons.more_vert,
                                      color: cgSecondary,
                                    ),
                                    color: bgColor,
                                    itemBuilder: (context) => [
                                          PopupMenuItem<String>(
                                            value: 'download',
                                            child: Row(
                                              children: const [
                                                Icon(
                                                  Icons.download_rounded,
                                                  color: cgSecondary,
                                                )
                                              ],
                                            ),
                                          ),
                                          PopupMenuItem<String>(
                                            value: 'share',
                                            child: Row(
                                              children: const [
                                                Icon(
                                                  Icons.send_rounded,
                                                  color: Colors.white70,
                                                )
                                              ],
                                            ),
                                          ),
                                          PopupMenuItem(child: child)
                                        ]),
                                SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height * 0.13,
                                ),
                                IconButton(
                                    onPressed: null,
                                    icon: Icon(
                                      Icons.favorite_rounded,
                                      color: isFavourit
                                          ? cgSecondary
                                          : Colors.white70,
                                    ))
                              ],
                            )
                          : const SizedBox()
                    ],
                  ),
                  value.GetImageViewType == 'list'
                      ? Container(
                          height: MediaQuery.of(context).size.height * 0.06,
                          color: cglasscolor,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              IconButton(
                                  onPressed: null,
                                  icon: Icon(
                                    Icons.favorite_rounded,
                                    color: isFavourit
                                        ? secondaryColor
                                        : Colors.white70,
                                  )),
                              Row(
                                children: const [
                                  IconButton(
                                      onPressed: null,
                                      icon: Icon(
                                        Icons.download_rounded,
                                        color: cgSecondary,
                                      )),
                                  IconButton(
                                      onPressed: null,
                                      icon: Icon(
                                        Icons.send_rounded,
                                        color: Colors.white70,
                                      ))
                                ],
                              )
                            ],
                          ),
                        )
                      : const SizedBox()
                ],
              ),
            ));
  }
}

import 'dart:io';

import 'package:chatgpt/providers/image_generation_provider.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import '../../util/constants/constants.dart';

class ImageFrame extends StatefulWidget {
  const ImageFrame({super.key, required this.url});
  final String url;


  @override
  State<ImageFrame> createState() => _ImageFrameState();
}

class _ImageFrameState extends State<ImageFrame> {
  var time = DateTime.now().millisecondsSinceEpoch;
  final bool isFavourit = false;
  final dio = Dio();
  late double downloadProgross =0.0;
  late bool isDownload = false;
  late bool isDownloading = false;

   Future<bool> saveFile({required String imageUrl}) async {
    Directory? directory;
    try {
      if (await _requestPermission(Permission.storage)) {
        var newPath = "/storage/emulated/0/Download/image-AIBuddy-$time.jpg";
        directory = Directory(newPath);
        debugPrint(directory.path);
      } else {
        Fluttertoast.showToast(
            msg: "Permission Denied",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.white.withOpacity(0.1),
            textColor: Colors.white,
            fontSize: 16.0);
      }
      File saveFile = File(directory!.path);
      await dio.download(imageUrl, saveFile.path,
          onReceiveProgress: (rec, total) {
        setState(() {
          downloadProgross = (rec / total);
        });
      });
      return true;
    } catch (e) {
      return false;
    }
  }
  
   Future<bool> _requestPermission(Permission permission) async {
    if (await permission.isGranted) {
      return true;
    } else {
      var result = await permission.request();
      if (result == PermissionStatus.granted) {
        return true;
      } else {
        return false;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ImageGenerationProvider>(
        builder: (context, value, child) => Padding(
              padding: const EdgeInsets.all(2),
              child: Column(
                children: [
                  Expanded(
                    child: Container(
                      width: 450,
                      // height: value.GetImageViewType == 'grid'
                      //     ? MediaQuery.of(context).size.height * 0.25
                      //     : MediaQuery.of(context).size.height * 0.30,
                      decoration: BoxDecoration(
                          border: value.GetImageViewType == 'grid'
                              ? Border.all(color: cglasscolor, width: 2)
                              : const Border(
                                  top: BorderSide(color: cglasscolor, width: 2),
                                  left:
                                      BorderSide(color: cglasscolor, width: 2),
                                  right:
                                      BorderSide(color: cglasscolor, width: 2),
                                )),
                      child: Image.network(
                        widget.url,
                        fit: BoxFit.contain,
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
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    color: secondaryColor,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                            onPressed: null,
                            icon: Icon(
                              Icons.favorite_rounded,
                              color:
                                  isFavourit ? secondaryColor : Colors.white30,
                            )),
                        value.isImageDownloading
                            ? SizedBox(
                                height: 30,
                                width: 30,
                                child: CircularProgressIndicator(
                                  backgroundColor: cgSecondary.withOpacity(0.2),
                                  value: value.progress,
                                  valueColor:
                                      const AlwaysStoppedAnimation<Color>(
                                          cgSecondary),
                                ),
                              )
                            : IconButton(
                                onPressed: () => value.downloadImage(url: widget.url),
                                icon: const Icon(
                                  Icons.download_rounded,
                                  color: cgSecondary,
                                )),
                      ],
                    ),
                  )
                ],
              ),
            ));
  }
}

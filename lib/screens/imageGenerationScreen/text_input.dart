import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';

import '../../util/constants/constants.dart';
import '../../providers/image_generation_provider.dart';

class SearchTextInput extends StatelessWidget {
  const SearchTextInput({super.key});

  @override
  Widget build(BuildContext context) {
    final _imageGenerationProvider =
        Provider.of<ImageGenerationProvider>(context, listen: true);
    final spinKit = SpinKitThreeBounce(
      color: Colors.white70,
      size: 20.00,
    );

    return Consumer<ImageGenerationProvider>(
      builder: (context, value, child) => TextField(
        style: TextStyle(fontSize: 20, color: Colors.white70),
        minLines: 1,
        maxLines: 5,
        controller: _imageGenerationProvider.ImageInputControler,
        onChanged: _imageGenerationProvider.onChangeTextInput,
        cursorColor: cgSecondary,
        decoration: InputDecoration(
          isDense: true,
          isCollapsed: true,
          contentPadding: EdgeInsets.only(top: 8, bottom: 1, left: 5),
          suffixIcon: _imageGenerationProvider.isTyping
              ? !_imageGenerationProvider.isImageLoading
                  ? IconButton(
                      onPressed: () => {
                            _imageGenerationProvider.getImages(
                                _imageGenerationProvider
                                    .ImageInputControler.text),
                            _imageGenerationProvider.ImageInputControler
                                .clear(),
                            FocusManager.instance.primaryFocus?.unfocus(),
                          },
                      icon: Icon(Icons.send_rounded,
                          size: 30, color: cgSecondary))
                  : spinKit
              : AvatarGlow(
                  glowColor: Colors.blue,
                  endRadius: 25.0,
                  duration: Duration(milliseconds: 2000),
                  repeat: true,
                  showTwoGlows: true,
                  animate: value.isSpeaking,
                  repeatPauseDuration: Duration(milliseconds: 100),
                  child: IconButton(
                      splashColor: Colors.transparent,
                      onPressed: () => {
                            value.startListening(),
                          },
                      icon: Icon(
                        Icons.mic_none_outlined,
                        size: 30,
                        color: cgSecondary,
                      ))),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(3)),
              borderSide: BorderSide.none),
          filled: true,
          fillColor: secondaryColor,
        ),
      ),
    );
  }
}

import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../util/constants/constants.dart';
import '../../providers/image_generation_provider.dart';

class SearchTextInput extends StatelessWidget {
  const SearchTextInput({super.key});

  @override
  Widget build(BuildContext context) {
    final imageGenerationProvider =
        Provider.of<ImageGenerationProvider>(context, listen: true);
    const spinKit = SpinKitThreeBounce(
      color: Colors.white70,
      size: 20.00,
    );

    return Consumer<ImageGenerationProvider>(
      builder: (context, value, child) => TextField(
        style: TextStyle(fontSize: 20, color: Colors.white70),
        minLines: 1,
        maxLines: 5,
        controller: imageGenerationProvider.ImageInputControler,
        onChanged: imageGenerationProvider.onChangeTextInput,
        cursorColor: cgSecondary,
        decoration: InputDecoration(
          isDense: true,
          isCollapsed: true,
          contentPadding: const EdgeInsets.only(top: 8, bottom: 1, left: 5),
          suffixIcon: imageGenerationProvider.isTyping
              ? !imageGenerationProvider.isImageLoading
                  ? IconButton(
                      onPressed: () => {
                            imageGenerationProvider.getImages(
                                imageGenerationProvider
                                    .ImageInputControler.text),
                            imageGenerationProvider.ImageInputControler
                                .clear(),
                            FocusManager.instance.primaryFocus?.unfocus(),
                          },
                      icon: const Icon(Icons.send_rounded,
                          size: 30, color: cgSecondary))
                  : spinKit
              : AvatarGlow(
                  glowColor: Colors.blue,
                  endRadius: 25.0,
                  duration: const Duration(milliseconds: 2000),
                  repeat: true,
                  showTwoGlows: true,
                  animate: value.isSpeaking,
                  repeatPauseDuration: const Duration(milliseconds: 100),
                  child: IconButton(
                      splashColor: Colors.transparent,
                      onPressed: () => {
                            value.startListening(),
                          },
                      icon: const Icon(
                        Icons.mic_none_outlined,
                        size: 30,
                        color: cgSecondary,
                      ))),
          border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(3)),
              borderSide: BorderSide.none),
          filled: true,
          fillColor: secondaryColor,
        ),
      ),
    );
  }
}

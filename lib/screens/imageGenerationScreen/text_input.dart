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
      builder: (context, value, child) => Row(
        children: [
          Expanded(
            child: Builder(builder: (context) {
              return Stack(
                children: [
                  Scrollbar(
                    child: TextField(
                      style: GoogleFonts.nunito(
                          fontSize: 16, color: Colors.white70),
                      minLines: 1,
                      maxLines: 5,
                      controller: imageGenerationProvider.ImageInputControler,
                      onChanged: imageGenerationProvider.onChangeTextInput,
                      cursorColor: cgSecondary,
                      decoration: const InputDecoration(
                        isDense: true,
                        isCollapsed: true,
                        contentPadding:
                            EdgeInsets.only(top: 11, bottom: 11, left: 5),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(3)),
                            borderSide: BorderSide.none),
                        filled: true,
                        fillColor: secondaryColor,
                      ),
                    ),
                  ),
                  Visibility(
                    visible: imageGenerationProvider.isSpeaking,
                    child: Container(
                      height: 10,
                      width: 10,
                      // alignment: Alignment(200, 250),
                      margin: const EdgeInsets.only(top: 3, left: 3),
                      decoration: const BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.all(Radius.circular(50))),
                    ),
                  )
                ],
              );
            }),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.02,
          ),
          Container(
            height: MediaQuery.of(context).size.height * 0.055,
            width: MediaQuery.of(context).size.width * 0.12,
            decoration: BoxDecoration(
              color: cgSecondary,
              borderRadius: BorderRadius.circular(3),
            ),
            child: imageGenerationProvider.isTyping
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
                            size: 30, color: Colors.white))
                    : spinKit
                : AvatarGlow(
                    glowColor: Colors.white70,
                    endRadius: 25.0,
                    duration: const Duration(milliseconds: 2000),
                    repeat: true,
                    showTwoGlows: true,
                    animate: value.isSpeaking,
                    repeatPauseDuration: const Duration(milliseconds: 100),
                    child: InkWell(
                      onTapDown: (TapDownDetails details) =>
                          imageGenerationProvider.startListening(),
                      onTapUp: (TapUpDetails details) => value.stopListening(),
                      child: const Icon(
                        Icons.mic_none_outlined,
                        size: 30,
                        color: Colors.white70,
                      ),
                    )),
          )
        ],
      ),
    );
  }
}

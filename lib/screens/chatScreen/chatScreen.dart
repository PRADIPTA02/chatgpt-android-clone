import 'package:chatgpt/screens/chatScreen/chatscreen_sidebar.dart';
import 'package:chatgpt/screens/chatScreen/message_list.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../providers/internet_connection_check_provider.dart';
import '../../providers/text_copletion_provider.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import '../../CommonWidgets/internet_check_dialog.dart';
import 'package:chatgpt/models/message_model.dart';
import 'package:avatar_glow/avatar_glow.dart';
import 'package:uuid/uuid.dart';
import '../../util/constants/constants.dart';
import 'chat_input.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});
  @override
  Widget build(BuildContext context) {
    const uuid = Uuid();
    final textCompletionProvider =
        Provider.of<TextCompletProvider>(context, listen: false);
    const spinKit = SpinKitThreeBounce(
      color: Colors.white70,
      size: 20.00,
    );
    return Consumer2<TextCompletProvider, InterNetConnectionCheck>(
      builder: (context, textCompletProvider, interNetConnectionCheck, child) =>
          Scaffold(
              appBar: AppBar(
                automaticallyImplyLeading: false,
                title: Text(
                  textCompletionProvider.allSesions.isEmpty
                      ? ""
                      : textCompletionProvider
                          .allSesions[
                              textCompletionProvider.CurrentSessionIndex]
                          .sessionName,
                  style: GoogleFonts.nunito(
                      color: Colors.white70, fontWeight: FontWeight.bold),
                ),
                backgroundColor: bgColor,
                elevation: 0,
                leading: IconButton(
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  onPressed: () => {Navigator.pop(context)},
                  icon: const Icon(
                    Icons.arrow_back,
                    color: Colors.white70,
                  ),
                ),
                actions: [
                  Builder(builder: (context) {
                    return IconButton(
                        onPressed: () => {Scaffold.of(context).openDrawer()},
                        icon: const Icon(
                          Icons.menu_rounded,
                          size: 28,
                          color: Colors.white70,
                        ));
                  }),
                ],
              ),
              drawer: const ChatScreenSidebar(),
              backgroundColor: bgColor,
              body: Padding(
                padding: const EdgeInsets.all(8),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    const Expanded(child: MessegeList()),
                    Padding(
                      padding: const EdgeInsets.only(top: 5, right: 2),
                      child: Stack(
                        children: [
                          Row(
                            children: [
                              const Expanded(child: ChatInput()),
                              const SizedBox(
                                width: 8,
                              ),
                              Container(
                                height: 45,
                                width: 45,
                                decoration: BoxDecoration(
                                  color: cgSecondary,
                                  borderRadius: BorderRadius.circular(3),
                                ),
                                child: Center(
                                    child: textCompletionProvider.isLoading
                                        ? spinKit
                                        : !textCompletionProvider.isTyping
                                            ? AvatarGlow(
                                                glowColor: Colors.white70,
                                                endRadius: 75.0,
                                                duration: const Duration(
                                                    milliseconds: 2000),
                                                repeat: true,
                                                showTwoGlows: true,
                                                animate: textCompletProvider
                                                    .isSpeaking,
                                                repeatPauseDuration:
                                                    const Duration(
                                                        milliseconds: 100),
                                                child: InkWell(
                                                    onTapDown:
                                                        textCompletProvider
                                                            .startListening,
                                                    onTapUp: (TapUpDetails
                                                            details) =>
                                                        textCompletionProvider
                                                            .stopListening(),
                                                    child: const Icon(
                                                      Icons.mic_none_outlined,
                                                      size: 30,
                                                      color: Colors.white,
                                                    )))
                                            : IconButton(
                                                icon: const Icon(
                                                  Icons.send_rounded,
                                                  size: 25,
                                                  color: Colors.white,
                                                ),
                                                onPressed: () => {
                                                  if (!interNetConnectionCheck
                                                      .isOnline)
                                                    {
                                                      showDialog(
                                                        context: context,
                                                        builder: (BuildContext
                                                            context) {
                                                          return const InternetCheckDialog();
                                                        },
                                                      )
                                                    }
                                                  else if (textCompletionProvider
                                                              .chat_imput_Controler
                                                              .text !=
                                                          "" &&
                                                      !textCompletionProvider
                                                          .messageUpdateAvalable)
                                                    {
                                                      textCompletionProvider
                                                                  .allMessages
                                                                  .length <
                                                              textCompletionProvider
                                                                  .allSesions
                                                                  .length
                                                          ? textCompletionProvider
                                                              .changeSafetoScrollButton(
                                                                  false)
                                                          : null,
                                                      textCompletionProvider
                                                          .addMessage(
                                                        <Message>[
                                                          Message(
                                                              message_text:
                                                                  textCompletionProvider
                                                                      .chat_imput_Controler
                                                                      .text,
                                                              isApi: false,
                                                              id: uuid.v1(),
                                                              sessionId: textCompletionProvider
                                                                  .allSesions[
                                                                      textCompletionProvider
                                                                          .CurrentSessionIndex]
                                                                  .sessionId,
                                                              timeStamp: int
                                                                  .parse(DateTime
                                                                          .now()
                                                                      .millisecondsSinceEpoch
                                                                      .toString())),
                                                        ],
                                                        textCompletionProvider
                                                            .CurrentSessionIndex,
                                                      ),
                                                      textCompletionProvider.getAiResponse(
                                                          textCompletionProvider
                                                              .chat_imput_Controler
                                                              .text,
                                                          textCompletionProvider
                                                              .CurrentSessionIndex,
                                                          false),
                                                      textCompletionProvider
                                                          .chat_imput_Controler
                                                          .clear()
                                                    },
                                                },
                                              )),
                              )
                            ],
                          ),
                          Visibility(
                            visible: textCompletionProvider.isSpeaking,
                            child: Container(
                              height: 10,
                              width: 10,
                              // alignment: Alignment(200, 250),
                              margin: const EdgeInsets.only(top: 3, left: 3),
                              decoration: const BoxDecoration(
                                  color: Colors.red,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(50))),
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
              floatingActionButtonLocation:
                  FloatingActionButtonLocation.miniEndFloat,
              floatingActionButton: textCompletionProvider.safeToScroll
                  ? Container(
                      height: 35,
                      margin: const EdgeInsets.only(bottom: 100),
                      child: FloatingActionButton(
                          shape: const BeveledRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(3))),
                          backgroundColor: const Color.fromARGB(255, 33, 33, 33),
                          elevation: 0,
                          mini: true,
                          onPressed: () =>
                              {textCompletionProvider.scrollToTop()},
                          child: const Icon(
                            Icons.keyboard_double_arrow_down,
                            color: Colors.white,
                            size: 25,
                          )))
                  : null),
    );
  }
}

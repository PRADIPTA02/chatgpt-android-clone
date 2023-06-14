import 'package:chatgpt/screens/chatScreen/session_edit_dialog.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../CommonWidgets/confirm_dialog_box.dart';
import '../../providers/text_copletion_provider.dart';
import '../../util/constants/constants.dart';

class ChatScreenSidebar extends StatelessWidget {
  const ChatScreenSidebar({super.key});
  @override
  Widget build(BuildContext context) {
    final _textCompletionProvider =
        Provider.of<TextCompletProvider>(context, listen: false);
    return Drawer(
      width: MediaQuery.of(context).size.width * 0.75,
      backgroundColor: const Color.fromARGB(255, 9, 9, 9),
      shadowColor: Colors.transparent,
      child: SafeArea(
        child: Padding(
          padding:
              const EdgeInsets.only(top: 20, bottom: 20, left: 10, right: 10),
          child: Consumer<TextCompletProvider>(
            builder: (context, value, child) => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Conversation",
                    style: GoogleFonts.nunito(
                        color: Colors.white70,
                        fontSize: 24,
                        fontWeight: FontWeight.w700)),
                        // const Divider(color: cglasscolor,thickness: 0.3,),
                        SizedBox(height:MediaQuery.of(context).size.height*0.03),
                InkWell(
                  onTap: () => {
                    _textCompletionProvider.addNewSession(),
                  },
                  child: Container(
                    padding: const EdgeInsets.only(
                        top: 15, bottom: 15, left: 10, right: 10),
                    decoration: BoxDecoration(
                      border: Border.all(color:Colors.white30),
                      borderRadius: const BorderRadius.all(Radius.circular(5)),
                    ),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.add,
                          size: 20,
                          color: Colors.white60,
                        ),
                        const SizedBox(width: 10),
                        Text(
                          "New chat",
                          style: GoogleFonts.nunito(
                              color: Colors.white60,
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Scrollbar(
                    child: ListView.builder(
                      scrollDirection: Axis.vertical,
                      physics: const BouncingScrollPhysics(
                          decelerationRate: ScrollDecelerationRate.fast),
                      itemCount: _textCompletionProvider.allSesions.length,
                      itemBuilder: (context, index) => InkWell(
                        splashColor: Colors.transparent,
                        onTap: () => {
                          _textCompletionProvider.changeShowSaveAndCancelButton(
                              "", false),
                          _textCompletionProvider
                              .changeSessionDeletation(false),
                          _textCompletionProvider.setMessageUpdate(false, ""),
                          _textCompletionProvider.changeIsloadingState(false),
                          _textCompletionProvider.changeCurrentSessionIndex(
                              _textCompletionProvider.allSesions.length -
                                  1 -
                                  index),
                          _textCompletionProvider
                              .changeSafetoScrollButton(false),
                          FocusManager.instance.primaryFocus?.unfocus(),
                          Navigator.pop(context),
                        },
                        child: Container(
                          padding: const EdgeInsets.only(
                              top: 15, bottom: 15, left: 10, right: 10),
                          margin: const EdgeInsets.only(top: 10),
                          decoration: BoxDecoration(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(5)),
                              color: _textCompletionProvider.allSesions.length -
                                          1 -
                                          _textCompletionProvider
                                              .CurrentSessionIndex ==
                                      index
                                  ? secondaryColor.withOpacity(0.7)
                                  : Colors.transparent),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Row(
                                  children: [
                                    Icon(
                                      _textCompletionProvider
                                                  .isSessionDeleting &&
                                              _textCompletionProvider
                                                      .sessionIndex ==
                                                  index
                                          ? Icons.delete_forever
                                          : Icons.chat_bubble_outline,
                                      size: 20,
                                      color: Colors.white70,
                                    ),
                                    const SizedBox(width: 10),
                                    Expanded(
                                      child: Text(
                                        _textCompletionProvider
                                            .allSesions[_textCompletionProvider
                                                    .allSesions.length -
                                                1 -
                                                index]
                                            .sessionName
                                            .toString(),
                                        style: GoogleFonts.nunito(
                                            color: Colors.white70,
                                            fontSize: 15,
                                            fontWeight: FontWeight.w600),
                                        maxLines: 1,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              _textCompletionProvider.allSesions.length -
                                          1 -
                                          _textCompletionProvider
                                              .CurrentSessionIndex ==
                                      index
                                  ? Row(
                                      children: [
                                        InkWell(
                                          onTap: () => {
                                            if (_textCompletionProvider
                                                .isSessionDeleting)
                                              {
                                                _textCompletionProvider
                                                    .deleteSession(
                                                        _textCompletionProvider
                                                                .allSesions[
                                                            _textCompletionProvider
                                                                    .allSesions
                                                                    .length -
                                                                1 -
                                                                index],
                                                        _textCompletionProvider
                                                                .allSesions
                                                                .length -
                                                            1 -
                                                            index),
                                                _textCompletionProvider
                                                    .changeSessionDeletation(
                                                        false),
                                                _textCompletionProvider
                                                    .setSessionIndex(-1),
                                              }
                                            else
                                              {
                                                showDialog(
                                                  context: context,
                                                  builder:
                                                      (BuildContext context) {
                                                    return SessionEditDialog(
                                                        sessionName: _textCompletionProvider
                                                            .allSesions[
                                                                _textCompletionProvider
                                                                        .allSesions
                                                                        .length -
                                                                    1 -
                                                                    index]
                                                            .sessionName,
                                                        sessionIndex:
                                                            _textCompletionProvider
                                                                    .allSesions
                                                                    .length -
                                                                1 -
                                                                index);
                                                  },
                                                )
                                              }
                                          },
                                          child: Icon(
                                            _textCompletionProvider
                                                        .isSessionDeleting &&
                                                    _textCompletionProvider
                                                            .sessionIndex ==
                                                        index
                                                ? Icons.done
                                                : Icons.edit,
                                            size: 20,
                                            color: Colors.white70,
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 8,
                                        ),
                                        InkWell(
                                          onTap: () => {
                                            _textCompletionProvider
                                                .changeSessionDeletation(
                                                    _textCompletionProvider
                                                            .isSessionDeleting
                                                        ? false
                                                        : true),
                                            _textCompletionProvider
                                                .setSessionIndex(index)
                                          },
                                          child: Icon(
                                              _textCompletionProvider
                                                          .isSessionDeleting &&
                                                      _textCompletionProvider
                                                              .sessionIndex ==
                                                          index
                                                  ? Icons.close
                                                  : Icons
                                                      .delete_outline_rounded,
                                              size: 20,
                                              color: _textCompletionProvider
                                                          .isSessionDeleting &&
                                                      _textCompletionProvider
                                                              .sessionIndex ==
                                                          index
                                                  ? Colors.white70
                                                  : cgSecondary),
                                        )
                                      ],
                                    )
                                  : const SizedBox()
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                 Divider(
                  thickness: 0.3,
                  color: cglasscolor.withOpacity(0.2),
                ),
                InkWell(
                  onTap: () => showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return ConfirmDialogBox(
                          confirm_message:
                              "This action will clear all conversations permanently.Are you sure you want to proceed!",
                          title: "Clear All Conversations",
                          onOK: _textCompletionProvider.clearConversations,
                        );
                      }),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        const Icon(Icons.delete_forever_rounded,
                            color: cgSecondary),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.01,
                        ),
                        Text(
                          'Clear conversations',
                          style: GoogleFonts.nunito(
                              fontSize: 16,
                              color: Colors.white60,
                              fontWeight: FontWeight.w600
                              ),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

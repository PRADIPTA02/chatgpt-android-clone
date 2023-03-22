import 'package:chatgpt/constants.dart';
import 'package:chatgpt/screens/chatScreen/session_edit_dialog.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/text_copletion_provider.dart';

class ChatScreenSidebar extends StatelessWidget {
  const ChatScreenSidebar({super.key});

  @override
  Widget build(BuildContext context) {
    final _textCompletionProvider =
        Provider.of<TextCompletProvider>(context, listen: false);
    return Drawer(
      backgroundColor: bgColor,
      shadowColor: Colors.transparent,
      child: SafeArea(
        child: Padding(
          padding:
              const EdgeInsets.only(top: 20, bottom: 20, left: 10, right: 10),
          child: Consumer<TextCompletProvider>(
            builder: (context, value, child) => Column(
              children: [
                InkWell(
                  onTap: () => {
                    _textCompletionProvider.addNewSession(),
                  },
                  child: Container(
                    padding: const EdgeInsets.only(
                        top: 15, bottom: 15, left: 10, right: 10),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.white70),
                      borderRadius: const BorderRadius.all(Radius.circular(5)),
                    ),
                    child: Row(
                      children: const [
                        Icon(
                          Icons.add,
                          size: 20,
                          color: Colors.white70,
                        ),
                        SizedBox(width: 10),
                        Text(
                          "New chat",
                          style: TextStyle(
                              color: Colors.white70,
                              fontSize: 18,
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
                          _textCompletionProvider.changeSessionDeletation(false),
                              _textCompletionProvider.setMessageUpdate(false,""),
                          _textCompletionProvider.changeIsloadingState(),
                          _textCompletionProvider.changeCurrentSessionIndex(
                              _textCompletionProvider.allSesions.length -
                                  1 -
                                  index),
                                  _textCompletionProvider.changeSafetoScrollButton(false),
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
                                  ? secondaryColor
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
                                        style: const TextStyle(
                                            color: Colors.white70,
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold),
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
                                                    .changeSessionDeletation(false),
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
                                                .changeSessionDeletation(_textCompletionProvider.isSessionDeleting?false:true),
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
                                                : Icons.delete_outline_rounded,
                                            size: 20,
                                            color: Colors.white70,
                                          ),
                                        )
                                      ],
                                    )
                                  : SizedBox()
                            ],
                          ),
                        ),
                      ),
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
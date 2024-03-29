// ignore_for_file: use_build_context_synchronously, non_constant_identifier_names, prefer_final_fields
import 'dart:convert';
import 'package:chatgpt/models/error_message_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_list_view/flutter_list_view.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hive/hive.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';
import '../models/message_list_conversation.dart';
import '../models/message_model.dart';
import 'package:uuid/uuid.dart';
import '../models/message_session_list_model.dart';

class TextCompletProvider with ChangeNotifier {
  late Box<MessageSessionList> sessions;
  late Box<Conversation> listOfAllMessages;
  final SpeechToText _speechToText = SpeechToText();
  TextCompletProvider() {
    sessions = Hive.box('sessionList');
    listOfAllMessages = Hive.box('messageList');

    if (sessions.values.toList().isEmpty) {
      addNewSession();
    }
    _chatScroollCrontrol.addListener(scrollListener);
    _all_sessions = sessions.values.toList();
    _current_session_index = sessions.values.toList().length - 1;
    _all_messages =
        listOfAllMessages.values.toList().map((e) => e.messages).toList();
    notifyListeners();
  }
  final Dio dio = Dio();
  final uuid = const Uuid();
  double maxPosition = double.minPositive;
  int _message_no = 0;
  bool _safe_to_scroll = false;
  bool _isLoading = false; //using for check
  bool _isTyping = false;
  bool _is_speaking = false;
  bool _is_avalable = false;
  String _save_and_cancel_button = "";
  bool _is_session_deleting = false;
  bool _is_keyboard_active = false;
  bool get isKeyboardActive => _is_keyboard_active;
  int _session_index = 0;
  int _current_session_index = 0;
  final _chat_imput_Controler = TextEditingController();
  TextEditingController get chat_imput_Controler => _chat_imput_Controler;
  final FlutterListViewController _chatScroollCrontrol =
      FlutterListViewController();
  FlutterListViewController get chatScrollControler => _chatScroollCrontrol;
  bool get isLoading => _isLoading;
  int get message_no => _message_no;
  String get save_and_cancel_button => _save_and_cancel_button;
  bool get isTyping => _isTyping;
  bool get isSpeaking => _is_speaking;
  bool get safeToScroll => _safe_to_scroll;
  bool _message_update_avalable = false;
  bool get messageUpdateAvalable => _message_update_avalable; //update message
  bool get isSessionDeleting => _is_session_deleting;
  int get CurrentSessionIndex => _current_session_index;
  int get sessionIndex => _session_index;
  List<List<Message>> get messages => _message_list;
  List<ErroMessage> get errorMessages => _error_messags;
  List<List<Message>> _message_list = [];
  List<ErroMessage> _error_messags = [];
  List<MessageSessionList> _all_sessions = [];
  List<MessageSessionList> get allSesions => _all_sessions;
  List<List<List<Message>>> _all_messages = [];
  List<List<List<Message>>> get allMessages => _all_messages;

  void changeSessionDeletation(bool value) {
    _is_session_deleting = value;
    notifyListeners();
  }

  void changeCurrentSessionIndex(int index) {
    _current_session_index = index;
    notifyListeners();
  }

  void setSessionIndex(int index) {
    _session_index = index;
    notifyListeners();
  }

  void increase(int length) {
    _message_no = ++_message_no % length;
    notifyListeners();
  }

  void changeShowSaveAndCancelButton(String id, bool show) {
    show ? _save_and_cancel_button = id : _save_and_cancel_button = "";
    notifyListeners();
  }

  void changeSafetoScrollButton(bool value) {
    _safe_to_scroll = value;
    notifyListeners();
  }

  void scrollListener() {
    if (_chatScroollCrontrol.offset > 0.0) {
      _safe_to_scroll = true;
    } else {
      _safe_to_scroll = false;
    }
    notifyListeners();
  }

  void setMessageUpdate(bool value, String messageText) {
    if (value) {
      _chat_imput_Controler.text = messageText;
      _isTyping = value;
    } else {
      _chat_imput_Controler.text = "";
    }
    _message_update_avalable = value;
    notifyListeners();
  }

//Get the api response from api endpoint and add this to message list
  Future<String> getAiResponse(
      String question, int index, bool isupdate) async {
    _isLoading = true;
    var headers = {
      'Content-Type': 'application/json',
      'Authorization':
          'Bearer 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',
    };
    try {
      var url = "https://api.openai.com/v1/completions";
      var payload = {
        "model": "text-davinci-003",
        "prompt": question,
        "temperature": 0.6,
        "max_tokens": 3457,
        "top_p": 0.1,
        "frequency_penalty": 1,
        "presence_penalty": 1
      };
      var response = await dio.post(url,
          data: jsonEncode(payload),
          options: Options(
            headers: headers,
          ));

      if (response.statusCode == 200 && !isupdate) {
        Map<String, dynamic> newResponse = response.data;
        addMessage(<Message>[
          Message(
              message_text: newResponse['choices'][0]['text'],
              isApi: true,
              id: uuid.v1(),
              sessionId: sessions.values.toList()[index].sessionId,
              timeStamp:
                  int.parse(DateTime.now().millisecondsSinceEpoch.toString())),
        ], index);
        _isLoading = false;
        onChangeTextInput("");
      } else if (!isupdate) {
        Map<String, dynamic> newResponse = response.data;
        _isLoading = false;
        Fluttertoast.showToast(
            msg: newResponse['choices'][0]['text'],
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.TOP,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
        onChangeTextInput("");
      }
      if (isupdate) {
        Map<String, dynamic> newResponse = response.data;
        _isLoading = false;
        return newResponse['choices'][0]['text'];
      } else {
        return "";
      }
    } catch (e) {
      changeIsloadingState(false);
      Fluttertoast.showToast(
          msg: "Something went wrong",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.TOP,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
      notifyListeners();
      return "";
    }
  }

// Add a new message to the messageList
  void addMessage(List<Message> message, int index) {
    if (index <= sessions.values.toList().length - 1 &&
        message[0].sessionId == sessions.values.toList()[index].sessionId) {
      if (index > listOfAllMessages.values.toList().length - 1) {
        late List<List<Message>> convertedMessageList = [message];
        listOfAllMessages.add(Conversation(messages: convertedMessageList));
        listOfAllMessages.values.toList()[0].save();
        updateSession(sessions.values.toList()[index], message[0].message_text);
      } else {
        Conversation tempMessageList = listOfAllMessages.values.toList()[index];
        List<List<Message>> convertedMessageList = tempMessageList.messages;
        convertedMessageList.add(message);
        tempMessageList = Conversation(messages: convertedMessageList);
        listOfAllMessages.values.toList()[index].save();
      }
    }
    _all_messages =
        listOfAllMessages.values.toList().map((e) => e.messages).toList();

    notifyListeners();
  }

  void updateMessage(
      int index, String id, int sessionIndex, BuildContext context) async {
    Conversation tempMessageList =
        listOfAllMessages.values.toList()[sessionIndex];
    List<List<Message>> convertedMessageList = tempMessageList.messages;
    if (_message_update_avalable) {
      if (index > 0 && index <= convertedMessageList.length - 1) {
        if (convertedMessageList[index - 1][0].isApi) {
          var messageText = _chat_imput_Controler.text;
          _chat_imput_Controler.text = "";
          _save_and_cancel_button = "";
          Message tempUserMessage = Message(
            sessionId: sessions.values.toList()[sessionIndex].sessionId,
            message_text: messageText,
            isApi: false,
            id: uuid.v4(),
            timeStamp:
                int.parse(DateTime.now().millisecondsSinceEpoch.toString()),
          );
          convertedMessageList[index].add(tempUserMessage);
          listOfAllMessages.values.toList()[sessionIndex].save();
          listOfAllMessages.values
              .toList()[sessionIndex]
              .messages[index][0]
              .indexOfUpdateMessage = listOfAllMessages.values
                  .toList()[sessionIndex]
                  .messages[index]
                  .length -
              1;

          notifyListeners();
          Message tempApiMessage = Message(
            sessionId: sessions.values.toList()[sessionIndex].sessionId,
            message_text:
                await getAiResponse(messageText, sessionIndex, true),
            isApi: true,
            id: uuid.v4(),
            timeStamp:
                int.parse(DateTime.now().millisecondsSinceEpoch.toString()),
          );
          convertedMessageList[index - 1].add(tempApiMessage);
          tempMessageList = Conversation(messages: convertedMessageList);
          listOfAllMessages.values.toList()[sessionIndex].save();
          listOfAllMessages.values
              .toList()[sessionIndex]
              .messages[index - 1][0]
              .indexOfUpdateMessage = listOfAllMessages.values
                  .toList()[sessionIndex]
                  .messages[index - 1]
                  .length -
              1;
          _message_update_avalable = false;
        }
      }
    }
    notifyListeners();
  }

  void deleteMessage() {}

  //add new session  when sessions.length == messageList.length

  void addNewSession() async {
    if (listOfAllMessages.values.length == sessions.values.length) {
      final MessageSessionList session =
          MessageSessionList(sessionId: uuid.v1(), sessionName: "New Chat");
      await sessions.add(session);
      await session.save();
      _all_sessions = sessions.values.toList();
      _current_session_index = sessions.values.toList().length - 1;
    }
    notifyListeners();
  }

  void isSassionAvailable() {
    if (listOfAllMessages.values.length == sessions.values.length) {
      addNewSession();
    } else {
      _all_sessions = sessions.values.toList();
      _current_session_index = sessions.values.toList().length - 1;
    }
  }

// Delete a session along with messagelist linked with session
  Future<void> deleteSession(MessageSessionList session, int index) async {
    if (sessions.values.toList().length == 1 &&
        listOfAllMessages.values.toList().length == 1) {
      addNewSession();
      await session.delete();
      await listOfAllMessages.values.toList()[index].delete();
      _all_sessions = sessions.values.toList();
      _current_session_index = sessions.values.toList().length - 1;
    } else if (sessions.values.toList().length != 1 &&
        listOfAllMessages.values.toList().length - 1 < index) {
      await session.delete();
      _all_sessions = sessions.values.toList();
      _current_session_index = index == 0
          ? sessions.values.toList().length - 1 == 0
              ? 0
              : _current_session_index + 1
          : index - 1;
    } else if (listOfAllMessages.values.toList().length - 1 >= index) {
      await session.delete();
      _all_sessions = sessions.values.toList();
      await listOfAllMessages.values.toList()[index].delete();
      _current_session_index = index == 0 ? 0 : index - 1;
    }
    _all_messages =
        listOfAllMessages.values.toList().map((e) => e.messages).toList();
    _isLoading = false;
    notifyListeners();
  }

  void updateSession(MessageSessionList session, String name) async {
    session.sessionName = name;
    session.save();
    notifyListeners();
  }

  Future<void> clearConversations() async {
    _isLoading = true;
    for (int i = allSesions.length - 1; i >= 0; i--) {
      await deleteSession(allSesions[i], i);
    }
    if (allSesions.isEmpty) {
      addNewSession();
    }
    _current_session_index = 0;
    _isLoading = false;
    notifyListeners();
  }

  void addErrorMessage(ErroMessage message) {
    _error_messags.clear();
    _error_messags.add(message);
    notifyListeners();
  }

  void scrollToTop() {
    _chatScroollCrontrol.jumpTo(0.0);
  }

  void onChangeTextInput(String text) {
    _isTyping = text != "" ? true : false;
    notifyListeners();
  }

  void startListening(TapDownDetails details) async {
    _is_avalable = await _speechToText.initialize();
    if (_is_avalable) {
      _speechToText.listen(onResult: _onSpeechResult, partialResults: false);
      _is_speaking = true;
    }
    notifyListeners();
  }

  void stopListening() async {
    await _speechToText.stop();
    _is_speaking = false;
    if (_chat_imput_Controler.text != "") {
      _chat_imput_Controler.text = _chat_imput_Controler.text;
      _isTyping = true;
    }
    notifyListeners();
  }

  void _onSpeechResult(SpeechRecognitionResult result) {
    _chat_imput_Controler.text = result.recognizedWords;
    if (!_speechToText.isListening) stopListening();

    notifyListeners();
  }

  void onExampleTextPressed(String text) {
    _chat_imput_Controler.text = text;
    _isTyping = true;
    notifyListeners();
  }

  void changeAnimate(int index, bool isCarouselMessage, int upperMessageIndex,
      int sessionIndex) {
    if (isCarouselMessage) {
      listOfAllMessages.values
          .toList()[_current_session_index]
          .messages[0][0]
          .isAnimate = false;
    } else {
      listOfAllMessages.values
          .toList()[_current_session_index]
          .messages[upperMessageIndex][index]
          .isAnimate = false;
    }
    listOfAllMessages.values.toList()[sessionIndex].save();
    notifyListeners();
  }

  void likeMessage(int index, String id, int sessionIndex, int upperIndex,
      bool isCarouselMessage) {
    if (!isCarouselMessage) {
      if (listOfAllMessages.values
              .toList()[sessionIndex]
              .messages
              .toList()[index][0]
              .id ==
          id) {
        var value = listOfAllMessages.values
            .toList()[sessionIndex]
            .messages
            .toList()[index][0]
            .isLiked;
        if (value == false) {
          listOfAllMessages.values
              .toList()[sessionIndex]
              .messages
              .toList()[index][0]
              .isDisLiked = false;
        }
        listOfAllMessages.values
            .toList()[sessionIndex]
            .messages
            .toList()[index][0]
            .isLiked = !value;
      }
    } else {
      if (listOfAllMessages.values
              .toList()[sessionIndex]
              .messages
              .toList()[upperIndex][index]
              .id ==
          id) {
        var value = listOfAllMessages.values
            .toList()[sessionIndex]
            .messages
            .toList()[upperIndex][index]
            .isLiked;
        if (value == false) {
          listOfAllMessages.values
              .toList()[sessionIndex]
              .messages
              .toList()[upperIndex][index]
              .isDisLiked = false;
        }
        listOfAllMessages.values
            .toList()[sessionIndex]
            .messages
            .toList()[upperIndex][index]
            .isLiked = !value;
      }
    }
    listOfAllMessages.values.toList()[sessionIndex].save();
    notifyListeners();
  }

  void disLikeMessage(int index, String id, int sessionIndex, int upperIndex,
      bool isCarouselMessage) {
    if (!isCarouselMessage) {
      if (listOfAllMessages.values
              .toList()[sessionIndex]
              .messages
              .toList()[index][0]
              .id ==
          id) {
        var value = listOfAllMessages.values
            .toList()[sessionIndex]
            .messages
            .toList()[index][0]
            .isDisLiked;
        if (value == false) {
          listOfAllMessages.values
              .toList()[sessionIndex]
              .messages
              .toList()[index][0]
              .isLiked = false;
        }
        listOfAllMessages.values
            .toList()[sessionIndex]
            .messages
            .toList()[index][0]
            .isDisLiked = !value;
      }
    } else {
      if (listOfAllMessages.values
              .toList()[sessionIndex]
              .messages
              .toList()[upperIndex][index]
              .id ==
          id) {
        var value = listOfAllMessages.values
            .toList()[sessionIndex]
            .messages
            .toList()[upperIndex][index]
            .isDisLiked;
        if (value == false) {
          listOfAllMessages.values
              .toList()[sessionIndex]
              .messages
              .toList()[upperIndex][index]
              .isLiked = false;
        }
        listOfAllMessages.values
            .toList()[sessionIndex]
            .messages
            .toList()[upperIndex][index]
            .isDisLiked = !value;
      }
    }
    listOfAllMessages.values.toList()[sessionIndex].save();
    notifyListeners();
  }

  void updateCarouselMessageLowerIndex(
      int sessionIndex, upperMessageIndex, int index) {
    var updateMessages = listOfAllMessages.values.toList()[sessionIndex];
    updateMessages.messages[upperMessageIndex][0].indexOfUpdateMessage = index;
    updateMessages.messages[upperMessageIndex + 1][0].indexOfUpdateMessage =
        index;
    listOfAllMessages.values.toList()[sessionIndex].save();
    notifyListeners();
  }

  void refresh() {
    _all_messages =
        listOfAllMessages.values.toList().map((e) => e.messages).toList();
    _isLoading = false;
    _chat_imput_Controler.text = "";
    _isTyping = false;
    _is_speaking = false;
    FocusManager.instance.primaryFocus?.unfocus();
    notifyListeners();
  }

  void changeIsloadingState(bool value) {
    _isLoading = value;
    notifyListeners();
  }
}

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../models/image_model.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';

class ImageGenerationProvider with ChangeNotifier {
  SpeechToText _speechToText = SpeechToText();
  bool _is_image_loading = false;
  bool _is_speaking = false;
  bool _is_avalable = false;
  bool _isTyping = false;
  int _number_of_images = 10;
  List<Images> _images = [];
  final _image_input_controller = TextEditingController();
  TextEditingController get ImageInputControler => _image_input_controller;
  int get numberOfImages => _number_of_images;
  List<Images> get AllImages => _images;
  bool get isImageLoading => _is_image_loading;
  bool get isTyping => _isTyping;
  bool get isSpeaking => _is_speaking;
  void getImages(String name) async {
    _images = [];
    setImageLoading();
    Map<String, String> header = {
      'Content-Type': 'application/json',
      'Authorization':
          'Bearer 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',
    };

    var response = await http.post(
        Uri.parse("https://api.openai.com/v1/images/generations"),
        headers: header,
        body: jsonEncode({
          "n": _number_of_images,
          "size": "256x256",
          "prompt": name,
        }));
    if (response.statusCode == 200) {
      Map<String, dynamic> newResponse = jsonDecode(response.body);
      for (dynamic item in newResponse['data']) {
        addImages(
            Images(url: item['url'], image_height: 256, image_widtht: 256));
      }
      setImageLoading();
      onChangeTextInput("");
    }
    notifyListeners();
  }

  void onChangeTextInput(String text) {
    _isTyping = text != "" ? true : false;
    notifyListeners();
  }

  void setImageLoading() {
    _is_image_loading = !_is_image_loading;
    notifyListeners();
  }

  void addImages(Images image) {
    _images.add(image);
  }

  void startListening() async {
    _is_speaking = true;
    _is_avalable = await _speechToText.initialize();
    if (_is_avalable) {
      _speechToText.listen(
        onResult: _onSpeechResult,
      );
    }
    notifyListeners();
  }

  void stopListening() async {
    await _speechToText.stop();
    _is_speaking = false;
    _isTyping = true;
    getImages(_image_input_controller.text);
    notifyListeners();
  }

  void _onSpeechResult(SpeechRecognitionResult result) {
    _image_input_controller.text = result.recognizedWords;
    if (!_speechToText.isListening) stopListening();
    notifyListeners();
  }
}

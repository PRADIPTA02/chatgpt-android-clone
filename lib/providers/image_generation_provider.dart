// ignore_for_file: non_constant_identifier_names

import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../CommonWidgets/custom_snakebar.dart';
import '../models/image_model.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';

class ImageGenerationProvider with ChangeNotifier {
  final SpeechToText _speechToText = SpeechToText();
  bool _is_image_loading = false;
  bool _is_speaking = false;
  bool _is_avalable = false;
  bool _isTyping = false;
  int _number_of_images = 1;
  String _size_of_images = '256x256';
  String _get_image_view_type = "List";
  String get GetImageViewType => _get_image_view_type;
  String get SizeOfImages => _size_of_images;
  List<Images> _images = [];
  final _image_input_controller = TextEditingController();
  TextEditingController get ImageInputControler => _image_input_controller;
  int get numberOfImages => _number_of_images;
  List<Images> get AllImages => _images;
  bool get isImageLoading => _is_image_loading;
  bool get isTyping => _isTyping;
  bool get isSpeaking => _is_speaking;
  final List<String> topImageGenerationSuggetion = [
    "earth reviving after human extinction, a new beginning, nature taking over buildings, animal kingdom, harmony, peace, earth balanced --version 3 --s 1250 --uplight --ar 4:3 --no text, blur",
    "earth after human extinction, a new beginning, nature taking back the planet, harmony, peace, earth balanced --version 3 --s 42000 --uplight --ar 4:3 --no text, blur, people, humans, pollution",
    "Freeform ferrofluids, beautiful dark chaos, swirling black frequency --ar 3:4 --iw 9 --q 2 --s 1250",
    "a home built in a huge Soap bubble, windows, doors, porches, awnings, middle of SPACE, cyberpunk lights, Hyper Detail, 8K, HD, Octane Rendering, Unreal Engine, V-Ray, full hd -- s5000 --uplight --q 3 --stop 80--w 0.5 --ar 1:3",
    "photo of an extremely cute alien fish swimming an alien habitable underwater planet, coral reefs, dream-like atmosphere, water, plants, peaceful, serenity, calm ocean, tansparent water, reefs, fish, coral, inner peace, awareness, silence, nature, evolution --version 3 --s 42000 --uplight --ar 4:3 --no text, blur",
    "ossuary cemetary segmented shelves overgrown, graveyard, vertical shelves, zdzisław beksiński, hr giger, mystical occult symbol in real life, high detail, green fog --ar 9:16 --iw 1",
    "Rubber Duck Aliens visiting the Earth for the first time, hyper-realistic, cinematic, detailed --ar 16:9",
    "noir detective mr. Rubber Duck. Smoke, rain, moustache and bravery. He can solve any puzzle. But can't beat his inner demons. Expressive dark matte gouche painting. --ar 4:5",
    "Reunion of man, team, squad, cyberpunk, abstract, full hd render + 3d octane render +4k UHD + immense detail + dramatic lighting + well lit + black, purple, blue, pink, cerulean, teal, metallic colours, + fine details + octane render + 8k",
    "rubber duck duke ellington. Harlem jazz club. Singing. Mic. Ambience",
  ];
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
          "size": _size_of_images,
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
      setImageLoading();
    }
    else{
    }
    setImageLoading();
    notifyListeners();
  }

  void giveRandomImageSuggetion() {
    final random = Random();
    final randomIndex = random.nextInt(topImageGenerationSuggetion.length);
    final randomString = topImageGenerationSuggetion[randomIndex];
    _image_input_controller.text = randomString;
    _isTyping = true;
    notifyListeners();
  }
  void changeImageViewType(String type){
    _get_image_view_type = type;
    notifyListeners();
  }
  void onChangeTextInput(String text) {
    _isTyping = text != "" ? true : false;
    notifyListeners();
  }

  void setSizeOfImages(String size) {
    _size_of_images = size;
    notifyListeners();
  }

  void setNumberOfImages(int num) {
    _number_of_images = num;
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
        partialResults: false
      );
    }
    notifyListeners();
  }

  void stopListening() async {
    await _speechToText.stop();
    _is_speaking = false;
    if (_image_input_controller.text != "") {
      _image_input_controller.text = _image_input_controller.text;
      _isTyping = true;
    }
    notifyListeners();
  }

  void _onSpeechResult(SpeechRecognitionResult result) {
    _image_input_controller.text = result.recognizedWords;
    if (!_speechToText.isListening) stopListening();
    notifyListeners();
  }
}

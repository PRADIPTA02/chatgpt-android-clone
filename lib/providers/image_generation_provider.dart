// ignore_for_file: non_constant_identifier_names

import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:permission_handler/permission_handler.dart';
import '../models/image_model.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';

class ImageGenerationProvider with ChangeNotifier {
  final SpeechToText _speechToText = SpeechToText();
  bool _is_image_loading = false;
  final Dio dio = Dio();
  bool _is_speaking = false;
  bool _is_avalable = false;
  double _progress = 0.0;
  double get progress => _progress;
  bool _isTyping = false;
  bool _image_downloading = false;
  bool get isImageDownloading => _image_downloading;
  int _number_of_images = 1;
  String _size_of_images = '256x256';
  String _get_image_view_type = "list";
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
    "surreal blueish monk, dodecahedron for his head, amazing details, hyperrealistic photograph, octane made of billions of intricate small houses, GODLIKE, bokeh, photography on mars, cinematic lighting, --ar 9:21",
    "2 medieval warriors ::0.4 travelling on a cliff to a background castle , view of a coast line landscape , English coastline, Irish coastline, scottish coastline, perspective, folklore, King Arthur, Lord of the Rings, Game of Thrones. Photographic, Photography, photorealistic, concept art, Artstation trending , cinematic lighting, cinematic composition, rule of thirds , ultra-detailed, dusk sky , low contrast, natural lighting, fog, realistic, light fogged, detailed, atmosphere hyperrealistic , volumetric light, ultra photoreal, | 35mm| , Matte painting, movie concept art, hyper-detailed, insanely detailed, corona render, octane render, 8k, --ar 3:1 --no blur",
    "viking north druid lich mermaid king wise old man god of death witch pagan face portrait, underwater, covered in runes, crown made of bones, necromancer, zdzisław beksiński, mikhail vrubel, hr giger, gustav klimt, symmetry, mystical occult symbol in real life, high detail, green light --ar 9:16",
    "full body character + beautiful female neopunk wizard opening a portal to the sidereal multiverse :: Mandelbrot neuro web :: intricate galaxy inlay + ultra high detail, plasma neon internal glow, precise :: consciousness projection :: astral projection :: laser sharp, octane render + unreal render + photo real :: 8k, volumetric lighting high contrast --uplight --quality 2 --stop 80 --ar 9:16",
    "Samhain figure, creature, wicca, occult, harvest, fall, hyper-realistic, ultra resolution, creepy, dark, witchcore",
    "a seamless tileable jade tree pattern, spiral carvings, octane renderer, trending on CGsociety --ar 1:1 --q 2",
    "hyerophant, god light, cinematic look, octane render, under water, --wallpaper",
    "Sophia Loren in a heart shaped bath tub surrounded by rubber ducks:: hightly detailed, hyper realistic, photographic, wide angle lens:: in the style of Richard Avedon, Patrick Demarchelier, Vogue, Baron Adolphe De Meyer:: --ar 9:16 --q 2",
    "Reunion of man, team, squad, cyberpunk, abstract, full hd render + 3d octane render +4k UHD + immense detail + dramatic lighting + well lit + black, purple, blue, pink, cerulean, teal, metallic colours, + fine details + octane render + 8k",
    "modern kids play area landscape architecture, water play area, floating kids, seating areas, perspective view, rainy weather, biopunk, cinematic photo, highly detailed, cinematic lighting, ultra-detailed, ultrarealistic, photorealism, 8k, octane render, --ar 16:12",
    "Lovecraftian character Cthulhu, with the hunter hat, and the saw cleaver, with bloodborne weapons, full body, in the style bloodborne style, full body, dark fantasy, trending on ArtStation, --ar 4:5",
    "photorealistic flying house, many details, Ultra detailed, octane render, by Alexander Jansson --ar 2:1",
    "Swirls :: fog :: phantom + ghost + dog + glowing eyes + bright silver ::3 smoke + shine + sphere:: black paper + elements + dark grey + dark blue + neon + baroque + rococo + white + ink + tarot card with ornate border frame + sébastien mitton, viktor antonov, sergey kolesov, detailed, intricate ink illustration + magic + glow --ar 63:88",
    "full page technical drawing technocore mind meld evil-god symmetric::2 Hieroglyphic Occult::.5 esoterism hyper realistic, rendered, 8K, old, neon, vibrant fine details symmetric --ar 9:16",
    "Wet chitinous texture, greasy --q 2 --s 12000",
    "tyriel archangel, king shamn , avatar , swords , angel wings . 4k , unreal engine --wallpaper",
    "ultra quality. hyper realistic smiling rubber duck with 4 wings, intricate silver, intricate brown and orange, neon armor, ornate, cinematic lighting, floral, symetric, portrait, statue cyberpunk, abstract, full hd render + 3d octane render +4k UHD + immense detail + dramatic lighting + well lit + black, purple, blue, pink, cerulean, teal, metallic colours, + fine details + octane render + 8k, abstract",
    "orange looking like water-universe-Earth in the background is a dusty wooden desk, room interior, realistic, abstract art, cinematic bright lighting, colorful, foggy, smokes --ar 16:9",
    "dense woodland landscape, ::0.4 , English forest, Irish forest, scottish forest, perspective, folklore,King Arthur, Lord of the Rings, Game of Thrones. ultra photoreal , photographic, concept art, cinematic lighting, cinematic composition, rule of thirds , mysterious, eerie, cinematic lighting, ultra-detailed, ultrarealistic, photorealism, 8k, octane render, Albert Bierstadt --ar 16:12",
    "arch demon, god, underworld, reclaim, throne, characters, wandering, showing off his power, decimating a large nation, Control, Controlling mass power, realistic, cinematic, high detail, hyper detailed, magic, copper, gold, black, red, green, purple, crimson, smoke, particles, Beam of light, necromancy, divination, supernatural powers, omen, hidden knowledge, event, foresee, foretell, fortold, art, fantasy, towering stature, grandiose, overpowering render, dark fantasy, unreal engine, raytracing, post-processing, zbrush, substance painter, trending on ArtStation, epic perspective, composition, photorealistic, vfx, cgsociety, volumetric lighting, + cinematic + photo + realism + high detail, cgi, 8k, --ar 16:9",
    "an oil pastel drawing of an annoyed cat in a spaceship",
    "3D render of a small pink balloon dog in a light pink room",
    "teddy bears shopping for groceries, one-line drawing",
    "a fortune-telling shiba inu reading your fate in a giant hamburger, digital art",
    "an oil pastel drawing of an annoyed cat in a spaceship",
    "a stained glass window depicting a hamburger and french fries",
    "a cat submarine chimera, digital art",
    "an astronaut playing basketball with cats in space, digital art",
    "panda mad scientist mixing sparkling chemicals, digital art",
    "a macro 35mm photograph of two mice in Hawaii, they're each wearing tiny swimsuits and are carrying tiny surf boards, digital art",
    "dense woodland landscape, ::0.4 , English forest, Irish forest, scottish forest, perspective, folklore,King Arthur, Lord of the Rings, Game of Thrones. ultra photoreal , photographic, concept art, cinematic lighting, cinematic composition, rule of thirds , mysterious, eerie, cinematic lighting, ultra-detailed, ultrarealistic, photorealism, 8k, octane render, Albert Bierstadt --ar 16:12",
    "fibonacci, stone, snail, wallpaper, colorful, blue gray green, 3d pattern, 8k",
    "hungarian parliament underwater-beach, palm trees behind, aerial shot, real photography, unreal-engine, 4k, highly detailed --wallpaper --uplight",
    "secret vintage photo of rubber duck commitng war crimes in World war 2, why is he did that. --ar 4:5",
    "secret vintage photo of rubber duck commitng war crimes in World war 2, why is he did that. --ar 4:5",
    "synthwave galaxy being eaten by Galactus, HDR, cinematic, ultrawide, realistic, highly detailed --aspect 16:9 --quality 2 --stylize 650",
    "Stockholm city hall, but built in the medeival style, Photorealism, extreme detail, dusk, pink skies, aspect ratio = 6:4",
    "pale young man sitting in an armchair reading beside a big fireplace, bookshelves covering the dark walls, dogs lying on the floor, rule of thirds, dark room, --ar 21:9",
  ];
  void getImages(String name) async {
    _images = [];
    setImageLoading();

    try {
      var url = 'https://api.openai.com/v1/images/generations';

      var headers = {
        'Content-Type': 'application/json',
        'Authorization':
            'Bearer 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',
      };
      var payload = {
        'n': _number_of_images,
        'size': _size_of_images,
        'prompt': name,
      };
      var response = await dio.post(
        url,
        options: Options(headers: headers),
        data: jsonEncode(payload),
      );
      if (response.statusCode == 200) {
        Map<String, dynamic> newResponse = response.data;
        for (dynamic item in newResponse['data']) {
          addImages(Images(
              url: item['url'],
              imageHeight: _size_of_images,
              imageWidtht: _size_of_images));
        }

        setImageLoading();
        onChangeTextInput("");
        setImageLoading();
      } else {}
    } catch (e) {
      Fluttertoast.showToast(
          msg: "Error: Something went wrong",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.TOP,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.redAccent,
          textColor: Colors.white,
          fontSize: 16.0);
    }
    setImageLoading();
    notifyListeners();
  }

  Future<void> downloadFile(String url) async {
    bool downloaded = await saveFile(imageUrl: url);
    if (downloaded) {
      changeProgress(0.0);
      Fluttertoast.showToast(
          msg: "Image Downloaded",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.TOP,
          timeInSecForIosWeb: 1,
          backgroundColor: const Color.fromARGB(178, 85, 231, 85),
          textColor: Colors.white,
          fontSize: 16.0);
    } else {
      Fluttertoast.showToast(
          msg: "Error: Something went wrong",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.TOP,
          timeInSecForIosWeb: 1,
          backgroundColor: const Color.fromARGB(178, 231, 85, 85),
          textColor: Colors.white,
          fontSize: 16.0);
    }

    notifyListeners();
  }

  Future<bool> saveFile({required String imageUrl}) async {
    Directory? directory;
    try {
      if (await _requestPermission(Permission.storage)) {
        var time = DateTime.now().millisecondsSinceEpoch;
        var newPath = "/storage/emulated/0/Download/image-AIBuddy-$time.jpg";
        directory = Directory(newPath);
        debugPrint(directory.path);
      } else {
        return false;
      }
      File saveFile = File(directory.path);
      await dio.download(imageUrl, saveFile.path,
          onReceiveProgress: (rec, total) {
        changeProgress(rec / total);
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

  Future<void> downloadImage({required String url}) async {
    changeIsImageDownloading(true);
    await downloadFile(url);
    changeIsImageDownloading(false);
  }

  void giveRandomImageSuggetion() {
    final random = Random();
    final randomIndex = random.nextInt(topImageGenerationSuggetion.length);
    final randomString = topImageGenerationSuggetion[randomIndex];
    _image_input_controller.text = randomString;
    _isTyping = true;
    notifyListeners();
  }

  void changeProgress(double value) {
    _progress = value;
    notifyListeners();
  }

  void changeImageViewType(String type) {
    _get_image_view_type = type;
    notifyListeners();
  }

  void onChangeTextInput(String text) {
    _isTyping = text != "" ? true : false;
    notifyListeners();
  }

  void changeIsImageDownloading(bool value) {
    _image_downloading = value;
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
      _speechToText.listen(onResult: _onSpeechResult, partialResults: false);
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

import 'dart:io';
import 'package:chatgpt/providers/carousel_message_provider.dart';
import 'package:chatgpt/providers/image_generation_provider.dart';
import 'package:chatgpt/providers/internet_connection_check_provider.dart';
import 'package:chatgpt/providers/text_copletion_provider.dart';
import 'package:chatgpt/screens/chatScreen/chatScreen.dart';
import 'package:chatgpt/screens/homeScreen/home_screen.dart';
import 'package:chatgpt/screens/imageGenerationScreen/image_generate_screen.dart';
import 'package:chatgpt/screens/settingsScreen/settings_screen.dart';
import 'package:chatgpt/screens/startingScreen/start_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'models/message_list_conversation.dart';
import 'models/message_model.dart';
import 'models/message_session_list_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final InterNetConnectionCheck connectivityService = InterNetConnectionCheck();
  await connectivityService.startMonitoring();
  Directory document = await getApplicationDocumentsDirectory();
  Hive.init(document.path);
  Hive.registerAdapter(MessageAdapter());
  Hive.registerAdapter(MessageSessionListAdapter());
  Hive.registerAdapter(ConversationAdapter());
  await Hive.openBox<MessageSessionList>('sessionList');
  await Hive.openBox<Conversation>('messageList');
  runApp(MyApp(connectivityService: connectivityService));
}

class MyApp extends StatelessWidget {
  final InterNetConnectionCheck connectivityService;

  const MyApp({Key? key, required this.connectivityService}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ));
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => TextCompletProvider()),
        ChangeNotifierProvider(create: (_) => ImageGenerationProvider()),
        ChangeNotifierProvider(create: (_) => CarouselMessageProvider()),
        ChangeNotifierProvider.value(value: connectivityService),
      ],
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'ChatGPT',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: ChatScreen()),
    );
  }
}
 
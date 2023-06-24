import 'dart:io';
import 'package:chatgpt/providers/auth_provider.dart';
import 'package:chatgpt/providers/image_generation_provider.dart';
import 'package:chatgpt/providers/internet_connection_check_provider.dart';
import 'package:chatgpt/providers/text_copletion_provider.dart';
import 'package:chatgpt/screens/splashScreen/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'models/message_list_conversation.dart';
import 'models/message_model.dart';
import 'models/message_session_list_model.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'models/user_data_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  final InterNetConnectionCheck connectivityService = InterNetConnectionCheck();
  await connectivityService.startMonitoring();
  Directory document = await getApplicationDocumentsDirectory();
  Hive.init(document.path);
  Hive.registerAdapter(MessageAdapter());
  Hive.registerAdapter(MessageSessionListAdapter());
  Hive.registerAdapter(ConversationAdapter());
  Hive.registerAdapter(UserDataAdapter());
  await Hive.openBox<MessageSessionList>('sessionList');
  await Hive.openBox<Conversation>('messageList');
  await Hive.openBox<UserData>('userData');
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
          ChangeNotifierProvider(create: (_) => AuthProvider()),
          ChangeNotifierProvider(create: (_) => TextCompletProvider()),
          ChangeNotifierProvider(create: (_) => ImageGenerationProvider()),
          ChangeNotifierProvider.value(value: connectivityService),
        ],
        child: MaterialApp(
          useInheritedMediaQuery: true,
          debugShowCheckedModeBanner: false,
          title: 'AI BUDDY',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: const SplashScreen(),
        ));
  }
}

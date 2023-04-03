import 'package:chatgpt/screens/auth/loginScreen/login_screen.dart';
import 'package:chatgpt/screens/chatScreen/chatScreen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthScren extends StatelessWidget {
  const AuthScren({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot){
          if(snapshot.hasData){
            return const ChatScreen();
          }else{
            return const LoginScreen();
          }
         },
      )
    );
  }
}
import 'package:chatgpt/screens/auth/loginScreen/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../homeScreen/home_screen.dart';

class AuthScren extends StatelessWidget {
  const AuthScren({super.key});

  @override
  Widget build(BuildContext context) {
    return  StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot){
          if(snapshot.hasData){
            print(snapshot.data);
            return const HomeScreen();
          }else{
            return  LoginScreen();
          }
         },
    );
  }
}
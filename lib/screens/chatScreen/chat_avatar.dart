// ignore_for_file: must_be_immutable

import 'dart:io';

import 'package:chatgpt/providers/auth_provider.dart';
import 'package:chatgpt/util/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class ChatAvater extends StatelessWidget {
  ChatAvater({super.key, this.isApi = true});
  bool isApi;
  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(
      builder:(context, value, child) => isApi? const CircleAvatar(
          backgroundColor: secondaryColor,
          backgroundImage: AssetImage('assets/images/api_avater.png'),
        ):value.User_image!=""?CircleAvatar(
          backgroundColor: secondaryColor,
          backgroundImage: FileImage(File(value.User_image))
    ): const CircleAvatar(
          backgroundColor: secondaryColor,
          backgroundImage: AssetImage('assets/images/default_avatar.png')),);
  }
}

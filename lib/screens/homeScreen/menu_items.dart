import 'dart:io';
import 'package:chatgpt/models/home_screen_menu_item.dart';
import 'package:chatgpt/providers/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../util/constants/constants.dart';

class MenuItems {
  static List<MenuItem> itemsFirst = [itemProfile, itemSettings, itemShare];
  static const List<MenuItem> itemsSecond = [
    itemSignOut,
  ];
  static var itemProfile = MenuItem(
      text: 'Account',
      icon: Hero(
        tag: 'profile123',
        child: Consumer<AuthProvider>(
            builder: (context, value, child) => value.User_image == ""
                ? const CircleAvatar(
                    backgroundColor: secondaryColor,
                    backgroundImage:
                        AssetImage('assets/images/defaultAccountIcon.png'),
                  )
                : value.User_image.split('/').toList()[0] == 'assets'
                    ? CircleAvatar(
                        backgroundColor: secondaryColor,
                        backgroundImage: AssetImage(value.User_image),
                      )
                    : CircleAvatar(
                        backgroundImage: FileImage(File(value.User_image)),
                      )),
      ));
  static const itemSettings = MenuItem(
      text: 'Settings',
      icon: Icon(
        Icons.settings,
        color: Colors.white70,
      ));
  static const itemShare = MenuItem(
      text: 'Share',
      icon: Icon(
        Icons.share,
        color: Colors.white70,
      ));
  static const itemSignOut = MenuItem(
      text: 'Sign Out',
      icon: Icon(
        Icons.logout_rounded,
        color: Colors.white70,
      ));
}

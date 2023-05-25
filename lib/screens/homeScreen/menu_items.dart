import 'package:chatgpt/models/home_screen_menu_item.dart';
import 'package:chatgpt/util/constants/constants.dart';
import 'package:flutter/material.dart';

class MenuItems {
  static const List<MenuItem> itemsFirst = [itemProfile,itemSettings, itemShare];
  static const List<MenuItem> itemsSecond = [
    itemSignOut,
  ];
  static const itemProfile = MenuItem(
      text: 'Account',
      icon:Hero(
        tag: 'profile123',
        child: CircleAvatar(
          backgroundImage: AssetImage('assets/images/default_avatar.png'),
        ),
      )
      );
  static const itemSettings = MenuItem(
      text: 'Settings',
      icon: Icon(
        Icons.settings,
        color: cgSecondary,
      ));
  static const itemShare = MenuItem(
      text: 'Share',
      icon: Icon(
        Icons.share,
        color: Colors.white,
      ));
  static const itemSignOut = MenuItem(
      text: 'Sign Out',
      icon: Icon(
        Icons.logout_rounded,
        color: Colors.white,
      ));
}

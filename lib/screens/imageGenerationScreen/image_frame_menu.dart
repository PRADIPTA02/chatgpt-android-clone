import 'package:chatgpt/models/home_screen_menu_item.dart';
import 'package:chatgpt/util/constants/constants.dart';
import 'package:flutter/material.dart';

class MenuItems {
  static const List<MenuItem> itemsFirst = [itemDownload, itemShare];
  static const itemDownload = MenuItem(
      text: 'Download',
      icon: Icon(
        Icons.download_rounded,
        color: Colors.white,
      ));
  static const itemShare = MenuItem(
      text: 'Share',
      icon: Icon(
        Icons.send_rounded,
        color: Colors.white,
      ));
  
}
